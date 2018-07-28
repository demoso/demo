<#include "/default/utils/ui.ftl"/>
<@layout "编辑文章">


<div class="row">
    <div class="col-xs-12 col-md-3">
    <#--<#include "/default/column/left.ftl"/>-->
        <#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-8">
        <form class="form-horizontal" role="form" action="${base}/post/submit" method="post"
              enctype="multipart/form-data">
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
                <#include "/default/channel/editor/ueditor.ftl"/>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right">选择栏目：</label>
                <div class="col-sm-3">
                    <select class="form-control" name="channelId" data-required>
                        <option value="">请选择栏目</option>
                        <#list channels as row>
                            <option value="${row.id}" <#if (view.channelId == row.id)>
                                    selected </#if>>${row.name}</option>
                        </#list>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right">文章类型：</label>
                <div class="col-sm-3">
                    <select class="form-control" name="classify" data-required>
                        <option value="">请选择文章分类</option>
                            <#list classifys as row>
                             <option value="${row.classname}" <#if (view.classify == row.classname)>
                                     selected </#if>>${row.classname}</option>
                            </#list>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right">个人分类：</label>
                <div class="col-sm-8">
                    <input style="display: none" id="inputclassify"
                           onkeyup="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\ ]/g,'')"
                           onpaste="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\ ]/g,'')"
                           oncontextmenu="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\ ]/g,'')">
                    <a href="javascript:void(0);" id="addmyclassify">添加新分类</a>

                    <div id="classify-box">
                        <#list myclassifys as row>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="myclassify[]"
                                       value="${row.classname}" <#list view.myclassifysArray as myclassify> <#if (myclassify == row.classname)>
                                       checked </#if> </#list> > ${row.classname}
                            </label>
                        </#list>
                    </div>

                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right">文章标签：</label>
                <div class="col-sm-8">
                    <input type="hidden" name="tags" id="fieldTags">
                    <ul id="tags"></ul>
                    <p class="help-block" style="font-size: 12px;">添加相关标签，用逗号或空格分隔 (最多4个).</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label no-padding-right">访问权限：</label>
                <div class="col-sm-3">
                    <select class="form-control" name="privacy">
                        <option value="0">公开</option>
                        <option value="1">私密</option>
                    </select>
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
$(function () {
    $("#addmyclassify").click(function () {
        $("#inputclassify").show();
    });

    $("#inputclassify").blur(function () {
        var classnme = $("#inputclassify").val();
        if (classnme != "") {
            $.post("/post/classify", {classname: classnme}, function (ret) {
                if (ret && ret.code == 0) {
                    $("#classify-box").append('<label class="checkbox-inline"><input type="checkbox" name="myclassify[]"  value="' + classnme + '" checked> ' + classnme + '</label>');
                    $("#inputclassify").hide();
                    $("#inputclassify").val("");
                }
            });
        }

    });
});

</script>
</@layout>