<#include "/default/utils/ui.ftl"/>

<@layout "我的关注">
<div class="row users-show streams">
    <div class="col-xs-12 col-md-3 side-left">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的关注
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
              <div class="stream-item">
                  <div>
                      <a href="${base}/users/${row.id}">
                          <img class="li-group-img img-circle" src="${row.avatar}"/>
                          <span style="padding-left: 5px;font-size: 18px">${row.name}</span>
                      </a>
                  </div>
                  <div class="pull-right hidden-xs" style="position: absolute;right: 20px;bottom: 25px">
                      <a class="btn btn-success btn-xs" href="javascript:void(0);" data-id="${row.id}" rel="unfollow"
                         style="color: #fff;">取消关注</a>
                  </div>
              </div>
              </#list>
              <#if page.content?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 暂无关注
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
	$('a[rel=unfollow]').click(function () {
		var id = $(this).attr('data-id');

		layer.confirm('确定取消关注TA吗?', {
            btn: ['确定','取消'], //按钮
            shade: false //不显示遮罩
        }, function(){
			jQuery.getJSON('${base}/user/unfollow',{'id': id},  function (ret) {
				layer.msg(ret.message, {icon: 1});
				if (ret.code >=0) {
					$('#loop-' + id).fadeOut();
					$('#loop-' + id).remove();
				}
			});

        }, function(){

        });
	});
})
</script>
</@layout>