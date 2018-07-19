<#include "/default/utils/ui.ftl"/>
<@codelayout "在线代码工具">

<form autocomplete="off" role="form" action="${base}/codesave/coderun/${language}" method="post"
      enctype="multipart/form-data">
    <div class="row">
        <div class="LeftPane" id="LeftPane" style="width: 603px;">
            <div id="tz" class="handler"></div>
            <div class="row-fluid">
                <label class="inline"><strong style="font-size: 16px;"> 编辑${language}
                    代码:</strong></label>
                <input id="submitBTN" type="button" class="pull-right inline" value="提交运行 &#187;"
                       data-toggle="tooltip" title="如果代码运行时需要输入值，请先输入再提交运行">
                <input id="btninput" type="button" class="pull-right inline" value="标准输入"
                       data-toggle="tooltip" title="代码运行时需要的标准输入">
                <input data-toggle="modal" data-target="#myModal" type="button"
                       class="pull-right inline" value="保存代码" data-toggle="tooltip" title="登录后才能保存代码">
            </div>
            <div id="stdindiv" style="width: 100%; margin-top: 3px;">
                <div>输入：</div>
                <textarea rows="3" cols="100" id="stdin" style="width: 100%;"></textarea>
            </div>
            <textarea class="form-control" id="textareaCode"
                      name="textareaCode">${ret.content}</textarea>
        </div>
        <div class="RightPane" id="RightPane">
            <div class="zz"></div>
            <label><strong style="font-size: 16px;">运行效果：</strong></label>
            <div id="iframewrapper">
                <iframe id="iframeResult" class="result_output" frameborder="0" name="view"
                        width="400"></iframe>
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
    $('#stdindiv').hide();
    $("#btninput").click(function () {
        $("#stdindiv").toggle();
    });

    var editor = CodeMirror.fromTextArea(document.getElementById("textareaCode"), {
        lineNumbers: true,
        matchBrackets: true,
        mode: "text/x-java",
        indentUnit: 4,
        theme: "dracula",
        indentWithTabs: true
    });
    var ifr = document.createElement("iframe");
    ifr.setAttribute("frameborder", "0");
    ifr.setAttribute("id", "iframeResult");
    document.getElementById("iframewrapper").innerHTML = "";
    document.getElementById("iframewrapper").appendChild(ifr);
    var ifrw = (ifr.contentWindow) ? ifr.contentWindow : (ifr.contentDocument.document) ? ifr.contentDocument.document : ifr.contentDocument;

    $("#submitBTN").click(function () {
        code = editor.getValue();
        runcode = '${language}';
        stdinput = $("#stdin").val();
        loadingdata = '<img src="${base}/dist/images/loading.gif">';
        ifrw.document.open();
        ifrw.document.write(loadingdata);
        ifrw.document.close();
        $.post("http://120.55.164.177:8088/compile.php", {
            code: code,
            language: runcode,
            stdin: stdinput
        }, function (data) {
            text = data.cinfo.out + data.cinfo.err + data.rinfo.out.replace(/\r\n|\r|\n/g, "<br />") + data.rinfo.err;
            ifrw.document.open();
            ifrw.document.write('<pre>' + text + '</pre>');
            ifrw.document.close();
        });
    })
</script>
<script type="text/javascript">
    seajs.use('post', function (post) {
        post.init();
    });
</script>

</@codelayout>
