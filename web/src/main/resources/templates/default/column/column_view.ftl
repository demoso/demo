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
        <div class="side-right-box">
            <div class="side-right-list">
                <ul>
                    <li class="item-box"><a href="javascript:void(0);"> HTML / CSS</a>
                        <ul class="hidden-item">
                            <li><a title="HTML 教程" href="//www.runoob.com/html/html-tutorial.html">HTML 教程</a></li>
                            <li><a title="HTML5 教程" href="//www.runoob.com/html/html5-intro.html">HTML5 教程</a></li>
                            <li><a title="CSS 教程" href="//www.runoob.com/css/css-tutorial.html">CSS 教程</a></li>
                            <li><a title="CSS3 教程" href="//www.runoob.com/css3/css3-tutorial.html">CSS3 教程</a></li>
                            <li><a title="Bootstrap3 教程sfdsfdsfdfdsfsdfd"
                                   href="//www.runoob.com/bootstrap/bootstrap-tutorial.html">Bootstrap3教程sfdsfdsfdfdsfsdfd
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
                    <li class="item-box"><a href="javascript:void(0);"> JavaScript</a>
                        <ul class="hidden-item">
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
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> 服务端</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> 数据库</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> 移动端</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> XML 教程</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> ASP.NET</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> Web Service</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> 开发工具</a>

                    </li>
                    <li class="item-box"><a href="javascript:void(0);" class="tit"> 网站建设</a>

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
        $(".side-right-list > ul > li").hover(function () {
            $(this).addClass("selected");
            $(this).children("ul").show();
        }, function () {
            $(this).removeClass("selected");
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
