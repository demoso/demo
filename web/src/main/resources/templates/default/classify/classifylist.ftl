<#include "/default/utils/ui.ftl"/>

<#assign title = classname + ' - ' + site_name />
<#assign keywords = view.keywords?default(site_keywords) />
<#assign description = view.description?default(site_description) />

<@layout title>
<div class="row main">
    <div class="col-xs-12 col-md-8 side-left topics-show">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 分类: ${classname} 共 ${page.totalElements} 个结果.
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
                  <@showBlog row/>
              </#list>
              <#if page.content?size == 0>
                  <div class="stream-item">
                      <i class="fa fa-info-circle fa-lg"></i> 该分类下没发表过文章!
                  </div>
              </#if>
            </div>
        </div>
        <div class="text-center clr">
	          <@pager request.requestURI, page, 5/>
        </div>
    </div>
    <div class="col-xs-12 col-md-4 side-right hidden-xs hidden-sm">
        <div class="panel panel-default corner-radius panel-user-infos">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-user-circle"></i> 用户信息</h3>
            </div>
            <div class="panel-body list-body">
                <div class="right-user ">
                    <a style="width: 75%;display: inline-block;padding-left: 10px "
                       href="${base}/users/${user.id}">
                           <@showAva user.avatar "img-circle" />
                        <span class="midspan">${user.name}</span>
                    </a>

                    <a class="btn act_follow" href="javascript:void(0);" data-id="${user.id}" rel="follow"><i
                            class="icon icon-user-follow"></i> 关注</a>

                </div>
                <div class="about-user-datas">
                    <ul>
                        <li><strong>${user.posts}</strong><span>发布</span></li>
                        <li><strong>${user.comments}</strong><span>评论</span></li>
                        <li><strong>${user.favors}</strong><span>收藏</span></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="panel panel-default corner-radius panel-user-classify">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-user-circle"></i> 个人分类</h3>
            </div>
            <div class="panel-body list-body">
                <div class="user-classify-data row">
                        <#list classifys as row>
                            <div class="col-xs-6 atag">
                                <a href="/classify/${user.id}/${row.classname}">${row.classname}</a>
                            </div>
                        </#list>
                </div>
            </div>
        </div>
        <#include "/default/inc/right.ftl"/>
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
