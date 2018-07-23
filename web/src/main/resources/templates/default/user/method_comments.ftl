<#include "/default/utils/ui.ftl"/>

<@layout "我的评论">
<div class="row users-show">
    <div class="col-xs-12 col-md-3 side-left">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的评论.
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
              <div class="stream-item comment-item" el="loop-${row.id}">
                  <h2 class="title" style="color:#F36C52">我说：${row.content}</h2>
                  <#if row.post??>
                      <a href="${base}/view/${row.post.id}" style="font-size: 16px;font:bold">@${row.post.title}</a>
                  <#else>
                  <div class="stream-item">文章已删除</div>
                  </#if>

                  <div class="pull-right hidden-xs" style="position: absolute;right: 20px;bottom: 10px">
                      <a class="act_delete" href="javascript:void(0);" data-evt="trash" data-id="${row.id}">删除</a>
                  </div>

              </div>
              </#list>
              <#if page.content?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 还没有内容!
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

<script type="text/javascript">
$(function() {
	$('a[data-evt=trash]').click(function () {
		var id = $(this).attr('data-id');

		layer.confirm('确定删除此项吗?', {
            btn: ['确定','取消'], //按钮
            shade: false //不显示遮罩
        }, function(){
			jQuery.getJSON('${base}/comment/delete', {'id':id }, function (ret) {
				layer.msg(ret.message, {icon: 1});
				if (ret.code >=0) {
					var el = $('li[el=loop-' + id + ']');
                    el.next().remove();
                    el.next().remove();
                    el.remove();
				}
			});
            
        }, function(){
			
        });
	});
})
</script>
</@layout>