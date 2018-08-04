package mblog.web.controller.site.column;


import com.alibaba.fastjson.JSONArray;
import mblog.base.data.Data;
import mblog.base.utils.FileNameUtils;
import mblog.base.utils.ImageUtils;
import mblog.modules.blog.data.PostVO;
import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.entity.Post;
import mblog.modules.blog.service.ClassifyService;
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
public class ColumnController extends BaseController {
    @Autowired
    private ColumnService columnService;
    @Autowired
    private PostService postService;
    @Autowired
    private ColumnattrService columnattrService;
    @Autowired
    ClassifyService classifyService;


    @RequestMapping(value = "/column/regfrom", method = RequestMethod.GET)
    public String regfromview(ModelMap model) {
        AccountProfile profile = getSubject().getProfile();
        if (profile != null)
            model.put("user", profile);
        //分类list
        List<Classify> classifys = classifyService.findByAuthorIdOrderByCreatedDesc(0);
        model.put("classifys", classifys);
        return view(Views.COl_REGFROM);

    }

    @RequestMapping(value = "/column/modifying/{id}", method = RequestMethod.GET)
    public String colmodify(@PathVariable int id, ModelMap model) {
        AccountProfile profile = getSubject().getProfile();
        if (profile != null)
            model.put("user", profile);

        Columnlist columnlist = columnService.findOne(id);
        Assert.isTrue(columnlist.getAuthorId() == profile.getId(), "该专栏不属于你");
        model.put("columnlist", columnlist);

        return view(Views.COl_REGFROM);
    }

