<#-- Layout -->
<#macro layout title keywords description>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--[if IE]>
    <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
    <![endif]-->
    <#--<meta name="baidu-site-verification" content="2nXjznVkpe" />-->

    <title>${title?default(site_name)}</title>
    <meta name="keywords" content="demoso, ${keywords?default(site_keywords)}">
    <meta name="description" content="${description?default(site_description)}">

    <#include "/default/inc/include.ftl"/>
</head>
<body>
<!-- header -->
    <#include "/default/inc/header.ftl"/>
<!-- /header -->

<!-- content -->
<div class="wrap">
    <!-- Main -->
    <div class="container">
        <#nested>
    </div>
</div>
<!-- /content -->

<!-- footer -->
    <#include "/default/inc/footer.ftl"/>

</body>
</html>
</#macro>

<#---------------------------------- codelayout ---------------------------------->
<#macro codelayout title keywords description>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--[if IE]>
    <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
    <![endif]-->
<#--<meta name="baidu-site-verification" content="2nXjznVkpe" />-->

    <title>${title?default(site_name)}</title>
    <meta name="keywords" content="demoso, ${keywords?default(site_keywords)}">
    <meta name="description" content="${description?default(site_description)}">

    <#include "/default/inc/include.ftl"/>

    <script type="text/javascript" src="${base}/dist/vendors/codemirror/lib/codemirror.js"></script>
    <link rel="stylesheet" media='all' href="${base}/dist/vendors/codemirror/lib/codemirror.css">
    <link rel="stylesheet" media='all' href="${base}/dist/vendors/codemirror/theme/dracula.css"/>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/htmlmixed/htmlmixed.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/css/css.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/javascript/javascript.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/xml/xml.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/clike/clike.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/mode/php/php.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/addon/edit/closetag.js"></script>
    <script type="text/javascript" src="${base}/dist/vendors/codemirror/addon/edit/closebrackets.js"></script>

    <style>
        .container {
            width: 100%;
        }

        .footer {
            background: #303030;
        }

        .wrap {
            position: relative;
            padding-top: 5px;
            margin-top: 0px;
            margin-bottom: 0px;
            background-color: #303030;
            /*z-index: 100;*/
        }
        .CodeMirror {
            font-size: 12px;
            height: 840px;
        }

        #textareaCode {
            height: 840px;
        }

        #iframeResult {
            border: 0 !important;
            min-width: 100px;
            width: 100%;
            height: 840px;
            background-color: #fff;
        }

        .LeftPane {
            position: relative;
            float: left;
            height: 100%;
            width: 30%;
            min-width: 10%;
            max-width: 90%;
            position: relative;
            margin-left: 10px;
        }

        .handler {
            position: absolute;
            top: 27px;
            width: 5px;
            height: 840px;
            right: -1px;
            background-color: #222;
            z-index: 88;
            cursor: col-resize;
        }

        .RightPane {
            position: relative;
            overflow: hidden;
            height: 100%;
            margin-right: 10px;

        }

        .zz {
            position: absolute;
            top: 0;
            width: 100%;
            height: 100%;
            right: 0;
            z-index: 50;
            display: none;
        }

        .pull-right {
            margin-right: 10px;
        }

        @media screen and (max-width: 768px) {
            #textareaCode {
                height: 300px;
            }

            .CodeMirror {
                font-size: 12px;
                height: 300px;
            }

            #iframeResult {
                height: 300px;
            }

            .form-inline {
                padding: 6px 0 2px 0;
            }
        }
    </style>
</head>
<body>
<!-- header -->
    <#include "/default/inc/header.ftl"/>
<!-- /header -->
<!-- content -->
<div class="wrap">
    <!-- Main -->
    <div class="container">
        <div class="row">
            <div class="main clearfix">
                <div class="col-xs-12 col-md-12">
                   <#nested>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /content -->

<!-- footer -->
    <#include "/default/inc/footer.ftl"/>

</body>
</html>
</#macro>
<#---------------------------------- end codelayout ---------------------------------->

<#-- 用户头像显示 -->
<#macro showAva avatar clazz>
    <#if avatar?starts_with("http:")>
    <img class="${clazz}" src="${avatar}"/>
    <#else>
    <img class="${clazz}" src="<@resource src=avatar />"/>
    </#if>
</#macro>

<#macro classify row>
    <#if row.channel??>
    <span class="hidden-xs label label-default <#if (row.featured > 0)>channel_featured</#if> <#if (row.weight > 0)>channel_top</#if>">${row.channel.name}</span>
    </#if>
