<#include "/default/utils/ui.ftl"/>

<#assign title = view.title + ' - ' + site_name />
<#assign keywords = view.keywords?default(site_keywords) />
<#assign description = view.description?default(site_description) />

<@layout title>
<div class="row main">
    <div class="col-xs-12 col-md-2 hidden-xs hidden-sm">
        <div class="side-box">
            <div class="left-title">
                <a href="${base}/column/view/${columnlist.id}">
                    <span id="col-title"><i class="fa fa-th-list"></i> ${columnlist.colname}</span>
                </a>
            </div>
            <div class="leftcolumnlist">
            <#list columnlistAttrList as row >
                <#if row.csstype=='H3'>
                   <a target="_top" <#if id=row.url>
                      style="font-weight: bold;  color: rgb(255, 255, 255);  background-color: #0C9A9A;" </#if>
                      title="${row.title}" href="/column/view/${row.columnid}/${row.url}">${row.title}</a>
                <#else>
                    <h2 class="leftcolumn-h2"><span class="left-h2">${row.title}</span></h2>
                </#if>
            </#list>

            </div>
        </div>
    </div>
    <div class="col-xs-12 col-md-8 side-left topics-show">
        <!-- view show -->
        <div class="topic panel panel-default">
            <div class="infos panel-heading">

                <h1 class="panel-title topic-title">${view.title}</h1>

                <div class="meta inline-block">

                    <a class="author" href="${base}/users/${view.author.id}">
                        ${view.author.name}
                    </a>
                    <abbr class="timeago">${timeAgo(view.created)}</abbr>
                    ⋅
                    ${view.views} 阅读

                </div>
                <div class="clearfix"></div>
            </div>

            <div class="content-body entry-content panel-body ">
                <div class="markdown-body">
                    ${view.content}
                </div>
            </div>
            <div class="panel-footer operate">
                <#list view.tagsArray as tag>
                    <span>
                            <a class="label label-default" href="${base}/tag/${tag}/">#${tag}</a>
                        </span>
                </#list>
            </div>
            <div class="panel-footer operate">
                <div class="hidden-xs">
                    <div class="social-share" data-sites="weibo, wechat, facebook, twitter, google, qzone, qq"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- Comments -->
        <div id="chat" class="chats shadow-box">
            <div class="chat_other">
                <h4>全部评论: <i id="chat_count">0</i> 条</h4>
            </div>
            <ul id="chat_container" class="its"></ul>
            <div id="pager" class="text-center"></div>
            <div class="cbox-wrap">
                <div class="cbox-title">我有话说: <span id="chat_reply" style="display:none;">@<i
                        id="chat_to"></i></span>
                </div>
                <div class="cbox-post">
                    <div class="cbox-input">
                        <textarea id="chat_text" rows="3" placeholder="请输入评论内容"></textarea>
                        <input type="hidden" value="0" name="chat_pid" id="chat_pid"/>
                    </div>
                    <div class="cbox-ats clearfix">
                        <div class="ats-func">
                            <ul class="func-list">
                                <li class="list-b">
                                    <a href="javascript:void(0);" class="join" id="c-btn"><i
                                            class="fa fa-smile-o fa-2"></i></a>
                                </li>
                            </ul>
                        </div>
                        <div class="ats-issue">
                            <button id="btn-chat" class="btn btn-success btn-sm bt">发送</button>
                        </div>
                    </div>
                </div>
                <div class="phiz-box" id="c-phiz" style="display:none">
                    <div class="phiz-list" view="c-phizs"></div>
                </div>
            </div>
        </div>
        <!-- /view show -->
    </div>
    <div class="col-xs-12 col-md-2 right-box hidden-xs hidden-sm">
        <div class="sidebar-box">
            <div class="sidebar-tree">
                <ul>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> HTML / CSS</a>
                        <ul class="double-li">
                            <li><a title="HTML 教程" href="//www.runoob.com/html/html-tutorial.html">HTML 教程</a></li>
                            <li><a title="HTML5 教程" href="//www.runoob.com/html/html5-intro.html">HTML5 教程</a></li>
                            <li><a title="CSS 教程" href="//www.runoob.com/css/css-tutorial.html">CSS 教程</a></li>
                            <li><a title="CSS3 教程" href="//www.runoob.com/css3/css3-tutorial.html">CSS3 教程</a></li>
                            <li><a title="Bootstrap3 教程" href="//www.runoob.com/bootstrap/bootstrap-tutorial.html">Bootstrap3
                                教程</a></li>
                            <li><a title="Bootstrap4 教程" href="//www.runoob.com/bootstrap4/bootstrap4-tutorial.html">Bootstrap4
                                教程</a></li>
                            <li><a title="Font Awesome 教程"
                                   href="//www.runoob.com/font-awesome/fontawesome-tutorial.html">Font Awesome 教程</a>
                            </li>
                            <li><a title="Foundation 教程" href="//www.runoob.com/foundation/foundation-tutorial.html">Foundation
                                教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> JavaScript</a>
                        <ul class="double-li">
                            <li><a title="JavaScript 教程" href="//www.runoob.com/js/js-tutorial.html">JavaScript 教程</a>
                            </li>
                            <li><a title="HTML DOM 教程" href="//www.runoob.com/htmldom/htmldom-tutorial.html">HTML DOM
                                教程</a></li>
                            <li><a title="jQuery 教程" href="//www.runoob.com/jquery/jquery-tutorial.html">jQuery 教程</a>
                            </li>
                            <li><a title="AngularJS 教程" href="//www.runoob.com/angularjs/angularjs-tutorial.html">AngularJS
                                教程</a></li>
                            <li><a title="AngularJS2 教程" href="//www.runoob.com/angularjs2/angularjs2-tutorial.html">AngularJS2
                                教程</a></li>
                            <li><a title="Vue.js 教程" href="//www.runoob.com/vue2/vue-tutorial.html">Vue.js 教程</a></li>
                            <li><a title="React 教程" href="//www.runoob.com/react/react-tutorial.html">React 教程</a></li>
                            <li><a title="jQuery UI 教程" href="//www.runoob.com/jqueryui/jqueryui-tutorial.html">jQuery
                                UI 教程</a></li>
                            <li><a title="jQuery EasyUI 教程" href="//www.runoob.com/jeasyui/jqueryeasyui-tutorial.html">jQuery
                                EasyUI 教程</a></li>
                            <li><a title="Node.js 教程" href="//www.runoob.com/nodejs/nodejs-tutorial.html">Node.js 教程</a>
                            </li>
                            <li><a title="AJAX 教程" href="//www.runoob.com/ajax/ajax-tutorial.html">AJAX 教程</a></li>
                            <li><a title="JSON 教程" href="//www.runoob.com/json/json-tutorial.html">JSON 教程</a></li>
                            <li><a title="Highcharts 教程" href="//www.runoob.com/highcharts/highcharts-tutorial.html">Highcharts
                                教程</a></li>
                            <li><a title="Google 地图 教程" href="//www.runoob.com/googleapi/google-maps-basic.html">Google
                                地图 教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> 服务端</a>
                        <ul class="double-li">
                            <li><a title="PHP 教程" href="//www.runoob.com/php/php-tutorial.html">PHP 教程</a></li>
                            <li><a title="Python 教程" href="//www.runoob.com/python/python-tutorial.html">Python 教程</a>
                            </li>
                            <li><a title="Python3 教程" href="//www.runoob.com/python3/python3-tutorial.html">Python3
                                教程</a></li>
                            <li><a title="Django 教程" href="//www.runoob.com/django/django-tutorial.html">Django 教程</a>
                            </li>
                            <li><a title="Linux 教程" href="//www.runoob.com/linux/linux-tutorial.html">Linux 教程</a></li>
                            <li><a title="Docker 教程" href="//www.runoob.com/docker/docker-tutorial.html">Docker 教程</a>
                            </li>
                            <li><a title="Ruby 教程" href="//www.runoob.com/ruby/ruby-tutorial.html">Ruby 教程</a></li>
                            <li><a title="Java 教程" href="//www.runoob.com/java/java-tutorial.html">Java 教程</a></li>
                            <li><a title="C 教程" href="//www.runoob.com/c/c-tutorial.html">C 教程</a></li>
                            <li><a title="C++ 教程" href="//www.runoob.com/cplusplus/cpp-tutorial.html">C++ 教程</a></li>
                            <li><a title="Perl 教程" href="//www.runoob.com/perl/perl-tutorial.html">Perl 教程</a></li>
                            <li><a title="Servlet 教程" href="//www.runoob.com/servlet/servlet-tutorial.html">Servlet
                                教程</a></li>
                            <li><a title="JSP 教程" href="//www.runoob.com/jsp/jsp-tutorial.html">JSP 教程</a></li>
                            <li><a title="Lua 教程" href="//www.runoob.com/lua/lua-tutorial.html">Lua 教程</a></li>
                            <li><a title="Scala 教程" href="//www.runoob.com/scala/scala-tutorial.html">Scala 教程</a></li>
                            <li><a title="Go 教程" href="//www.runoob.com/go/go-tutorial.html">Go 教程</a></li>
                            <li><a title="设计模式"
                                   href="//www.runoob.com/design-pattern/design-pattern-tutorial.html">设计模式</a></li>
                            <li><a title="正则表达式" href="//www.runoob.com/regexp/regexp-tutorial.html">正则表达式</a></li>
                            <li><a title="ASP 教程" href="//www.runoob.com/asp/asp-tutorial.html">ASP 教程</a></li>
                            <li><a title="AppML 教程" href="//www.runoob.com/appml/appml-tutorial.html">AppML 教程</a></li>
                            <li><a title="VBScript 教程" href="//www.runoob.com/vbscript/vbscript-tutorial.html">VBScript
                                教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> 数据库</a>
                        <ul class="double-li">
                            <li><a title="SQL 教程" href="//www.runoob.com/sql/sql-tutorial.html">SQL 教程</a></li>
                            <li><a title="Mysql 教程" href="//www.runoob.com/mysql/mysql-tutorial.html">Mysql 教程</a></li>
                            <li><a title="SQLite 教程" href="//www.runoob.com/sqlite/sqlite-tutorial.html">SQLite 教程</a>
                            </li>
                            <li><a title="MongoDB 教程" href="//www.runoob.com/mongodb/mongodb-tutorial.html">MongoDB
                                教程</a></li>
                            <li><a title="Redis 教程" href="//www.runoob.com/redis/redis-tutorial.html">Redis 教程</a></li>
                            <li><a title="Memcached 教程" href="//www.runoob.com/Memcached/Memcached-tutorial.html">Memcached
                                教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> 移动端</a>
                        <ul class="double-li">
                            <li><a title="Android 教程" href="//www.runoob.com/w3cnote/android-tutorial-intro.html">Android
                                教程</a></li>
                            <li><a title="Swift 教程" href="//www.runoob.com/swift/swift-tutorial.html">Swift 教程</a></li>
                            <li><a title="jQuery Mobile 教程"
                                   href="//www.runoob.com/jquerymobile/jquerymobile-tutorial.html">jQuery Mobile 教程</a>
                            </li>
                            <li><a title="ionic 教程" href="//www.runoob.com/ionic/ionic-tutorial.html">ionic 教程</a></li>
                            <li><a title="Kotlin 教程" href="//www.runoob.com/kotlin/kotlin-tutorial.html">Kotlin 教程</a>
                            </li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> XML 教程</a>
                        <ul class="double-li">
                            <li><a title="XML 教程" href="//www.runoob.com/xml/xml-tutorial.html">XML 教程</a></li>
                            <li><a title="DTD 教程" href="//www.runoob.com/dtd/dtd-tutorial.html">DTD 教程</a></li>
                            <li><a title="XML DOM 教程" href="//www.runoob.com/dom/dom-tutorial.html">XML DOM 教程</a></li>
                            <li><a title="XSLT 教程" href="//www.runoob.com/xsl/xsl-tutorial.html">XSLT 教程</a></li>
                            <li><a title="XPath 教程" href="//www.runoob.com/xpath/xpath-tutorial.html">XPath 教程</a></li>
                            <li><a title="XQuery 教程" href="//www.runoob.com/xquery/xquery-tutorial.html">XQuery 教程</a>
                            </li>
                            <li><a title="XLink 教程" href="//www.runoob.com/xlink/xlink-tutorial.html">XLink 教程</a></li>
                            <li><a title="XPointer 教程" href="//www.runoob.com/xlink/xlink-tutorial.html">XPointer 教程</a>
                            </li>
                            <li><a title="XML Schema 教程" href="//www.runoob.com/schema/schema-tutorial.html">XML Schema
                                教程</a></li>
                            <li><a title="XSL-FO 教程" href="//www.runoob.com/xslfo/xslfo-tutorial.html">XSL-FO 教程</a>
                            </li>
                            <li><a title="SVG 教程" href="//www.runoob.com/svg/svg-tutorial.html">SVG 教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> ASP.NET</a>
                        <ul class="double-li">
                            <li><a title="ASP.NET 教程" href="//www.runoob.com/aspnet/aspnet-tutorial.html">ASP.NET 教程</a>
                            </li>
                            <li><a title="C# 教程" href="//www.runoob.com/csharp/csharp-tutorial.html">C# 教程</a></li>
                            <li><a title="Web Pages 教程" href="//www.runoob.com/aspnet/webpages-intro.html">Web Pages
                                教程</a></li>
                            <li><a title="Razor 教程" href="//www.runoob.com/aspnet/razor-intro.html">Razor 教程</a></li>
                            <li><a title="MVC 教程" href="//www.runoob.com/aspnet/mvc-intro.html">MVC 教程</a></li>
                            <li><a title="Web Forms 教程" href="//www.runoob.com/aspnet/aspnet-intro.html">Web Forms
                                教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> Web Service</a>
                        <ul class="double-li">
                            <li><a title="Web Service 教程" href="//www.runoob.com/webservices/webservices-tutorial.html">Web
                                Service 教程</a></li>
                            <li><a title="WSDL 教程" href="//www.runoob.com/wsdl/wsdl-tutorial.html">WSDL 教程</a></li>
                            <li><a title="SOAP 教程" href="//www.runoob.com/soap/soap-tutorial.html">SOAP 教程</a></li>
                            <li><a title="RSS 教程" href="//www.runoob.com/rss/rss-tutorial.html">RSS 教程</a></li>
                            <li><a title="RDF 教程" href="//www.runoob.com/rdf/rdf-tutorial.html">RDF 教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> 开发工具</a>
                        <ul class="double-li">
                            <li><a title="Eclipse 教程" href="//www.runoob.com/eclipse/eclipse-tutorial.html">Eclipse
                                教程</a></li>
                            <li><a title="Git 教程" href="//www.runoob.com/git/git-tutorial.html">Git 教程</a></li>
                            <li><a title="Svn 教程" href="//www.runoob.com/svn/svn-tutorial.html">Svn 教程</a></li>
                            <li><a title="Firebug 教程" href="//www.runoob.com/firebug/firebug-tutorial.html">Firebug
                                教程</a></li>
                        </ul>
                    </li>
                    <li style="margin: 0;"><a href="javascript:void(0);" class="tit"> 网站建设</a>
                        <ul class="double-li">
                            <li><a title="HTTP 教程" href="//www.runoob.com/http/http-tutorial.html">HTTP 教程</a></li>
                            <li><a title="网站建设指南" href="//www.runoob.com/web/web-buildingprimer.html">网站建设指南</a></li>
                            <li><a title="浏览器信息" href="//www.runoob.com/browsers/browser-information.html">浏览器信息</a>
                            </li>
                            <li><a title="网站主机教程" href="//www.runoob.com/hosting/hosting-tutorial.html">网站主机教程</a></li>
                            <li><a title="TCP/IP 教程" href="//www.runoob.com/tcpip/tcpip-tutorial.html">TCP/IP 教程</a>
                            </li>
                            <li><a title="W3C 教程" href="//www.runoob.com/w3c/w3c-tutorial.html">W3C 教程</a></li>
                            <li><a title="网站品质" href="//www.runoob.com/quality/quality-tutorial.html">网站品质</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

    </div>
