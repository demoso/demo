package mblog.web.controller.site.column;

import mblog.base.data.Data;
import mblog.base.utils.FileNameUtils;
import mblog.base.utils.ImageUtils;
import mblog.modules.column.service.ColumnService;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;

@Controller
@RequestMapping("/column")
public class ColumnController extends BaseController {
    @Autowired
    private ColumnService columnServic;

    @RequestMapping(value = "/uploadlogo", method = RequestMethod.GET)
    public String logoview() {
        return view(Views.COl_UPLOADLOGO);
    }

    @RequestMapping(value = "/regfrom", method = RequestMethod.GET)
    public String regfromview() {
        return view(Views.COl_REGFROM);
    }
    /**
     * 提交发布
     * @param post
     * @return
     */
    @PostMapping("/logosubmit")
    public String post(String path, Float x, Float y, Float width, Float height, ModelMap model) {
        if (org.springframework.util.StringUtils.isEmpty(path)) {
            model.put("data", Data.failure("请选择图片"));
            return view(Views.COl_UPLOADLOGO);
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
                model.put("destpath", dest);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                temp.delete();
                if (scale != null) {
                    scale.delete();
                }
            }
        }
        return view(Views.COl_UPLOADLOGO);
    }
}
