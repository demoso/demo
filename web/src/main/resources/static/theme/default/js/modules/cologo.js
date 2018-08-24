/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net/
|
+---------------------------------------------------------------------------
*/

define(function (require, exports, module) {
    J = jQuery;
    require('plugins');
    require('jcrop');

    var jcrop_api;
    var jcrop_init = false;
    var upload_url = app.base + '/post/upload?scale=true&size=300';
    var base_url = app.base;
    var uploadlogo_url = app.base + '/column/logosubmit';

    function getRandom() {
        var dim = jcrop_api.getBounds();
        return [
            Math.round(Math.random() * dim[0]),
            Math.round(Math.random() * dim[1]),
            Math.round(Math.random() * dim[0]),
            Math.round(Math.random() * dim[1])
        ];
    };

    function showCoords(c) {
        $('#x').val(c.x);
        $('#y').val(c.y);
        $('#width').val(c.w);
        $('#height').val(c.h);
    };

    function initJcrop() {
        $('#target').Jcrop({
            boxWidth: 240,
            aspectRatio: 100 / 100,
            onChange: showCoords,
            onSelect: showCoords,
            allowSelect: false
        }, function () {
            jcrop_api = this;
            jcrop_api.animateTo([100, 100, 300, 300]);
        });
    }

    $('#upload_btn').change(function () {
        $(this).upload(upload_url, function (data) {
            if (data.status == 200) {
                var path = base_url + data.path;
                $("#target").attr("src", path);
                $("#path").val(data.path);

                if (!jcrop_init) {
                    initJcrop();
                    jcrop_init = true;
                } else {
                    jcrop_api.setImage(path, function () {
                        this.animateTo(getRandom());
                    });
                }
            }
        });
    });

    $('#submit-button').click(function () {
        var x = $('#x').val();
        var y = $('#y').val();
        var width = $('#width').val();
        var height = $('#height').val();
        var path = $('#path').val();

        $.post("/column/logosubmit", {x: x, y: y, width: width, height: height, path: path}, function (data) {
            var path = data.replace("\"", "").replace("\"", "");
            $('#update_logo').empty();
            $('#update_logo').append('<img src="' + path + '" id="target" alt="[Example]"/>');
            $('#logo').val(path);
        });
    });

});