<#include "/default/utils/ui.ftl"/>

<@layout "标签:" + kw>

<div class="row streams">
    <div class="col-xs-12 col-md-8 side-left">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 标签: ${kw} 共 ${page.totalElements} 个结果.
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
                  <@showBlog row/>
              </#list>
            <#--<#if page.content?size == 0>-->
            <#--<div class="stream-item">-->
            <#--<i class="fa fa-info-circle fa-lg"></i> 该标签下没发表过文章!-->
            <#--</div>-->
            <#--</#if>-->
            </div>
        </div>
        <div class="text-center clr">
	          <@pager request.requestURI, page, 5/>
        </div>
    </div>
    <div class="col-xs-12 col-md-4 side-right">
		<#include "/default/inc/right.ftl" />
    </div>
</div>
</@layout>