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

import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.service.ClassifyService;
import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.service.ColumnService;
import mblog.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author langhsu
 *
 */
@Controller
public class IndexController extends BaseController{
	@Autowired
	ColumnService columnService;
	@Autowired
	ClassifyService classifyService;
	
	@RequestMapping(value= {"/", "/index"})
	public String root(ModelMap model, HttpServletRequest request) {
//		String order = ServletRequestUtils.getStringParameter(request, "order", Consts.order.NEWEST);
//		int pn = ServletRequestUtils.getIntParameter(request, "pn", 1);
//		model.put("order", order);
//		model.put("pn", pn);
		Map<String, List<Columnlist>> map = new HashMap<>();
		//专栏list
		List<Columnlist> columnlists = columnService.findByIdxstatusOrderByHot(1);
		//分类list
		List<Classify> classifies = classifyService.findByAuthorIdOrderByCreatedDesc(0);
		//根据分类来遍历
		for (Classify classify : classifies) {
			List<Columnlist> listcol = new ArrayList<Columnlist>();
			//重新新封装
			for (Columnlist columnlist : columnlists) {
				if (classify.getId() == columnlist.getClassid()) {
					listcol.add(columnlist);
				}
			}
			if (listcol.size() != 0)
				map.put(classify.getClassname(), listcol);
		}

		model.put("map", map);
		return view(Views.INDEX);
	}

}
