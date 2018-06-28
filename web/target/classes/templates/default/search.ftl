<#include "/default/utils/ui.ftl"/>

<@layout "搜索:" + kw>

<div class="row streams">
    <div class="col-xs-12 col-md-9 side-left">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-chevron-circle-right"></i> 搜索: ${kw} 共 ${page.totalElements} 个结果..
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
                <@showBlog row/>
              </#list>
              <#if !page?? || page.content?size == 0>
                <div class="stream-item">
                    <i class="	fa fa-arrow-circle-right"></i> 该目录下还没有内容!
                </div>
              </#if>
            </div>
        </div>
        <div class="text-center clr">
	          <@pager "search?kw="+kw, page, 5/>
        </div>
    </div>
    <div class="col-xs-12 col-md-3 side-right">
        <#include "/default/inc/right.ftl" />
    </div>
</div>
</@layout>