</#macro>

<#macro pager url p spans>
    <#if p??>
        <#local span = (spans - 3)/2 />
        <#if (url?index_of("?") != -1)>
            <#local cURL = (url + "&pn=") />
        <#else>
            <#local cURL = (url + "?pn=") />
        </#if>

    <ul class="pagination">
        <#assign pageNo = p.number + 1/>
        <#assign pageCount = p.totalPages />
        <#if (pageNo > 1)>
            <li><a href="${cURL}${pageNo - 1}" pageNo="${pageNo - 1}" class="prev">上一页</a></li>
        <#else>
            <li class="disabled"><span>上一页</span></li>
        </#if>

        <#local totalNo = span * 2 + 3 />
        <#local totalNo1 = totalNo - 1 />
        <#if (pageCount > totalNo)>
            <#if (pageNo <= span + 2)>
                <#list 1..totalNo1 as i>
                    <@pagelink pageNo, i, cURL/>
                </#list>
                <@pagelink 0, 0, "#"/>
                <@pagelink pageNo, pageCount, cURL />
            <#elseif (pageNo > (pageCount - (span + 2)))>
                <@pagelink pageNo, 1, cURL />
                <@pagelink 0, 0, "#"/>
                <#local num = pageCount - totalNo + 2 />
                <#list num..pageCount as i>
                    <@pagelink pageNo, i, cURL/>
                </#list>
            <#else>
                <@pagelink pageNo, 1, cURL />
                <@pagelink 0 0 "#" />
                <#local num = pageNo - span />
                <#local num2 = pageNo + span />
                <#list num..num2 as i>
                    <@pagelink pageNo, i, cURL />
                </#list>
                <@pagelink 0, 0, "#"/>
                <@pagelink pageNo, pageCount, cURL />
            </#if>
        <#elseif (pageCount > 1)>
            <#list 1..pageCount as i>
                <@pagelink pageNo, i, cURL />
            </#list>
        <#else>
            <@pagelink 1, 1, cURL/>
        </#if>

        <#if (pageNo < pageCount)>
            <li><a href="${cURL}${pageNo + 1}" pageNo="${pageNo + 1}" class="next">下一页</a></li>
        <#else>
            <li class="disabled"><span>下一页</span></li>
        </#if>
    </ul>
    </#if>
</#macro>

<#macro pagelink pageNo idx url>
    <#if (idx == 0)>
    <li><span>...</span></li>
    <#elseif (pageNo == idx)>
    <li class="active"><span>${idx}</span></li>
    <#else>
    <li><a href="${url}${idx}">${idx}</a></li>
    </#if>
</#macro>

<#macro showGroup channel>
	<#if (channel== 1) >
    	<span class="label label-success">文</span>
    <#elseif (channel == 2)>
    	<span class="label label-warning">问</span>
    <#elseif (channel == 3)>
    	<span class="label label-info">图</span>
    <#elseif (channel == 4)>
    	<span class="label label-violet">视频</span>
    <#elseif (channel == 5)>
    <span class="label label-danger">推荐</span>
    </#if>
</#macro>

<#setting date_format="yyyy-MM-dd">

<#macro showBlog row>
    <div class="stream-item" id="loop-${row.id}">
        <div class="article-title">
            <a href="${base}/view/${row.id}">
                 <@showGroup row.channelId/>
                <span class="h2-title">${row.title!}</span>
            </a>
        </div>
        <div class="summary">
            <a href="${base}/view/${row.id}">
                <div class="excerpt wordbreak">${row.summary!}</div>
            </a>
        </div>
        <div class="p-rank clearfix">
            <div class="users">
                <a href="${base}/ta/${row.author.id}">
                    <div class="ava">
                                    <@showAva row.author.avatar "img-circle"/>
                    </div>
                    <div class="info">
                        <span><small>${row.author.name}</small></span>
                    </div>
                </a>

                <div class="info">
                    <span><time> ${timeAgo(row.created)}</time></span>
                </div>
                <div class="info">
                <#--<i class="fa fa-tag"></i>-->
                    <#if row.tagsArray??>
                        <i >标签：</i>
                    </#if>

                            <#list  row.tagsArray as tag>
                              <a class="tag-link" href="${base}/tag/${tag}">${tag}</a>
                                <#if tag_has_next>
                                    ,
                                </#if>
                            </#list>
                </div>
            </div>
        </div>
    </div>
</#macro>
