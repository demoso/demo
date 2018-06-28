<#include "/default/utils/ui.ftl"/>

<@layout user.name + "的主页">
<div class="row users-show streams">
    <div class="col-xs-12 col-md-3 side-left">
        <ul class="list-group about-user">
            <li class="list-group-item user-card" >
                <div class="user-avatar">
                    <a href="${base}/users/${user.id}">
                        <@showAva user.avatar "img-circle"/>
                    </a>
                </div>
                <div class="user-name">
                    <span>${user.name}</span>
                </div>
            </li>
            <li class="list-group-item">
                <a class="btn btn-primary btn-block btn-sm" href="javascript:void(0);" data-id="${user.id}" rel="follow"><i class="icon icon-user-follow"></i> 关注</a>
            </li>
			<li class="list-group-item">
                <span>
					<#if user.signature?? && (user.signature?length > 0) >
						${user.signature}
					<#else>
						什么都没留下
					</#if>
				</span>
			</li>
        </ul>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
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
</div>
<!-- /end -->

</@layout>