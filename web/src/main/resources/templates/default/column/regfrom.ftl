<#include "/default/utils/ui.ftl"/>
<@layout "编辑专栏">


<div class="row">
    <div class="col-xs-12 col-md-3">
     <#include "/default/column/left.ftl"/>
    </div>
    <div class="col-xs-12 col-md-9">

        <div class="panel panel-default stacked">
            <div class="panel-heading">
                <ul class="nav nav-pills account-tab">
                    <li class="active"><a href="${base}/column/regfrom">基本信息</a></li>
                    <li><a href="${base}/column/uploadlogo">上传LOGO</a></li>
                </ul>
            </div>
            <div class="panel-body">
                <div class="column-inputbox">
                    <form class="form-horizontal" action="${base}/column/submit" method="post">
                        <div class="form-group">
                            <label for="firstname" class="col-sm-2 control-label">专栏名称</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control form-back" id="firstname" placeholder="请输入专栏名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">专栏介绍</label>
                            <div class="col-sm-10">
                                <textarea placeholder="请输入专栏介绍" class="form-control form-back" name="summary"
                                          rows="10"></textarea>
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