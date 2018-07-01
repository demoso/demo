package mblog.web.controller.site.column;

import mblog.modules.column.service.ColumnService;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import mblog.modules.column.entity.Columnlist;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/column")
public class ColumnController extends BaseController {
    @Autowired
    private ColumnService columnServic;

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view() {
        return view(Views.COl_EDITING);
    }
    /**
     * 提交发布
     * @param post
     * @return
     */
    @PostMapping("/submit")
    public String post(Columnlist columnlist){
        Assert.notNull(columnlist, "参数不完整");
        Assert.state(StringUtils.isNotBlank(columnlist.getColname()), "名字不能为空");
        Assert.state(StringUtils.isNotBlank(columnlist.getComment()), "描述不能为空");
        Assert.state(StringUtils.isNotBlank(columnlist.getLogo()), "LOGO不能为空");
        columnServic.post(columnlist);
        return "";
    }

}
