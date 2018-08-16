<#include "/default/utils/ui.ftl"/>

<#assign title = view.title + ' - ' + site_name />
<#assign keywords = view.keywords?default(site_keywords) />
<#assign description = view.description?default(site_description) />

<@layout title>
<div class="row main">
    <div class="col-xs-12 col-md-2 hidden-xs hidden-sm">
        <div class="side-box">
            <div class="left-title">
                <a href="${base}/columnview/${columnlist.id}">
                    <span id="col-title"><i class="fa fa-th-list"></i> ${columnlist.colname}</span>
                </a>
            </div>
            <div class="leftcolumnlist">
            <#list columnlistAttrList as row >
                <#if row.csstype=='H3'>
                   <a target="_top" <#if id=row.url>
                      style="font-weight: bold;  color: rgb(255, 255, 255);  background-color: #0C9A9A;" </#if>
                      title="${row.title}" href="/columnview/${row.columnid}/${row.url}">${row.title?html}</a>
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
                    <div style="display: inline;margin-left: 15px">
                       <#if view.tagsArray??><i>标签：</i></#if>
                        <#list  view.tagsArray as tag>
                            <a class="tag-link" href="${base}/tag/${tag}">${tag}</a>
                        </#list>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="content-body entry-content panel-body ">
                <div class="markdown-body">
                    ${view.content}
                </div>
            </div>
            <div class="like-favor">
                <a class="label label-info" style="margin-right: 20px" href="javascript:void(0);" data-id="${view.id}"
                   rel="favor">
                    <i class="fa fa-star-o"></i> 收藏 <span style="padding-right: 5px">|</span><span
                        id="favors">${view.favors}</span>
                </a>
                <a class="label label-danger" href="javascript:void(0);">
                    <i class="fa fa-heart"></i> 赞赏支持
                </a>
            </div>
            <div class="panel-footer operate">
                <div class="social-share" style="float: right;margin-bottom: -10px"
                     data-sites="weibo, wechat, facebook, twitter, google, qzone, qq"></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <#if (pre?? || next??)>
        <div class="panel panel-default padding-md" style="margin-top: -21px">
            <div class="panel-body">
                <div class="col-sm-6 page-prev text-nowrap">
                    <#if pre??>
                        <b>上一篇:</b>
                        <a href="${base}/columnview/${columnlist.id}/${pre.url}">${pre.title}</a>
                    </#if>
                </div>
                <div class="col-sm-6 page-next text-nowrap">
                    <#if next??>
                        <b>下一篇:</b>
                        <a href="${base}/columnview/${columnlist.id}/${next.url}">${next.title}</a>
                    </#if>
                </div>
            </div>
        </div>
        </#if>
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
        <div class="right-title">
            <a href="javascript:void(0);">
                <span id="col-title"><i class="fa fa-th-list"></i> 分类导航</span>
            </a>
        </div>
        <div class="side-right-box">
            <div class="side-right-list">
                <ul>
                    <#list classify_column_map?keys as key>
                        <li class="item-box"><a href="javascript:void(0);"> ${key}</a>
                        <ul class="hidden-item">
                            <#list classify_column_map[key] as row >
                                <li><a title="${row.comment}" href="/columnview/${row.id}"><img
                                        class="img-circle img-wh" src="${row.logo}"/>${row.colname}</a></li>
                            </#list>
                        </ul>
                    </li>
                    </#list>
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
            $(this).children("ul").show();
        }, function () {
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
