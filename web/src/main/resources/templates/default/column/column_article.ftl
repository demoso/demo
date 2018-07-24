<#include "/default/utils/ui.ftl"/>

<@layout "专栏整理">
<div class="row" xmlns="http://www.w3.org/1999/html">
    <div class="col-xs-12 col-md-8 side-left">
        <div class="panel panel-default">
            <div class="panel-heading">
                <STRONG>我的专栏${colname},点击编辑下面专栏文章列表：</STRONG>
            </div>

            <div class="panel-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th width="20%">链接(默认文章ID)</th>
                        <th width="52%">标题(字数控制在30以内）</th>
                        <th width="6%">显示</th>
                        <th width="22%">操作</th>
                    </tr>
                    </thead>
                    <tbody id="tab-list">
                    <#list columnlistAttrList as row>
                    <tr>
                        <td><input class="tab-input" type="text" name="url" value="${row.url}"></td>
                        <td><input class="tab-input" type="text" name="title" value="${row.title}" required="required">
                        </td>
                        <td>
                            <select name="csstype">
                                <option value="${row.csstype}" selected>${row.csstype}</option>
                                <option value="H2">H2</option>
                            </select>
                        </td>
                        <td>
                            <input class="up input-button" type="button" value="上">
                            <input class="down input-button" type="button" value="下">
                            <input class="delete input-button" type="button" value="删">
                            <input class="add input-button" type="button" value="加">
                        </td>
                    </tr>
                    </#list>
                    <#if columnlistAttrList?size == 0>
                   <tr>
                       <td><input class="tab-input" type="text" name="url"></td>
                       <td><input class="tab-input" type="text" name="title" required="required"></td>
                       <td>
                           <select name="csstype">
                               <option value="H3" selected>H3</option>
                               <option value="H2">H2</option>
                           </select>
                       </td>
                       <td>
                           <input class="up input-button" type="button" value="上">
                           <input class="down input-button" type="button" value="下">
                           <input class="delete input-button" type="button" value="删">
                           <input class="add input-button" type="button" value="加">
                       </td>
                   </tr>
                    </#if>
                    </tbody>
                </table>
                <div style="padding-left: 30%;">
                    <a class="act_view btn" id="submit-but" href="javascript:void(0);">提交保存&刷新右侧待加入文章</a>
                    <a class="act_view btn" style="margin-left: 20px" href="${base}/columnview/${id}">查看专栏</a>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xs-12 col-md-4 side-right">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>点击下面加按钮添加文章进专栏</strong>
            </div>

            <div class="panel-body">
                <table class="table table-striped">
                    <tbody>
                       <#list postList as row>
                       <tr>
                           <td width="5%"><input class="addtotab" type="button" value="+" data-id="${row.id}"
                                                 data-title="${row.title}" data-toggle="tooltip" title="${row.title}">
                           </td>
                           <td width="95%">${row.title}</td>
                       </tr>
                       </#list>
                    </tbody>
                </table>
                <#if postList?size == 0>
                   <div class="infos">
                       <div class="media-heading">没有更多内容了，去发布文章吧!</div>
                   </div>
                </#if>
            </div>
        </div>
    </div>
</div>
<!-- /end -->

<script type="text/javascript">
    $(function ($) {
        //元素交换
        $(".up").live('click', function () {
            $(this).parent().parent().prev("tr").before($(this).parent().parent());
        });
        $(".down").live('click', function () {
            $(this).parent().parent().next("tr").after($(this).parent().parent());
        });

        $(".delete").live('click', function () {
            $(this).parent().parent().remove();
        });

        $(".add").live('click', function () {
            $('<tr><td><input class="tab-input" type="text" name="url"></td><td><input class="tab-input" type="text" name="title"  required="required"></td><td><select name="csstype"><option value="H3" selected>H3</option><option value="H2">H2</option></select></td><td><input type ="button" value="上" class="up act-button"><input type ="button" value="下" class="down act-button"><input type ="button" value="删" class="delete act-button"><input type ="button" value="加" class="add act-button"></td></tr>')
                    .insertAfter($(this).parent().parent());
        });

        $(".addtotab").live('click', function () {
            var id = $(this).attr('data-id');
            var title = $(this).attr('data-title');
            $(this).css("background-color", "yellow");
            $("#tab-list").append('<tr><td><input class="tab-input" type="text" name="url" value=' + id + '></td><td><input class="tab-input" type="text" name="title" value=' + title + ' ></td><td><select name="csstype"><option  value="H3" selected>H3</option><option value="H2">H2</option></select></td><td><input type ="button" value="上" class="up act-button"><input type ="button" value="下" class="down act-button"><input type ="button" value="删" class="delete act-button"><input type ="button" value="加" class="add act-button"></td></tr>')
        });

        $("#submit-but").live('click', function () {
            var args = [];
            $("#tab-list").children().each(function (i) {
                var data = {};
                $(this).find("select[name],input[name]").each(function () {
                    var name = $(this).attr("name");
                    data[name] = $(this).val();
                });
                args[i] = data;
            });
            $.post("/column/savecolattr/${id}", {data: JSON.stringify(args)}, function () {
                window.location.reload();
            });
        });
    });
</script>
</@layout>