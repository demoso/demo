/*
 +--------------------------------------------------------------------------
 |   Mblog [#RELEASE_VERSION#]
 |   ========================================
 |   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
 |   http://www.demoso.net
 |
 +---------------------------------------------------------------------------
 */

define(function (require, exports, module) {
    J = jQuery;

    var Loginfresh = {
        isAuthced: function () {
            return (typeof(window.app.LOGIN_TOKEN) != 'undefined' && window.app.LOGIN_TOKEN.length > 0);
        },
        showLogin: function () {
            var that = this;
            $('#login_alert').modal();

            $('#ajax_login_submit').unbind().click(function () {
                that.doPostLogin();
            });
        },
        doPostLogin: function () {
            var un = $('#ajax_login_username').val();
            var pw = $('#ajax_login_password').val();
            jQuery.post(app.base + '/api/login', {'username': un, 'password': pw}, function (ret) {
                if (ret && ret.code == 0) {
                    $.get("/api/profile", function (ret) {
                        if (ret && ret.code == 0) {
                            profile = ret.data;
                            window.app.LOGIN_TOKEN = String(profile.id);
                            $('.header_user-li-sign').remove();

                            $('#header_user').append('<li class="dropdown"> <a href="#" class="user dropdown-toggle" data-toggle="dropdown"> ' +
                                ' <img class="img-circle" src="' + window.app.base + profile.avatar + '">' +
                                ' <span>' + profile.name + '</span> </a><ul class="dropdown-menu" role="menu">' +
                                ' <li><a href="' + window.app.base + '/user">我的主页</a></li><li><a href="' + window.app.base + '/user/profile">编辑资料</a></li>' +
                                ' <li><a href="' + window.app.base + '/logout">退出</a></li></ul></li>');
                        }
                    });
                    $('#login_alert').modal('hide');
                } else {
                    $('#ajax_login_message').text(ret.message).show();
                }
            });
        }
    };

    module.exports = Loginfresh;
});