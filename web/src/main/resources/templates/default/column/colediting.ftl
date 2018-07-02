<#include "/default/utils/ui.ftl"/>
<@layout "编辑专栏">


<div class="row">
    <div class="col-xs-12 col-md-3">
     <#include "/default/column/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9">
        <form class="form-horizontal" action="${base}/column/submit" method="post">
            <input type="hidden" id="x" name="x" value=""/>
            <input type="hidden" id="y" name="y" value=""/>
            <input type="hidden" id="width" name="width" value=""/>
            <input type="hidden" id="height" name="height" value=""/>
            <input type="hidden" id="path" name="path" value=""/>

            <div class="form-group upload-btn">
                <label>
                    <span>点击选择一张图片</span>
                    <input id="upload_btn" type="file" name="file" accept="image/*" title="点击添加图片">
                </label>
            </div>
            <div class="update_ava">
                <img src="<@resource src=profile.avatar/>" id="target" alt="[Example]" />
            </div>

            <div class="form-group">
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- /form-actions -->
<script type="text/javascript">
    seajs.use('cologo');
</script>
</@layout>