    /**
     * 提交保存logo图片
     * @param
     * @return
     */
    @PostMapping("/column/logosubmit")
    public @ResponseBody
    String post(String path, Float x, Float y, Float width, Float height) {
        String deststr = null;
        if (org.springframework.util.StringUtils.isEmpty(path)) {
            deststr = "请选择图片";
            return deststr;
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

                ImageUtils.cutImage(temp, scalePath, x.intValue(), y.intValue(), width.intValue());

                // 对结果图片进行压缩
                ImageUtils.scaleImage(new File(scalePath), dest, 240);

                scale = new File(scalePath);
                deststr = ava100;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                temp.delete();
                if (scale != null) {
                    scale.delete();
                }
            }
        }
        return deststr;
    }

    /**
     * 提交保存专栏
     *
     * @param
     * @return
     */
    @PostMapping("/column/submit")
    public String post(Columnlist columnlist) throws IOException {
        Assert.notNull(columnlist, "参数不完整");
        Assert.state(StringUtils.isNotBlank(columnlist.getColname()), "专栏名不能为空");
        Assert.state(StringUtils.isNotBlank(columnlist.getComment()), "简介不能为空");
        AccountProfile profile = getSubject().getProfile();
        //设置属性
        columnlist.setAuthorId(profile.getId());
        // 修改时, 验证归属
        if (columnlist.getId() > 0) {
            Columnlist exist = columnService.findOne(columnlist.getId());
            Assert.notNull(exist, "专栏不存在");
            Assert.isTrue(exist.getAuthorId() == profile.getId(), "该专栏不属于你");
            columnService.updateColumnlist(columnlist.getColname(), columnlist.getComment(), columnlist.getLogo(), columnlist.getClassid(), columnlist.getId());
        } else {
            columnlist.setCreated(new Date());
            columnlist.setHot(100);
            columnlist.setIdxstatus(100);
            columnService.post(columnlist);
        }
        return "redirect:/user/columnlist";
    }


    /**
     * 删除专栏
     */
    @RequestMapping("/column/delete/{columnid}")
    public @ResponseBody
    Data deletebyid(@PathVariable Integer columnid) {
        Data data = Data.failure("操作失败");
        if (columnid != null) {
            AccountProfile up = getSubject().getProfile();
            try {
                columnattrService.deleteByColumnid(columnid, up.getId());
                columnService.delete(columnid, up.getId());
                data = Data.success("操作成功", Data.NOOP);

            } catch (Exception e) {
                data = Data.failure(e.getMessage());
            }
        }
        return data;
    }

    /**
     * 修改专栏文章列表
     */
    @GetMapping(value = "/column/artedit/{userid}/{id}/{colname}")
    public String myposts(ModelMap model, @PathVariable long userid, @PathVariable int id, @PathVariable String colname) {
        List<ColumnlistAttr> columnlistAttrList = columnattrService.findByColumnidOrderByHotAsc(id);
        Set<Long> ids = new HashSet<>();
        for (ColumnlistAttr columnlistAttr : columnlistAttrList) {
            ids.add(columnlistAttr.getUrl());
        }
        if (ids.isEmpty()) {
            ids.add(0l);
        }
        List<Post> postList = postService.findTOP30ByAuthorIdAndIdNotInOrderByCreatedDesc(userid, ids);
        model.put("columnlistAttrList", columnlistAttrList);
        model.put("postList", postList);
        model.put("colname", colname);
        model.put("id", id);

        return view(Views.COl_ARTICLE);
    }

    /**
     * 专栏文章整理保存
     */
    @PostMapping("/column/savecolattr/{columnid}")
    public @ResponseBody
    String savecollistattr(@RequestParam("data") String data, @PathVariable int columnid) {
        if (data != null && !"".equals(data)) {
            List<ColumnlistAttr> columnlistAttrs = JSONArray.parseArray(data, ColumnlistAttr.class);
            AccountProfile up = getSubject().getProfile();
            columnattrService.deleteByColumnid(columnid, up.getId());
            for (int i = 0; i < columnlistAttrs.size(); i++) {
                ColumnlistAttr columnlistAttr = columnlistAttrs.get(i);
                columnlistAttr.setColumnid(columnid);
                columnlistAttr.setCreated(new Date());
                columnlistAttr.setHot(i);
                columnattrService.post(columnlistAttr);
            }
        }
        return "ok";
    }

    /**
     * 专栏文章显示
     */
    @RequestMapping("/columnview/{columnid}/{id}")
    public String columnview(@PathVariable int columnid, @PathVariable int id, ModelMap model) {
        PostVO view = postService.get(id);
        Assert.notNull(view, "该文章已被删除");

        Columnlist columnlist = columnService.findOne(columnid);
        Assert.notNull(columnlist, "该专栏已被删除");

        List<ColumnlistAttr> columnlistAttrList = columnattrService.findByColumnidOrderByHotAsc(columnid);
        Assert.notNull(columnlistAttrList, "该专栏暂时无文章");

        ColumnlistAttr pre = null;
        ColumnlistAttr next = null;
        int next_state = 0;
        for (int i = 0; i < columnlistAttrList.size(); i++) {
            long cur_articleid = columnlistAttrList.get(i).getUrl();
            if (next_state == 1) {
                next = columnlistAttrList.get(i);
                break;
            }
            if (cur_articleid == id) {
                next_state = 1;
            }
            if (cur_articleid != id) {
                pre = columnlistAttrList.get(i);
            }

        }

        postService.identityViews(id);
        model.put("id", id);
        model.put("view", view);
        model.put("pre", pre);
        model.put("next", next);
        model.put("columnlist", columnlist);
        model.put("columnlistAttrList", columnlistAttrList);
        return view(Views.COL_VIEW);
    }

    /**
     * 专栏文章显示
     */
    @RequestMapping("/columnview/{columnid}")
    public String columnidview(@PathVariable int columnid, ModelMap model) {
        List<ColumnlistAttr> columnlistAttrList = columnattrService.findByColumnidOrderByHotAsc(columnid);
        Assert.notNull(columnlistAttrList, "该专栏暂时无文章");

        long id = columnlistAttrList.get(0).getUrl();
        PostVO view = postService.get(id);
        Assert.notNull(view, "该文章已被删除");

        Columnlist columnlist = columnService.findOne(columnid);
        Assert.notNull(columnlist, "该专栏已被删除");

        ColumnlistAttr pre = null;
        ColumnlistAttr next = null;
        int next_state = 0;
        for (int i = 0; i < columnlistAttrList.size(); i++) {
            long cur_articleid = columnlistAttrList.get(i).getUrl();
            if (next_state == 1) {
                next = columnlistAttrList.get(i);
                break;
            }
            if (cur_articleid == id) {
                next_state = 1;
            }
            if (cur_articleid != id) {
                pre = columnlistAttrList.get(i);
            }

        }

        postService.identityViews(id);
        model.put("id", id);
        model.put("view", view);
        model.put("pre", pre);
        model.put("next", next);
        model.put("columnlist", columnlist);
        model.put("columnlistAttrList", columnlistAttrList);
        return view(Views.COL_VIEW);
    }



}
