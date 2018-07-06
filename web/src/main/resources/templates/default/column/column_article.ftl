<#include "/default/utils/ui.ftl"/>

<@layout "专栏整理">
<div class="row">
    <div class="col-xs-12 col-md-6 side-left">
        <#list postList as row>
            ${row.id}
        </#list>
    </div>
    <div class="col-xs-12 col-md-6 side-right">
        <#list postList as row>
            ${row.id}
        </#list>
    </div>
</div>
<!-- /end -->

<script type="text/javascript">

</script>
</@layout>