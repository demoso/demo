<#include "/default/utils/ui.ftl"/>

<@layout "关于我们">

<div class="row main">
    <div class="col-xs-12 col-md-9 side-left topics-show">
        <!-- view show -->
        <div class="topic panel panel-default">
            <div class="infos panel-heading">

                <h1 class="panel-title topic-title">关于我们</h1>

                <div class="meta inline-block">
                    <a class="author" href="#">官方团队</a>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="content-body entry-content panel-body ">
                <div class="markdown-body" id="emojify">
                    <p><strong>关于Demoso</strong><br/></p>
                    <p>是一个以IT技术内容为主的博客分享平台，在这里你能快速检索，交流和分享任何技术编程相关的问题及知识。我们致力于改变并提升人们获取知识的方式和效率，帮助更多的开发者获得成长与成功</p>
                    <p><strong>知识产权</strong><br/></p>
                    <p>网站内容来自用户自行发起，或转载于互联网，如有涉及到版权问题，请告诉我们，我们将会对其进行删除处理</p>

				</div>
            </div>
            <div class="panel-footer operate">
            </div>
            <div class="panel-footer operate">
                <div class="hidden-xs">
                    <div class="social-share" data-sites="weibo, wechat, facebook, twitter, google, qzone, qq"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!-- /view show -->
    </div>
    <div class="col-xs-12 col-md-3 side-right hidden-xs hidden-sm">
		<#include "/default/inc/right.ftl"/>
    </div>
</div>

</@layout>