</div>

<script type="text/plain" id="chat_template">
    <li id="chat{5}">
        <a class="avt fl" target="_blank" href="${base}/users/{0}">
            <img src="${base}{1}">
        </a>
        <div class="chat_body">
            <h5>
                <div class="fl"><a class="chat_name" href="${base}/users/{0}">{2}</a><span>{3}</span></div>
                <div class="fr reply_this"><a href="javascript:void(0);" onclick="goto('{5}', '{2}')">[回复]</a></div>
                <div class="clear"></div>
            </h5>
            <div class="chat_p">
                <div class="chat_pct">{4}</div> {6}
            </div>
        </div>
        <div class="clear"></div>
        <div class="chat_reply"></div>
    </li>

</script>

<script type="text/javascript">
    $(function () {
        $(".sidebar-tree > ul > li").hover(function () {
            $(this).addClass("selected");
            $(this).children("a:eq(0)").addClass("h2-tit");
            $(this).children("ul").show();
        }, function () {
            $(this).removeClass("selected");
            $(this).children(".tit").removeClass("h2-tit");
            $(this).children("ul").hide();
        })
    })

    function goto(pid, user) {
        document.getElementById('chat_text').scrollIntoView();
        $('#chat_text').focus();
        $('#chat_text').val('');
        $('#chat_to').text(user);
        $('#chat_pid').val(pid);

        $('#chat_reply').show();
    }

    var container = $("#chat_container");
    var template = $('#chat_template')[0].text;

    seajs.use('comment', function (comment) {
        comment.init({
            load_url: '${base}/comment/list/${view.id}',
            post_url: '${base}/comment/submit',
            toId: '${view.id}',
            onLoad: function (i, data) {

                var content = ContentRender.wrapItem(data.content);

                var quoto = '';
                if (data.pid > 0 && !(data.parent === null)) {
                    var pat = data.parent;
                    var pcontent = ContentRender.wrapItem(pat.content);
                    quoto = '<div class="quote"><a href="${base}/users/' + pat.author.id + '">@' + pat.author.name + '</a>: ' + pcontent + '</div>';
                }
                var item = jQuery.format(template,
                        data.author.id,
                        data.author.avatar,
                        data.author.name,
                        data.created,
                        content,
                        data.id, quoto);
                return item;
            }
        });
    });

    seajs.use(['phiz', 'view'], function (phiz) {
        $("#c-btn").jphiz({
            base: '${base}/dist',
            textId: 'chat_text',
            lnkBoxId: 'c-lnk',
            phizBoxId: 'c-phiz'
        });
    });

</script>
</@layout>
