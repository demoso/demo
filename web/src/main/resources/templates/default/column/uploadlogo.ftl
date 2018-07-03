<#include "/default/utils/ui.ftl"/>
<@layout "编辑专栏">


<div class="row">
    <div class="col-xs-12 col-md-3">
     <#include "/default/column/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9">
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

                <form class="form-horizontal" action="${base}/column/logosubmit" method="post">
                    <input type="hidden" id="x" name="x" value=""/>
                    <input type="hidden" id="y" name="y" value=""/>
                    <input type="hidden" id="width" name="width" value=""/>
                    <input type="hidden" id="height" name="height" value=""/>
                    <input type="hidden" id="path" name="path" value=""/>
                    <div class="form-group upload-btn">
                        <label>
                            <span>点击添加图片作为专栏LOGO</span>
                            <input id="upload_btn" type="file" name="file" accept="image/*" title="点击添加图片作为专栏LOGO">
                        </label>
                    </div>
                    <div class="update_logo">
                        <img src="${base}${dest!"/dist/images/btn/add_img.png"}" id="target" alt="[Example]"/>
                    </div>

                    <div class="form-group">
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">下一步</button>
                        </div>
                    </div>
                </form>
            </div><!-- /panel-content -->
        </div><!-- /panel -->
    </div>
</div>

<!-- /form-actions -->
<script type="text/javascript">
    seajs.use('cologo');
</script>
</@layout>