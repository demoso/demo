<#include "/default/utils/ui.ftl"/>

<@codelayout "在线代码工具">
<div class="container" style="width:100%;height:100%; font-size:12px;">
    <div class="row" style="background-color: #e5eecc;">
        <div class="panel panel-default" style="margin-bottom:0;">
            <div class="panel-body" style="background-color: #f9f9f9;border-color: #f9f9f9;">
                <form autocomplete="off" role="form" action="${base}/post/identityPosts" method="post"
                      enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-sm-6" id="LeftPane">
                            <div class="row-fluid">
                                <label class="inline"><strong style="font-size: 16px;"> 编辑web前端代码:</strong></label>
                                <input id="submitBTN" onclick="submitTryit()" type="button" class="pull-right inline"
                                       value="提交运行 &#187;">
                                <input data-toggle="modal" data-target="#myModal" type="button"
                                       class="pull-right inline" value="保存代码">
                            </div>
                            <textarea class="form-control" id="textareaCode"
                                      name="textareaCode">${ret.content}</textarea>
                        </div>
                        <div class="col-sm-6" id="RightPane">
                            <label><strong style="font-size: 16px;">运行效果：</strong></label>
                            <div id="iframewrapper">
                            </div>
                        </div>
                    </div>
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
                </form>
            </div>
        </div>
    </div>
</div>


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
        lineNumbers: false,
        matchBrackets: true,
        indentUnit: 4,
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

</@codelayout>