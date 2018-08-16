/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package mblog.web.controller.site;

import mblog.base.lang.Consts;
import mblog.modules.blog.data.PostVO;
import mblog.modules.blog.entity.Channel;
import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.entity.Post;
import mblog.modules.blog.service.ChannelService;
import mblog.modules.blog.service.ClassifyService;
import mblog.modules.blog.service.PostService;
import mblog.modules.user.data.UserVO;
import mblog.modules.user.service.UserService;
import mblog.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Channel 主页
 * @author langhsu
 *
 */
@Controller
public class ChannelController extends BaseController {
	@Autowired
	private ChannelService channelService;
	@Autowired
	private PostService postService;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("/channel/{id}")
	public String channel(@PathVariable Integer id, ModelMap model,
			HttpServletRequest request) {
		// init params
		String order = ServletRequestUtils.getStringParameter(request, "order", Consts.order.NEWEST);
		int pn = ServletRequestUtils.getIntParameter(request, "pn", 1);

		Channel channel = channelService.getById(id);
		// callback params
		model.put("channel", channel);
		model.put("order", order);
		model.put("pn", pn);
		return view(Views.ROUTE_POST_INDEX);
	}

	@RequestMapping(value = {"/view/{id}", "/taview/{id}"})
	public String view(@PathVariable Long id, ModelMap model) {
		PostVO view = postService.get(id);

		Assert.notNull(view, "该文章已被删除");
		List<Classify> classifys = classifyService.findByAuthorIdOrderByCreatedDesc(view.getAuthorId());
		List<Object[]> postList = postService.queryByAuthorIdOrderByCreatedDesc(view.getAuthorId());
		Post pre = null;
		Post next = null;
		int next_state = 0;
		for (int i = 0; i < postList.size(); i++) {
			long cur_articleid = (Long) postList.get(i)[0];
			if (next_state == 1) {
				next = new Post();
				next.setId((Long) postList.get(i)[0]);
				next.setTitle((String) postList.get(i)[1]);
				break;
			}
			if (cur_articleid == id) {
				next_state = 1;
			}
			if (cur_articleid != id) {
				pre = new Post();
				pre.setId((Long) postList.get(i)[0]);
				pre.setTitle((String) postList.get(i)[1]);
			}
		}

		postService.identityViews(id);
		model.put("pre", pre);
		model.put("next", next);
		model.put("view", view);
		model.put("classifys", classifys);
		return view(Views.ROUTE_POST_VIEW);
	}

	@RequestMapping("/classify/{authorId}/{classname}")
	public String classify(@PathVariable Long authorId, @PathVariable String classname, ModelMap model) {
		Pageable pageable = wrapPageable();
		Page<PostVO> page = postService.pagingByAuthorIdAndMyclassifysLike(pageable, authorId, "%" + classname + "%");
		model.put("page", page);

		List<Classify> classifys = classifyService.findByAuthorIdOrderByCreatedDesc(authorId);
		model.put("classifys", classifys);

		UserVO user = userService.get(authorId);
		model.put("user", user);

		model.put("classname", classname);
		return view(Views.ROUTE_CLASSIFY_LIST);
	}
}
