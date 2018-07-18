/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package mblog.web.controller.site.tools;


import mblog.modules.code.data.Code;
import mblog.modules.code.service.CodeService;
import mblog.modules.user.data.AccountProfile;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * 访问
 *
 * @author langhsu
 */
@Controller
public class ToolController extends BaseController {
    @Autowired
    private CodeService codeService;


    @RequestMapping("/codeview/web/{id}")
    public String codeview(@PathVariable Long id, ModelMap model) {
        Code ret = codeService.get(id);
        model.put("ret", ret);
        return view(Views.TOOLS_CODEVIEW);
    }

    @RequestMapping(value = "/codesave/{suburl}/{codetype}", method = RequestMethod.POST)
    public String home(@PathVariable String suburl, @PathVariable String codetype, HttpServletRequest request) {
        Code code = new Code();
        code.setId(System.currentTimeMillis());
        code.setContent(request.getParameter("textareaCode"));
        code.setTitle(request.getParameter("title"));
        if (StringUtils.isNotBlank(code.getTitle())) {
            AccountProfile profile = getSubject().getProfile();
            code.setAuthorId(profile.getId());
        }
        code.setSummary(request.getParameter("summary"));
        code.setTags(request.getParameter("tags"));
        code.setSuburl(suburl);
        code.setCodetype(codetype);
        codeService.saveCode(code);
        return "redirect:/codelist";
    }

    @RequestMapping("/codelist")
    public String codelist(Integer pn, ModelMap model) {
        Pageable pageable = wrapPageable();
        Page<Code> page = codeService.paging(pageable);
        model.put("page", page);
        return view(Views.TOOLS_CODELIST);
    }

    @RequestMapping("/coderun/{language}/{id}")
    public String coderun(@PathVariable String language, @PathVariable Long id, ModelMap model) {
        Code ret = codeService.get(id);
        model.put("ret", ret);
        model.put("language", language);
        return view(Views.TOOLS_CODERUN);
    }
}
