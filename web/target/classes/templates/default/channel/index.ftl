<#include "/default/utils/ui.ftl"/>
<@layout channel.name>
    <div class="row streams">
        <div class="col-xs-12 col-md-9 side-left">

                <@contents channelId=channel.id pn=pn order=order>

                     <div class="shadow-box">
                         <div class="filter ul-filter">
                                 <ul class="list-inline topic-filter ">
                                     <li data-toggle="tooltip" title="发布时间排序">
                                         <a href="?order=newest" <#if order == 'newest'> class="active" </#if>>最近</a>
                                     </li>
                                     <li data-toggle="tooltip" title="点赞数排序">
                                         <a href="?order=favors" <#if order == 'favors'> class="active" </#if>>投票</a>
                                     </li>
                                     <li data-toggle="tooltip" title="评论次数排序">
                                         <a href="?order=hottest" <#if order == 'hottest'> class="active" </#if>>热门</a>
                                     </li>
                                 </ul>
                         </div>
                        <div class="stream-list p-stream">
                             <#list results.content as row>
                                <@showBlog row/>
                              </#list>
                            <#if results.content?size == 0>
                               <div class="stream-item">
                                   <i class="	fa fa-arrow-circle-right"></i> 该目录下还没有内容!
                               </div>
                            </#if>
                        </div>
                     </div>

                    <div class="text-center clr">
	                    <@pager request.requestURI!"", results, 5/>
                    </div>
                </@contents>

        </div>

        <div class="col-xs-12 col-md-3 side-right">
            <#include "/default/inc/right.ftl" />
        </div>

    </div>

</@layout>

