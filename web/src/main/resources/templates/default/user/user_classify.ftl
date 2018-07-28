<#include "/default/utils/ui.ftl"/>

<@layout "我的分类">
<div class="row users-show">
    <div class="col-xs-12 col-md-3">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的分类
                    <input style="position: absolute; right: 180px;width: 300px;height:27px;background-color: #FAFAFA;border:1px solid 	#A0A0A0 ; border-radius: 3px"
                           type="text" id="input-classify">
                    <button style="position: absolute; right: 100px;" id="addbtn">添加分类</button>

                </div>
            </div>
            <div class="stream-list p-stream">
              <#list classifys as row>
              <div class="stream-item">
                  <a style="width: 85%;display: inline-block;" href="${base}/classify/${row.classname}">
                      <span style="padding-left: 10px;font-size: 18px">${row.classname}</span>
                  </a>
                  <a style="display: inline-block;" class="act_delete" href="javascript:void(0);" data-evt="trash"
                     data-id="${row.id}"
                     data-toggle="tooltip" title="删除分类">
                      删除分类
                  </a>
              </div>
              </#list>
              <#if classifys?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 暂无分类
                </div>
              </#if>
            </div>
        </div>
    </div>
</div>
<!-- /end -->

<script type="text/javascript">
    $(function () {
        $('#addbtn').click(function () {
            var classnme = $('#input-classify').val();
            $.post("/post/classify", {classname: classnme}, function (ret) {
                if (ret && ret.code == 0) {
                    window.location.reload();
                }
            });
        });

        // delete
        $('a[data-evt=trash]').click(function () {
            var id = $(this).attr('data-id');
            layer.confirm('确定删除此项吗?', {
                btn: ['确定', '取消'], //按钮
                shade: false //不显示遮罩
            }, function () {
                jQuery.getJSON('${base}/user/delclassify/' + id, function (ret) {
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