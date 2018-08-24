/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net
|
+---------------------------------------------------------------------------
*/
package mblog.web.controller.site;


import mblog.modules.blog.service.ClassifyService;
import mblog.modules.column.service.ColumnService;
import mblog.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


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

	@RequestMapping(value = {"/", "/index", "*"})
    public String root() {
		return view(Views.INDEX);
	}

	@RequestMapping(value = {"/notfound"})
	public String error404() {
		return view(Views.NOT_FOUND);
	}

}
