<#include "/default/utils/ui.ftl"/>

<@layout "我的主页">

<div class="row users-show streams">
    <div class="col-xs-12 col-md-3 side-left">
        <#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="icon icon-layers"></i> 动态
                </div>
            </div>
            <div class="stream-list p-stream">
                <#list page.content as row>
                    <#if row.post??>
                        <#assign target = row.post>
                        <@showBlog target/>
                    </#if>
                </#list>
              <#if page.content?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 无最新动态
                </div>
              </#if>
            </div>
        </div>
        <div class="text-center clr">
	          <@pager request.requestURI, page, 5/>
        </div>
    </div>
</div>
<!-- /end -->

</@layout>