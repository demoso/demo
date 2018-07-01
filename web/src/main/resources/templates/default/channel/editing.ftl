<#include "/default/utils/ui.ftl"/>
<@layout "编辑文章">


<div class="row">
    <div class="col-xs-12 col-md-3">
     <#include "/default/column/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9">
        <form class="form" action="${base}/post/submit" method="post" enctype="multipart/form-data">
            <div id="message"></div>
            <#if view??>
                <input type="hidden" name="id" value="${view.id}"/>
                <input type="hidden" name="authorId" value="${view.authorId}"/>
            </#if>
            <input type="hidden" name="thumbnail" value="${view.thumbnail}"/>

            <div class="form-group">
                <input type="text" class="form-control" name="title" maxlength="128" data-required value="${view.title}" placeholder="请输入标题">
            </div>
            <div class="form-group">
                <select class="form-control" name="channelId" data-required>
                    <option value="">请选择栏目</option>
                    <#list channels as row>
                        <option value="${row.id}" <#if (view.channelId == row.id)> selected </#if>>${row.name}</option>
                    </#list>
                </select>
            </div>
            <div class="form-group">
                <#include "/default/channel/editor/ueditor.ftl"/>
            </div>
            <div class="panel panel-default corner-radius help-box">
                <div class="panel-body">
                    <span>添加相关标签，用逗号或空格分隔 (最多4个)</span><input type="hidden" name="tags" id="fieldTags" value="${view.tags}" placeholder="添加相关标签，用逗号或空格分隔 (最多4个)">
                    <ul id="tags"></ul>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <button type="submit" class="btn btn-primary" style="padding-left: 30px; padding-right: 30px;">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- /form-actions -->
<script type="text/javascript">
seajs.use('post', function (post) {
	post.init();
});
</script>
</@layout>