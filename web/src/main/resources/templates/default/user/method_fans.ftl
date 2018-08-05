<#include "/default/utils/ui.ftl"/>

<@layout "我的粉丝">
<div class="row users-show streams">
    <div class="col-xs-12 col-md-3 side-left">
        <#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">
        <div class="shadow-box">
            <div class="filter">
                <div class="alert" style="margin-bottom:0">
                    <i class="fa fa-tag fa-lg"></i> 我的粉丝
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
	          <@pager "user?method=fans", page, 5/>
        </div>
    </div>
</div>
<!-- /end -->

</@layout>