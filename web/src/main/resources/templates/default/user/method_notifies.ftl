<#include "/default/utils/ui.ftl"/>

<@layout "通知">
<div class="row users-show streams">
    <div class="col-xs-12 col-md-3 side-left">
        <#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 通知
                </div>
            </div>
            <div class="stream-list p-stream">
              <#list page.content as row>
              <div class="stream-item">
                  <div>
                      <a href="${base}/users/${row.from.id}">
                          <img class="li-group-img img-circle" src="${row.from.avatar}"/>
                          <span style="padding-left: 5px;font-size: 18px">${row.from.name}</span>
                          <span>
                                        <#if (row.event == 1)>
                                            喜欢了你的文章 - <a href="${base}/view/${row.postId}">${row.post.title}</a>
                                        <#elseif (row.event == 2)>
                                            关注了你, 你的粉丝+1
                                        <#elseif (row.event == 3)>
                                            评论了你的文章 - <a href="${base}/view/${row.postId}">点击查看详情</a>
                                        <#elseif (row.event == 4)>
                                            回复了你的评论 - <a href="${base}/view/${row.postId}">点击查看详情</a>
                                        </#if>
                          </span>
                      </a>
                      <a class="reply_count_area hidden-xs pull-right" href="#">
                          <div class="count_set">
                              <abbr class="timeago">${timeAgo(row.created)}</abbr>
                          </div>
                      </a>
                  </div>
              </div>
              </#list>
              <#if page.content?size == 0>
                <div class="stream-item">
                    <i class="fa fa-info-circle fa-lg"></i> 暂无粉丝!
                </div>
              </#if>
            </div>
        </div>
        <div class="text-center clr">
	          <@pager "user?method=notifies", page, 5/>
        </div>
    </div>
</div>
<!-- /end -->

</@layout>