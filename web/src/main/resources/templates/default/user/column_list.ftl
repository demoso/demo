<#include "/default/utils/ui.ftl"/>

<@layout "我的专栏">
<div class="row users-show" xmlns="http://www.w3.org/1999/html">
    <div class="col-xs-12 col-md-3 side-left">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="panel panel-default">
            <div class="panel-heading">
                我的专栏
            </div>

            <div class="panel-body">
					<#list listcolumn as row>
                        <div class="colbox-inline col-sm-9" style="padding-top: 5px">
                            <a href="${base}/view/${row.id}">
                                <img class="li-group-img img-circle" src="${row.logo}"/>
                                <span STYLE="position: absolute;left:72px;bottom: 30px;font-size: 16px">【${row.colname}】</span>
                                <small style="position: absolute;left: 80px;bottom: 10px">${row.comment}</small>
                            </a>
                        </div>
                        <div class="colbox-inline col-sm-3 hidden-xs"
                             style="text-align: right;padding-right: 10px;padding-top: 15px">
                            <a class="act_editarticle column-atag"
                               href="${base}/column/artedit/${user.id}/${row.id}/${row.colname}" data-toggle="tooltip"
                               title="管理专栏文章">
                                <i class="icon icon-note"></i>
                            </a>
                            <a class="act_edit column-atag" href="${base}/column/modifying/${row.id}"
                               data-toggle="tooltip" title="修改专栏">
                                <i class="icon icon-note"></i>
                            </a>
                            <a class="act_delete column-atag" href="javascript:void(0);" data-evt="trash"
                               data-id="${row.id}" data-toggle="tooltip" title="删除专栏">
                                <i class="icon icon-close"></i>
                            </a>
                        </div>
                    </#list>

					<#if listcolumn?size == 0>

                    </#if>
            </div>
        </div>
    </div>
</div>
<!-- /end -->

<script type="text/javascript">
    $(function () {
        // delete
        $('a[data-evt=trash]').click(function () {
            var id = $(this).attr('data-id');

            layer.confirm('确定删除此项吗?', {
                btn: ['确定', '取消'], //按钮
                shade: false //不显示遮罩
            }, function () {
                jQuery.getJSON('${base}/column/delete/' + id, function (ret) {
                    layer.msg(ret.message, {icon: 1});
                    if (ret.code >= 0) {
                        location.reload();
                    }
                });

            }, function () {

            });
        });
    })
</script>
</@layout>