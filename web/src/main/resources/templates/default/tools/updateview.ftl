<#include "/default/utils/ui.ftl"/>

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
            z-index: 100;
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
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    请输入代码标题和概要说明【登录后才能提交成功】
                </h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="name">标题：</label>
                    <input type="text" class="form-control" name="title" maxlength="32"
                           value="${ret.title}">
                    <input type="hidden" name="viewid" value="${viewid}">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="submit" class="btn btn-primary">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- content -->
<div class="wrap">
    <!-- Main -->
    <div class="container">
        <div class="row">
            <div class="main clearfix">
                <div class="col-xs-12 col-md-12">
                    <form autocomplete="off" role="form" action="${base}/post/identityPosts" method="post"
                          enctype="multipart/form-data">
                        <div class="row">
                            <div class="LeftPane" id="LeftPane" style="width: 603px;">
                                <div id="tz" class="handler"></div>
                                <div class="row-fluid">
                                    <label class="inline"><strong style="font-size: 16px;"> 编辑web前端代码:</strong></label>
                                    <input id="submitBTN" onclick="submitTryit()" type="button"
                                           class="pull-right inline"
                                           value="提交运行 &#187;">
                                    <input data-toggle="modal" data-target="#myModal" type="button"
                                           class="pull-right inline" value="保存代码">
                                </div>
                                <textarea class="form-control" id="textareaCode"
                                          name="textareaCode">${ret.content}</textarea>
                            </div>
                            <div class="RightPane" id="RightPane">
                                <div class="zz"></div>
                                <label><strong style="font-size: 16px;">运行效果：</strong></label>
                                <div id="iframewrapper">
                                </div>
                            </div>
                        </div>
                    </form>
                    <script type="text/javascript">
                        $(function () {
                            bindResize(document.getElementById('LeftPane'));
                        });

                        function bindResize(el) {
                            var els = el.style,
                                    x = y = 0;
                            $("#tz").mousedown(function (e) {
                                $(".zz").css("display", "block");
                                x = e.clientX - el.offsetWidth,
                                        el.setCapture ? (
                                                el.setCapture(),
                                                        el.onmousemove = function (ev) {
                                                            mouseMove(ev || event);
                                                        },
                                                        el.onmouseup = mouseUp
                                        ) : (
                                                $(document).bind("mousemove", mouseMove).bind("mouseup", mouseUp)
                                        );
                                e.preventDefault();
                            });
                            $("#tz").mouseup(function () {
                                $(".zz").css("display", "none");
                            });

                            function mouseMove(e) {
                                $(".LeftPane").width(e.clientX - x + 'px');

                            }

                            function mouseUp() {
                                el.releaseCapture ? (
                                        el.releaseCapture(),
                                                el.onmousemove = el.onmouseup = null
                                ) : (
                                        $(document).unbind("mousemove", mouseMove).unbind("mouseup", mouseUp)
                                );
                            }
                        }
                    </script>

                    <script>
                        var mixedMode = {
                            name: "htmlmixed",
                            scriptTypes: [{
                                matches: /\/x-handlebars-template|\/x-mustache/i,
                                mode: null
                            },
                                {
                                    matches: /(text|application)\/(x-)?vb(a|script)/i,
                                    mode: "vbscript"
                                }]
                        };
                        var editor = CodeMirror.fromTextArea(document.getElementById("textareaCode"), {
                            mode: mixedMode,
                            selectionPointer: true,
                            lineNumbers: true,
                            matchBrackets: true,
                            indentUnit: 4,
                            theme: "dracula",
                            indentWithTabs: true
                        });

                        function submitTryit() {
                            var text = editor.getValue();
                            var patternHtml = /<html[^>]*>((.|[\n\r])*)<\/html>/im
                            var patternHead = /<head[^>]*>((.|[\n\r])*)<\/head>/im
                            var array_matches_head = patternHead.exec(text);
                            var patternBody = /<body[^>]*>((.|[\n\r])*)<\/body>/im;

                            var array_matches_body = patternBody.exec(text);
                            var basepath_flag = 1;
                            var basepath = '';
                            if (basepath_flag) {
                                basepath = '<base href="/www.demoso.net/try/demo_source/" target="_blank">';
                            }
                            if (array_matches_head) {
                                text = text.replace('<head>', '<head>' + basepath);
                            } else if (patternHtml) {
                                text = text.replace('<html>', '<head>' + basepath + '</head>');
                            } else if (array_matches_body) {
                                text = text.replace('<body>', '<body>' + basepath);
                            } else {
                                text = basepath + text;
                            }
                            text = text.replace('<head>', '<head><link rel="stylesheet" media="all" href="/assets/css/addons.css"/>');
                            var ifr = document.createElement("iframe");
                            ifr.setAttribute("frameborder", "0");
                            ifr.setAttribute("id", "iframeResult");
                            document.getElementById("iframewrapper").innerHTML = "";
                            document.getElementById("iframewrapper").appendChild(ifr);

                            var ifrw = (ifr.contentWindow) ? ifr.contentWindow : (ifr.contentDocument.document) ? ifr.contentDocument.document : ifr.contentDocument;
                            ifrw.document.open();
                            ifrw.document.write(text);
                            ifrw.document.close();
                        }

                        submitTryit();

                    </script>
                    <script type="text/javascript">
                        seajs.use('post', function (post) {
                            post.init();
                        });
                    </script>
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
