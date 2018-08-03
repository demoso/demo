<#include "/default/utils/ui.ftl"/>

<@layout>
<div class="row streams">
    <div class="col-xs-12 col-md-8 side-left">
    <#list map?keys as key>
        <div class="panel panel-default corner-radius" id="${key}">
            <div class="panel-heading panel-heading-bgcolor" >
                <h3 class="panel-title">
                    <i class="fa fa-chevron-circle-down"></i>
                    ${key}</h3>
            </div>
            <div class="panel-body list-body">
                <ul class="time-list clearfix">
                    <#list map[key] as row >
                    <li><a href="columnview/${row.id}" title="${row.comment}"  lass="linkTip"><img class="img-circle img-wh" src="${row.logo}"/>
                        ${row.colname}</a></li>
                    </#list>
                    <div style="clear:both;"></div>
                </ul>
            </div>
        </div>
    </#list>

    </div>
    <div class="col-xs-12 col-md-4 side-right">
       <#include "/default/inc/right.ftl"/>
    </div>
</div>

<script>
    function animationHover(o,e){
        o=$(o),o.hover(function(){
            o.addClass("animated "+e)
        },function(){
            window.setTimeout(function(){
                o.removeClass("animated "+e)},2e3)})
    }
    $("#link_item").click(function() {
        $(".rowattr").show();
    })
    $(".list-group-item").click(function() {
        id = $(this).attr("id");
        $("." + id).show();
        $("." + id).siblings().hide();
    })
</script>
<script>
    $(document).ready(function(){$(".contact-box").each(function(){animationHover(this,"pulse")})});
</script>

</@layout>