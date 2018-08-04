/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package mblog.web.controller.site.user;

import mblog.base.data.Data;
import mblog.modules.blog.data.CommentVO;
import mblog.modules.blog.data.FavorVO;
import mblog.modules.blog.data.FeedsVO;
import mblog.modules.blog.data.PostVO;
import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.service.*;
import mblog.modules.code.data.Code;
import mblog.modules.code.service.CodeService;
import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.service.ColumnService;
import mblog.modules.user.data.AccountProfile;
import mblog.modules.user.data.BadgesCount;
import mblog.modules.user.data.NotifyVO;
import mblog.modules.user.data.UserVO;
import mblog.modules.user.service.FollowService;
import mblog.modules.user.service.NotifyService;
import mblog.modules.user.service.UserService;
import mblog.shiro.authc.AccountSubject;
import mblog.web.controller.BaseController;
import mblog.web.controller.site.Views;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 用户主页
 * @author langhsu
 *
 */
@Controller
public class UserController extends BaseController {
	@Autowired
	private PostService postService;
	@Autowired
	private FeedsService feedsService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private UserService userService;
	@Autowired
	private FollowService followService;
	@Autowired
	private FavorService favorService;
	@Autowired
	private NotifyService notifyService;
	@Autowired
	private ColumnService columnServic;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private CodeService codeService;

	/**
	 * 用户主页
	 * @param model
	 * @return
	 */
	@GetMapping("/user")
	public String home(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountSubject subject = getSubject();

		Page<FeedsVO> page = feedsService.findUserFeeds(pageable, subject.getProfile().getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_FEEDS);
	}

	/**
	 * 我发布的文章
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=posts")
	public String posts(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile up = getSubject().getProfile();
		Page<PostVO> page = postService.pagingByAuthorId(pageable, up.getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_POSTS);
	}


	/**
	 * 我发表的评论
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=comments")
	public String comments(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountSubject subject = getSubject();
		Page<CommentVO> page = commentService.paging4Home(pageable, subject.getProfile().getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_COMMENTS);
	}

	/**
	 * 我喜欢过的文章
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=favors")
	public String favors(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile profile = getSubject().getProfile();
		Page<FavorVO> page = favorService.pagingByOwnId(pageable, profile.getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_FAVORS);
	}

	/**
	 * 我的关注
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=follows")
	public String follows(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile profile = getSubject().getProfile();
		Page<UserVO> page = followService.follows(pageable, profile.getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_FOLLOWS);
	}

	/**
	 * 我的粉丝
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=fans")
	public String fans(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile profile = getSubject().getProfile();
		Page<UserVO> page = followService.fans(pageable, profile.getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_FANS);
	}

	/**
	 * 我的通知
	 * @param model
	 * @return
	 */
	@GetMapping(value="/user", params = "method=notifies")
	public String notifies(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile profile = getSubject().getProfile();
		Page<NotifyVO> page = notifyService.findByOwnId(pageable, profile.getId());
		// 标记已读
		notifyService.readed4Me(profile.getId());

		model.put("page", page);
		initUser(model);

		return view(Views.USER_NOTIFIES);
	}

	private void initUser(ModelMap model) {
		AccountProfile up = getSubject().getProfile();
		UserVO user = userService.get(up.getId());

		model.put("user", user);

		pushBadgesCount();
	}

	private void pushBadgesCount() {
		AccountProfile profile = (AccountProfile) session.getAttribute("profile");
		if (profile != null && profile.getBadgesCount() != null) {
			BadgesCount count = new BadgesCount();
			count.setNotifies(notifyService.unread4Me(profile.getId()));
			profile.setBadgesCount(count);
			session.setAttribute("profile", profile);
		}
	}

	/**
	 * 我的专栏
	 *
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user/columnlist")
	public String usercolumn(ModelMap model) {
		AccountProfile up = getSubject().getProfile();
		List<Columnlist> listcolumn = columnServic.findByAuthorId(up.getId());
		model.put("listcolumn", listcolumn);
		initUser(model);

		return view(Views.USER_COLLIST);
	}

	/**
	 * 我的分类
	 *
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user/classify")
	public String userclassify(ModelMap model) {
		AccountProfile up = getSubject().getProfile();
		List<Classify> classifys = classifyService.findByAuthorIdOrderByCreatedDesc(up.getId());
		model.put("classifys", classifys);
		initUser(model);

		return view(Views.USER_CLASSIFY);
	}

	/**
	 * 删除我的分类
	 *
	 * @param id
	 * @return
	 */
	@GetMapping(value = "/user/delclassify/{id}")
	public @ResponseBody
	Data delclassify(@PathVariable int id) {
		Data data = Data.failure("操作失败");
		AccountProfile up = getSubject().getProfile();
		Classify classify = classifyService.getById(id);
		if (classify != null && classify.getAuthorId() == up.getId()) {
			classifyService.delete(id);
			data = Data.success("操作成功", Data.NOOP);
		}
		return data;
	}

	/**
	 * 我发布的文章
	 *
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user/codelist")
	public String userCode(ModelMap model) {
		Pageable pageable = wrapPageable();
		AccountProfile up = getSubject().getProfile();
		Page<Code> page = codeService.pagingByAuthorId(pageable, up.getId());
		;
		model.put("page", page);
		initUser(model);
		return view(Views.USER_CODE);
	}

	/**
	 * 删除代码
	 *
	 * @param id
	 * @return
	 */
	@GetMapping("/user/codedelete/{id}")
	public @ResponseBody
	Data delete(@PathVariable Long id) {
		Data data = Data.failure("操作失败");
		if (id != null) {
			AccountProfile up = getSubject().getProfile();
			try {
				codeService.delete(id, up.getId());
				data = Data.success("操作成功", Data.NOOP);
			} catch (Exception e) {
				data = Data.failure(e.getMessage());
			}
		}
		return data;
	}


}
