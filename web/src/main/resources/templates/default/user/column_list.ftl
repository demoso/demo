<#include "/default/utils/ui.ftl"/>

<@layout "我的专栏">
<div class="row users-show">
    <div class="col-xs-12 col-md-3">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的专栏
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list listcolumn as row>
              <div class="stream-item">
                  <div>
                      <a href="${base}/columnview/${row.id}">
                          <img class="li-group-img img-circle" src="${row.logo}"/>
                          <span style="padding-left: 5px;font-size: 18px">${row.colname}</span>
                          <span>${row.comment}</span>
                      </a>
                  </div>
                  <div class="pull-right hidden-xs" style="position: absolute;right: 20px;bottom: 25px">
                      <a class="act_editarticle column-atag"
                         href="${base}/column/artedit/${user.id}/${row.id}/${row.colname}" data-toggle="tooltip"
                         title="管理专栏文章">
                          管理专栏文章
                      </a>
                      <a class="act_edit column-atag" href="${base}/column/modifying/${row.id}" data-toggle="tooltip"
                         title="修改专栏">
                          修改专栏
                      </a>
                      <a class="act_delete column-atag" href="javascript:void(0);" data-evt="trash" data-id="${row.id}"
                         data-toggle="tooltip" title="删除专栏">
                          删除专栏
                      </a>
                  </div>
              </div>
              </#list>
              <#if listcolumn?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 暂无专栏
                </div>
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