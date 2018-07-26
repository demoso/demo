<#include "/default/utils/ui.ftl"/>

<@codelayout "在线代码工具">
<form autocomplete="off" role="form" action="${base}/codesave/codeview/web" method="post" enctype="multipart/form-data">
    <div class="row">
        <div class="LeftPane" id="LeftPane" style="width: 603px;">
            <div id="tz" class="handler"></div>
            <div class="row-fluid">
                <label class="inline" style="font-size: 16px;color: #fff;"> 编辑web前端代码:</label>
                <input id="submitBTN" onclick="submitTryit()" type="button" class="pull-right inline"
                       value="提交运行 &#187;">
                <input id="savecodebtn" type="button" class="pull-right inline" value="保存代码">
            </div>
            <textarea class="form-control" id="textareaCode"
                      name="textareaCode">${ret.content}</textarea>
        </div>
        <div class="RightPane" id="RightPane">
            <div class="zz"></div>
            <label style="font-size: 16px; padding-left: 10px;color: #fff;">运行效果：</label>
            <div id="iframewrapper">
            </div>
        </div>
    </div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="savecodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        请输入代码标题和概要说明
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="name">标题：</label>
                        <input type="text" class="form-control" name="title" maxlength="32"
                               data-required>
                    </div>
                    <div class="form-group">
                        <label for="name">说明：</label>
                        <textarea class="form-control" name="summary" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="name">标签：</label>
                        <input type="hidden" name="tags" id="fieldTags">
                        <ul id="tags"></ul>
                        <p class="help-block" style="font-size: 12px;">添加相关标签，用逗号或空格分隔 (最多4个).</p>
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