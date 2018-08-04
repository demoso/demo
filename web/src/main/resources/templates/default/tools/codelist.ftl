<#include "/default/utils/ui.ftl"/>
<@layout "代码">
    <div class="row streams">
        <div class="col-xs-12 col-md-8 side-left">
            <div class="shadow-box">
                <div class="filter">
                    <div class="alert" style="margin-bottom:0">
                        <i class="fa fa-code"></i> 代码
                    </div>
                </div>
                <div class="stream-list p-stream">
                <#list page.content as row>
                     <@showCode row/>
                </#list>
                </div>
                <#if page.content?size == 0>
                  <div class="stream-item">
                      <i class="	fa fa-arrow-circle-right"></i> 该目录下还没有内容!
                  </div>
                </#if>
            </div>
            <div class="text-center clr">
                <@pager request.requestURI!"", page, 5/>
            </div>
        </div>

        <div class="col-xs-12 col-md-4 side-right">
            <#include "/default/inc/right.ftl" />
        </div>

    </div>

</@layout>

