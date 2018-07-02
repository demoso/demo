package mblog.web.controller.site.column;

import mblog.base.data.Data;
import mblog.base.utils.FileNameUtils;
import mblog.base.utils.ImageUtils;
import mblog.modules.column.service.ColumnService;
import mblog.modules.user.data.AccountProfile;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import mblog.modules.column.entity.Columnlist;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;

@Controller
@RequestMapping("/column")
public class ColumnController extends BaseController {
    @Autowired
    private ColumnService columnServic;

    @RequestMapping(value = "/editing", method = RequestMethod.GET)
    public String view() {
        return view(Views.COl_EDITING);
    }
    /**
     * 提交发布
     * @param post
     * @return
     */
    @PostMapping("/submit")
    public String post(String path, Float x, Float y, Float width, Float height, ModelMap model) {
        if (org.springframework.util.StringUtils.isEmpty(path)) {
            model.put("data", Data.failure("请选择图片"));
            return view(Views.COl_EDITING);
        }

        if (width != null && height != null) {
            String root = fileRepo.getRoot();
            File temp = new File(root + path);
            File scale = null;
            // 目标目录
            String ava100 = appContext.getCologoDir() + "/" + FileNameUtils.genFileName("jpg");
            String dest = root + ava100;
            try {
                // 判断父目录是否存在
                File f = new File(dest);
                if (!f.getParentFile().exists()) {
                    f.getParentFile().mkdirs();
                }
                // 在目标目录下生成截图
                String scalePath = f.getParent() + "/scalePath" + FileNameUtils.genFileName("jpg");
                System.out.println("scalePath:" + scalePath);
                System.out.println("temp:" + temp);
                System.out.println("dest:" + dest);
                ImageUtils.cutImage(temp, scalePath, x.intValue(), y.intValue(), width.intValue());

                // 对结果图片进行压缩
                ImageUtils.scaleImage(new File(scalePath), dest, 100);

                scale = new File(scalePath);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                temp.delete();
                if (scale != null) {
                    scale.delete();
                }
            }
//        Assert.notNull(columnlist, "参数不完整");
//        Assert.state(StringUtils.isNotBlank(columnlist.getColname()), "名字不能为空");
//        Assert.state(StringUtils.isNotBlank(columnlist.getComment()), "描述不能为空");
//        Assert.state(StringUtils.isNotBlank(columnlist.getLogo()), "LOGO不能为空");
//        columnServic.post(columnlist);
        }
        return view(Views.COl_EDITING);
    }
}
