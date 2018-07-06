package mblog.web.controller.site.column;

import mblog.base.data.Data;
import mblog.base.utils.FileNameUtils;
import mblog.base.utils.ImageUtils;
import mblog.modules.blog.entity.Post;
import mblog.modules.blog.service.PostService;
import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.entity.ColumnlistAttr;
import mblog.modules.column.service.ColumnService;
import mblog.modules.column.service.ColumnattrService;
import mblog.modules.user.data.AccountProfile;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/column")
public class ColumnController extends BaseController {
    @Autowired
    private ColumnService columnServic;
    @Autowired
    private PostService postService;
    @Autowired
    private ColumnattrService columnattrService;

    @RequestMapping(value = "/uploadlogo", method = RequestMethod.GET)
    public String logoview() {
        return view(Views.COl_UPLOADLOGO);
    }

    @RequestMapping(value = "/regfrom", method = RequestMethod.GET)
    public String regfromview() {
        return view(Views.COl_REGFROM);
    }
    /**
     * 提交保存logo图片
     * @param
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
                System.out.println("dest:" + ava100);
                ImageUtils.cutImage(temp, scalePath, x.intValue(), y.intValue(), width.intValue());

                // 对结果图片进行压缩
                ImageUtils.scaleImage(new File(scalePath), dest, 100);

                scale = new File(scalePath);
                model.put("dest", ava100);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                temp.delete();
                if (scale != null) {
                    scale.delete();
                }
            }
        }
        return view(Views.COl_REGFROM);
    }

    /**
     * 提交保存专栏
     *
     * @param
     * @return
     */
    @PostMapping("/submit")
    public String post(Columnlist columnlist) throws IOException {
        System.out.println(columnlist.getColname());
        Assert.notNull(columnlist, "参数不完整");
        Assert.state(StringUtils.isNotBlank(columnlist.getColname()), "专栏名不能为空");
        Assert.state(StringUtils.isNotBlank(columnlist.getComment()), "简介不能为空");
        AccountProfile profile = getSubject().getProfile();
        System.out.println(profile.getId());
        columnlist.setAuthorId(profile.getId());
        // 修改时, 验证归属
//        if(columnlist.getId()>0){
//            columnlist exist=columnServic.
//        }
        columnlist.setCreated(new Date());
        columnlist.setHot(100);
        columnlist.setIdxstatus(100);
        columnServic.post(columnlist);
        return "redirect:/user/columnlist";
    }

    public static boolean isValidLong(String str) {
        try {
            Long.parseLong(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * 删除专栏
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete/{id}")
    public @ResponseBody
    Data deletebyid(@PathVariable Integer id) {
        Data data = Data.failure("操作失败");
        if (id != null) {
            AccountProfile up = getSubject().getProfile();
            try {
                columnServic.delete(id, up.getId());
                data = Data.success("操作成功", Data.NOOP);
            } catch (Exception e) {
                data = Data.failure(e.getMessage());
            }
        }
        return data;
    }

    /**
     * 我发布的文章forcolumn
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/artedit/{userid}/{id}/{colname}")
    public String myposts(ModelMap model, @PathVariable long userid, @PathVariable int id, @PathVariable String colname) {
        System.out.println(id + colname);
        List<ColumnlistAttr> columnlistAttrList = columnattrService.findByColumnidOrderByHotAsc(id);
        Set<Long> ids = new HashSet<>();
        for (ColumnlistAttr columnlistAttr : columnlistAttrList) {
            if (isValidLong(columnlistAttr.getUrl())) {
                long artid = Long.parseLong(columnlistAttr.getUrl());
                ids.add(artid);
            }

        }
        if (ids.isEmpty()) {
            ids.add(0l);
        }
        List<Post> postList = postService.findTOP30ByAuthorIdAndIdNotInOrderByCreatedDesc(userid, ids);
        model.put("columnlistAttrList", columnlistAttrList);
        model.put("postList", postList);

        return view(Views.COl_ARTICLE);
    }
}
