<#include "/default/utils/ui.ftl"/>

<@layout "我的喜欢">
<div class="row users-show">
    <div class="col-xs-12 col-md-3 side-left">
		<#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的收藏
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as target>
                  <#if target.post??>
                      <#assign row = target.post>
                  <div class="stream-item" id="loop-${row.id}">
                      <div class="article-title">
                          <a href="${base}/view/${row.id}">
                              <span class="label label-success">文</span>
                              <span class="h2-title">${row.title!}</span>
                          </a>
                      </div>
                      <div class="summary">
                          <a href="${base}/view/${row.id}">
                              <div class="excerpt wordbreak">${row.summary!}</div>
                          </a>
                      </div>
                      <div class="p-rank clearfix">
                          <div class="users">
                              <a href="${base}/ta/${row.author.id}">
                                  <div class="ava">
                                    <@showAva row.author.avatar "img-circle"/>
                                  </div>
                                  <div class="info">
                                      <span><small>${row.author.name}</small></span>
                                  </div>
                              </a>

                              <div class="info">
                                  <span><time> ${timeAgo(row.created)}</time></span>
                              </div>
                              <div class="info">
                              <#--<i class="fa fa-tag"></i>-->
                             <#if row.tagsArray??>
                             <i>标签：</i>
                             </#if>
                            <#list  row.tagsArray as tag>
                              <a class="tag-link" href="${base}/tag/${tag}">${tag}</a>
                                <#if tag_has_next>
                                    ,
                                </#if>
                            </#list>
                                  <div class="pull-right hidden-xs" style="position: absolute;right: 10px;bottom: 20px">
                                      <a class="act_edit" href="javascript:void(0);" data-evt="unfavor"
                                         data-id="${row.post.id}">取消收藏</a>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
                  <#else>
                  <div class="stream-item">文章已删除</div>
                  </#if>


              </#list>
              <#if page.content?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 该标签下没发表过文章!
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
	$('a[data-evt=unfavor]').click(function () {
		var id = $(this).attr('data-id');

		layer.confirm('确定删除此项吗?', {
            btn: ['确定','取消'], //按钮
            shade: false //不显示遮罩
        }, function(){
			jQuery.getJSON('${base}/user/unfavor', {'id': id}, function (ret) {
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