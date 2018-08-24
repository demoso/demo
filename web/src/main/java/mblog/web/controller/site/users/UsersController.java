/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net
|
+---------------------------------------------------------------------------
*/
package mblog.web.controller.site.users;

import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.service.ClassifyService;
import mblog.modules.user.data.UserVO;
import mblog.modules.user.service.UserService;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 访问他人主页
 * @author langhsu
 *
 */
@Controller
public class UsersController extends BaseController {
	@Autowired
	private UserService userService;
	@Autowired
	private ClassifyService classifyService;

	@RequestMapping(value = {"/users/{uid}", "/ta/{uid}"})
	public String home(@PathVariable Long uid, HttpServletRequest request, ModelMap model) {
		UserVO user = userService.get(uid);
		int pn = ServletRequestUtils.getIntParameter(request, "pn", 1);
		List<Classify> classifys = classifyService.findByAuthorIdOrderByCreatedDesc(uid);
		model.put("classifys", classifys);
		model.put("user", user);
		model.put("pn", pn);
		return view(Views.USERS_VIEW);
	}
}
