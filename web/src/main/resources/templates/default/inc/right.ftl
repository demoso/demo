<div class="panel panel-default corner-radius panel-hot-topics">
	<div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-star-o"></i> 热门文章</h3>
	</div>
	<div class="panel-body list-body">
		<ul class="list" id="hots">
            <img src="${base}/dist/images/spinner.gif">
		</ul>
	</div>
</div>

<div class="panel panel-default corner-radius panel-hot-topics">
	<div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-hourglass-1"></i> 最新发布</h3>
	</div>
	<div class="panel-body list-body">
		<ul class="list" id="latests">
			<img src="${base}/dist/images/spinner.gif">
		</ul>
	</div>
</div>

<div class="panel panel-default corner-radius panel-hot-topics">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-user-circle-o"></i> 热门用户</h3>
    </div>
    <div class="panel-body remove-padding-horizontal">
        <ul class="hotusers" id="hotuser">
            <img src="${base}/dist/images/spinner.gif">
        </ul>
    </div>
</div>

<script type="text/javascript">

	<#--var li_template = '<li><span class="label label-default">{0}</span><a class="a-link" href="${base}/view/{1}">{2}</a></li>';-->
    var li_template = '<li><a href="${base}/view/{1}" data-toggle="tooltip" title="{2}">{2}</a></li>';

var hotUser_li_template = '<li ><a href="{1}"><img src="${base}{0}" class="avatar avatar-small"/></a></li>'

seajs.use('sidebox', function (sidebox) {
	sidebox.init({
        latestUrl : '${base}/api/latests',
    	hotUrl : '${base}/api/hots',
		hotTagUrl : '${base}/api/hot_tags',
		hotUserUrl:'${base}/api/hotusers',

        size :10,
        // callback
        onLoadHot : function (i, data) {
      		return jQuery.format(li_template, i + 1, data.id, data.title);
        },
        onLoadLatest : function (i, data) {
      		return jQuery.format(li_template, i + 1, data.id, data.title);
        },
        onLoadHotUser : function (i, data) {
        var url = '${base}/users/' + data.id;
      		var item = jQuery.format(hotUser_li_template,data.avatar,url,data.name, data.fans);
      		return item;
        }
	});
});
</script>