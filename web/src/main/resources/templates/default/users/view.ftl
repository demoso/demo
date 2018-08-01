<#include "/default/utils/ui.ftl"/>

<@layout user.name + "的主页">
<div class="row users-show streams">
    <div class="col-xs-12 col-md-8 side-left">
            <@author_contents uid=user.id pn=pn>
                <div class="shadow-box">
                    <div class="filter">
                        <div class="alert" style="margin-bottom:0">
                            <i class="fa fa-arrow-circle-right"></i> 他的文章
                        </div>
                    </div>
                    <div class="stream-list p-stream">
                             <#list results.content as row>
                                 <@showBlog row/>
                             </#list>
                            <#if results.content?size == 0>
                               <div class="stream-item">
                                   <i class="	fa fa-arrow-circle-right"></i> 该目录下还没有内容!
                               </div>
                            </#if>
                    </div>
                </div>

                <div class="text-center clr">
                    <@pager request.requestURI!"", results, 5/>
                </div>
            </@author_contents>
    </div>
    <div class="col-xs-12 col-md-4 side-right hidden-xs hidden-sm">
    <#--<span>-->
    <#--<#if user.signature?? && (user.signature?length > 0) >-->
    <#--${user.signature}-->
    <#--<#else>-->
    <#--什么都没留下-->
    <#--</#if>-->
    <#--</span>-->
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
        <#if classifys?size != 0>
        <div class="panel panel-default corner-radius panel-user-classify" id="classifysid">
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
        </#if>
    </div>
</div>
<!-- /end -->

</@layout>