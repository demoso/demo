<#include "/default/utils/ui.ftl"/>
<@layout "编辑专栏">


<div class="row">
    <div class="col-xs-12 col-md-3 side-left">
     <#include "/default/user/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9 side-right">

        <div class="panel panel-default stacked">
            <div class="panel-heading">
                <h2 class="panel-title" style="margin-top: 15px;text-align: center"><strong>创建专栏</strong></h2>
            </div>
            <div class="panel-body">
                <div class="create_intro">
                    <h5>专栏创建标准：</h5>
                    <p>1. 专栏文章以成体系，原创性为主</p>
                    <p>2. 专栏主题明确，简介翔实清晰</p>
                </div>

                <div class="column-inputbox">
                    <form class="form-horizontal" action="${base}/column/logosubmit" method="post">
                        <input type="hidden" id="x" name="x" value=""/>
                        <input type="hidden" id="y" name="y" value=""/>
                        <input type="hidden" id="width" name="width" value=""/>
                        <input type="hidden" id="height" name="height" value=""/>
                        <input type="hidden" id="path" name="path" value=""/>
                        <div class="form-group ">
                            <label for="logo" class="col-sm-2 control-label">LOGO</label>
                            <div class="col-sm-10 upload-btn">
                                <div class="update_logo" id="update_logo">
                                    <img src="${base}${columnlist.logo!"/dist/images/btn/add_img.png"}" id="target"
                                         alt="[Example]"/>
                                </div>
                                <label style="display: inline-block;">
                                    <span>添加LOGO</span>
                                    <input id="upload_btn" type="file" name="file" accept="image/*"
                                           title="点击添加图片作为专栏LOGO">
                                </label>
                                <label style="display: inline-block;">
                                    <span>确定</span>
                                    <input id="submit-button" title="确定">
                                </label>
                            </div>
                        </div>
                    </form>
                    <form class="form-horizontal" action="${base}/column/submit" method="post">
                        <input type="hidden" id="logo" name="logo" value="${columnlist.logo}"/>
                        <div class="form-group">
                            <label for="colname" class="col-sm-2 control-label">专栏名称</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control form-back" name="colname"
                                       value="${columnlist.colname}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="comment" class="col-sm-2 control-label">专栏介绍</label>
                            <div class="col-sm-10">
                                <textarea class="form-control form-back" name="comment"
                                          rows="10">${columnlist.comment}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="classid" class="col-sm-2 control-label">专栏分类</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="classid" data-required>
                                    <option value="">选择分类</option>
                                    <#list classifys as row>
                                       <option value="${row.id}" <#if (columnlist.classid == row.id)>
                                       selected </#if>>${row.classname}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"></label>
                            <div class="text-center col-sm-10">
                                <button type="submit" class="btn btn-primary">提交</button>
                            </div>
                        </div>

                    </form>
                </div>
            </div><!-- /panel-content -->
        </div><!-- /panel -->
    </div>
</div>

<!-- /form-actions -->
<script type="text/javascript">
    seajs.use('cologo');
</script>
</@layout>