<#include "/default/utils/ui.ftl"/>

<@layout>
<div class="row streams">

    <div class="col-xs-12 col-md-12" style="padding: 0 30px 0 15px">
        <div class="show-404">
            <div class="ava">
                <img src="/dist/images/404.png">
            </div>
            <div class="page-error">
                <h3 style="">很抱歉，您访问的页面走丢了!</h3>
                <h4>请检查您输入的网址是否正确。</h4>
                <h4>或者你直接输入要访问的内容进行搜索。</h4>
                <h4>你可以访问如下为你推荐的内容，或者返回首页</h4>
                <h3><a class="btn btn-danger" href="/index">返回首页</a></h3>
            </div>
        </div>
    <#list classify_column_map?keys as key>

        <div class="panel panel-default corner-radius panel-radius" id="${key}">
            <div class="panel-heading panel-heading-bgcolor">
                <h3 class="panel-title">
                    <i class="fa fa-chevron-circle-down"></i>
                    ${key}</h3>
            </div>
            <div class="panel-body list-body">
                <ul class="time-list clearfix">
                    <#list classify_column_map[key] as row >
                    <li><a href="/columnview/${row.id}" title="${row.comment}" lass="linkTip"><img
                            class="img-circle img-wh" src="${row.logo}"/>
                        ${row.colname}</a></li>
                    </#list>
                    <div style="clear:both;"></div>
                </ul>
            </div>
        </div>
    </#list>

    </div>
</div>
</@layout>