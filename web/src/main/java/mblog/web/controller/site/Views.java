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

/**
 * 
 * 返回页面配置
 * 
 * @author langhsu
 *
 */
public interface Views {
	String LOGIN = "/auth/login";
	String REGISTER = "/auth/register";
	String REGISTER_RESULT = "/auth/register_result";
	String OAUTH_REGISTER = "/auth/oauth_register";

	String FORGOT_APPLY = "/auth/forgot_apply";
	String FORGOT_RESET = "/auth/forgot_reset";

	String INDEX = "/index";
    String NOT_FOUND = "/error/page404";

	String USER_FEEDS = "/user/method_feeds";
	String USER_POSTS = "/user/method_posts";
    String USER_CODE = "/user/codelist";

	String USER_COMMENTS = "/user/method_comments";
	String USER_FOLLOWS = "/user/method_follows";
	String USER_FAVORS = "/user/method_favors";
	String USER_FANS = "/user/method_fans";
	String USER_NOTIFIES = "/user/method_notifies";

	String REDIRECT_USER = "redirect:/user";
	String REDIRECT_USER_POSTS = "redirect:/user?method=posts";

	String USER_AVATAR = "/user/avatar";
	String USER_PASSWORD = "/user/password";
	String USER_PROFILE = "/user/profile";
	String USER_EMAIL = "/user/email";

	String USERS_VIEW = "/users/view";

	String TAGS_TAG = "/tag";
	
	String BROWSE_SEARCH = "/search";

	String ROUTE_POST_EDITING = "/channel/editing";
	String ROUTE_POST_INDEX = "/channel/index";
	String ROUTE_POST_VIEW = "/channel/view";
	String ROUTE_CLASSIFY_LIST = "/classify/classifylist";
	String COl_REGFROM = "/column/regfrom";
	String USER_COLLIST = "/user/column_list";
    String USER_CLASSIFY = "/user/user_classify";
	String COl_ARTICLE = "/column/column_article";
	String COL_VIEW = "/column/column_view";
    String TOOLS_CODEVIEW = "/tools/codeview";
    String TOOLS_CODELIST = "/tools/codelist";
    String TOOLS_CODERUN = "/tools/coderun";
    String TOOLS_UPDATEVIEW = "/tools/updateview";
}
