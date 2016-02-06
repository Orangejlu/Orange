/*https://github.com/placemarker/jQuery-MD5/blob/master/jquery.md5.js*/(function(f){function n(t,w){var v=(t&65535)+(w&65535),u=(t>>16)+(w>>16)+(v>>16);return(u<<16)|(v&65535)}function r(t,u){return(t<<u)|(t>>>(32-u))}function c(A,w,v,u,z,y){return n(r(n(n(w,A),n(u,y)),z),v)}function b(w,v,B,A,u,z,y){return c((v&B)|((~v)&A),w,v,u,z,y)}function h(w,v,B,A,u,z,y){return c((v&A)|(B&(~A)),w,v,u,z,y)}function m(w,v,B,A,u,z,y){return c(v^B^A,w,v,u,z,y)}function a(w,v,B,A,u,z,y){return c(B^(v|(~A)),w,v,u,z,y)}function d(E,z){E[z>>5]|=128<<((z)%32);E[(((z+64)>>>9)<<4)+14]=z;var v,y,w,u,t,D=1732584193,C=-271733879,B=-1732584194,A=271733878;for(v=0;v<E.length;v+=16){y=D;w=C;u=B;t=A;D=b(D,C,B,A,E[v],7,-680876936);A=b(A,D,C,B,E[v+1],12,-389564586);B=b(B,A,D,C,E[v+2],17,606105819);C=b(C,B,A,D,E[v+3],22,-1044525330);D=b(D,C,B,A,E[v+4],7,-176418897);A=b(A,D,C,B,E[v+5],12,1200080426);B=b(B,A,D,C,E[v+6],17,-1473231341);C=b(C,B,A,D,E[v+7],22,-45705983);D=b(D,C,B,A,E[v+8],7,1770035416);A=b(A,D,C,B,E[v+9],12,-1958414417);B=b(B,A,D,C,E[v+10],17,-42063);C=b(C,B,A,D,E[v+11],22,-1990404162);D=b(D,C,B,A,E[v+12],7,1804603682);A=b(A,D,C,B,E[v+13],12,-40341101);B=b(B,A,D,C,E[v+14],17,-1502002290);C=b(C,B,A,D,E[v+15],22,1236535329);D=h(D,C,B,A,E[v+1],5,-165796510);A=h(A,D,C,B,E[v+6],9,-1069501632);B=h(B,A,D,C,E[v+11],14,643717713);C=h(C,B,A,D,E[v],20,-373897302);D=h(D,C,B,A,E[v+5],5,-701558691);A=h(A,D,C,B,E[v+10],9,38016083);B=h(B,A,D,C,E[v+15],14,-660478335);C=h(C,B,A,D,E[v+4],20,-405537848);D=h(D,C,B,A,E[v+9],5,568446438);A=h(A,D,C,B,E[v+14],9,-1019803690);B=h(B,A,D,C,E[v+3],14,-187363961);C=h(C,B,A,D,E[v+8],20,1163531501);D=h(D,C,B,A,E[v+13],5,-1444681467);A=h(A,D,C,B,E[v+2],9,-51403784);B=h(B,A,D,C,E[v+7],14,1735328473);C=h(C,B,A,D,E[v+12],20,-1926607734);D=m(D,C,B,A,E[v+5],4,-378558);A=m(A,D,C,B,E[v+8],11,-2022574463);B=m(B,A,D,C,E[v+11],16,1839030562);C=m(C,B,A,D,E[v+14],23,-35309556);D=m(D,C,B,A,E[v+1],4,-1530992060);A=m(A,D,C,B,E[v+4],11,1272893353);B=m(B,A,D,C,E[v+7],16,-155497632);C=m(C,B,A,D,E[v+10],23,-1094730640);D=m(D,C,B,A,E[v+13],4,681279174);A=m(A,D,C,B,E[v],11,-358537222);B=m(B,A,D,C,E[v+3],16,-722521979);C=m(C,B,A,D,E[v+6],23,76029189);D=m(D,C,B,A,E[v+9],4,-640364487);A=m(A,D,C,B,E[v+12],11,-421815835);B=m(B,A,D,C,E[v+15],16,530742520);C=m(C,B,A,D,E[v+2],23,-995338651);D=a(D,C,B,A,E[v],6,-198630844);A=a(A,D,C,B,E[v+7],10,1126891415);B=a(B,A,D,C,E[v+14],15,-1416354905);C=a(C,B,A,D,E[v+5],21,-57434055);D=a(D,C,B,A,E[v+12],6,1700485571);A=a(A,D,C,B,E[v+3],10,-1894986606);B=a(B,A,D,C,E[v+10],15,-1051523);C=a(C,B,A,D,E[v+1],21,-2054922799);D=a(D,C,B,A,E[v+8],6,1873313359);A=a(A,D,C,B,E[v+15],10,-30611744);B=a(B,A,D,C,E[v+6],15,-1560198380);C=a(C,B,A,D,E[v+13],21,1309151649);D=a(D,C,B,A,E[v+4],6,-145523070);A=a(A,D,C,B,E[v+11],10,-1120210379);B=a(B,A,D,C,E[v+2],15,718787259);C=a(C,B,A,D,E[v+9],21,-343485551);D=n(D,y);C=n(C,w);B=n(B,u);A=n(A,t)}return[D,C,B,A]}function o(u){var v,t="";for(v=0;v<u.length*32;v+=8){t+=String.fromCharCode((u[v>>5]>>>(v%32))&255)}return t}function i(u){var v,t=[];t[(u.length>>2)-1]=undefined;for(v=0;v<t.length;v+=1){t[v]=0}for(v=0;v<u.length*8;v+=8){t[v>>5]|=(u.charCodeAt(v/8)&255)<<(v%32)}return t}function j(t){return o(d(i(t),t.length*8))}function e(v,y){var u,x=i(v),t=[],w=[],z;t[15]=w[15]=undefined;if(x.length>16){x=d(x,v.length*8)}for(u=0;u<16;u+=1){t[u]=x[u]^909522486;w[u]=x[u]^1549556828}z=d(t.concat(i(y)),512+y.length*8);return o(d(w.concat(z),512+128))}function s(v){var y="0123456789abcdef",u="",t,w;for(w=0;w<v.length;w+=1){t=v.charCodeAt(w);u+=y.charAt((t>>>4)&15)+y.charAt(t&15)}return u}function l(t){return unescape(encodeURIComponent(t))}function p(t){return j(l(t))}function k(t){return s(p(t))}function g(t,u){return e(l(t),l(u))}function q(t,u){return s(g(t,u))}f.md5=function(u,v,t){if(!v){if(!t){return k(u)}else{return p(u)}}if(!t){return q(v,u)}else{return g(v,u)}}}(typeof jQuery==="function"?jQuery:this));
jQuery(document).ready(function ($) {
    //active
    if (typeof (addMyClass) == 'function')addMyClass();

    //公告详情
    $('#detail').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var modal = $(this);
        //标题，日期，类型
        modal.find('#notice-title').html(button.data('title'));
        modal.find('#notice-time').html(button.data('time1'));
        var type = button.data('type');
        type = type.toString();
        var types = '';
        if (type.match('1')) {
            types += '<input type="checkbox" checked disabled id="type1">教务';
        } else {
            types += '<input type="checkbox" disabled id="type1">教务';
        }
        if (type.match('2')) {
            types += '<input type="checkbox" disabled checked id="type2">教师';
        } else {
            types += '<input type="checkbox" disabled id="type2" >教师';
        }
        if (type.match('3')) {
            types += '<input type="checkbox" disabled checked id="type3">学生';
        } else {
            types += '<input type="checkbox" disabled id="type3">学生';
        }
        $('#types').html(types);
        //内容
        var content = $('#notice-content');
        $.ajax({
            type: 'GET',
            url: 'getnoticecontent.do',
            data: {'noticeid': button.data('id')},
            beforeSend: function () {
                content.html('正在加载');
            },
            success: function (r) {
                content.html(r);
            },
            error: function () {
                content.html('网络出错');
            }
        });
    });

    //Ctrl+Enter提交
    jQuery(document).keypress(function (e) {
        if ((e.ctrlKey && e.which == 13 || e.which == 10)
            && $('body').hasClass('modal-open')) {
            jQuery("#sbm").click();
        }
    });

    //发公告
    $('#add-notice-form').submit(function (e) {
        $.ajax({
            type: 'POST',
            data: $('#add-notice-form').serialize(),
            url: $('#add-notice-form').attr('action'),
            dataType: 'json',
            beforeSend: function () {
                //检查至少选中一项
                $('input[name="admin2"]').attr('checked');
                $('#sbm').attr('disabled', true);
                $('#sbm2').attr('disabled', true);
            },
            complete: function () {
                $('#sbm').attr('disabled', false);
                $('#sbm2').attr('disabled', false);
            },
            success: function (data) {
                if (data.ok == "true") {
                    location.reload();
                } else {
                    $('#tip').html(data.msg);
                }
            },
            error: function () {
                alert("网络出错了");
            }
        });
        return e.preventDefault();
    });

    //删除公告
    $('.delete-notice').click(function (e) {
        $.ajax({
            type: 'GET',
            url: $(this).attr('href'),
            dataType: 'json',
            success: function (data) {
                if (data.ok == "true") {
                    location.reload();
                } else {
                    alert(data.msg);
                }
            },
            error: function () {
                alert("网络出错");
            }
        });
        return e.preventDefault();
    });

    //添加院系
    $('#add-dept-form').submit(function (e) {
        $.ajax({
            type: 'POST',
            url: $('#add-dept-form').attr('action'),
            data: $('#add-dept-form').serialize(),
            dataType: 'json',
            beforeSend: function () {
                $('#sbm').attr('disabled', true);
            },
            complete: function () {
                $('#sbm').attr('disabled', false);
            },
            success: function (r) {
                if (r.ok == "true") {
                    location.reload();
                }
                else {
                    $('#tip').html(r.msg);
                }
            },
            error: function () {
                alert('网络出错');
            }
        });
        return e.preventDefault();
    });

    //删除院系
    $('.delete-dept').click(function (e) {
        $.ajax({
            type: 'GET',
            url: $(this).attr('href'),
            dataType: 'json',
            success: function (r) {
                if (r.ok == "true") {
                    location.reload();
                } else {
                    alert(r.msg);
                }
            }, error: function () {
            }
        });
        return e.preventDefault();
    });

    //添加用户
    $('#add-admin-form').submit(function (e) {
        $("#password").val($.md5("Orange" + $("#uname").val() + $("#passwdPlain").val()));
        $.ajax({
            type: 'POST',
            url: $('#add-admin-form').attr('action'),
            dataType: 'json',
            data: $('#add-admin-form').serialize(),
            beforeSend: function () {
                $('#tip').html('');
                var reg = /^[A-Za-z]+$/;
                var t = $('#uname').val().toString()[0];
                if (!reg.test(t)) {
                    $('#tip').html('用户名必须是字母开头');
                    return false;
                }
                if ($('#uname').val() == '' || $('#passwdPlain').val() == '') {
                    $('#tip').html('用户名或密码不能为空');
                    return false;
                }
                if ($('#adddept').get(0).selectedIndex == 0) {
                    $('#tip').html('请从下拉框选择一项');
                    return false;
                }
                $('#add-admin-sbm').attr('disabled', true);
            },
            complete: function () {
                $('#add-admin-sbm').attr('disabled', false);
            },
            success: function (r) {
                if (r.ok == "true") {
                    location.reload();
                } else {
                    $('#tip').html(r.msg);
                }
            },
            error: function () {
            }
        });
        return e.preventDefault();
    });

    //修改用户密码
    $('#changepasswd').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var name = button.data('name');
        var modal = $(this);
        modal.find('#username').val(name);
        $('#msg').html('&nbsp;');
        $('#passwdPlain').html('');
    });
    $("#change-passwd-form").submit(function (e) {
        $("#newpasswd").val($.md5("Orange" + $("#username").val() + $("#newpasswdPlain").val()));
        $.ajax({
            type: 'POST',
            url: $("#change-passwd-form").attr('action'),
            data: $("#change-passwd-form").serialize(),
            dataType: 'json',
            beforeSend: function () {
                if ($("#username").val() == '' || $("#newpasswdPlain").val() == '') {
                    $('#msg').html('用户名或密码不能为空');
                    return false;
                }
                $('#sbm').attr('disabled', true);
                $('#sbm2').attr('disabled', true);
            },
            complete: function () {
                $('#sbm').attr('disabled', false);
                $('#sbm2').attr('disabled', false);
            },
            success: function (r) {
                $('#msg').html(r.msg + ', 您可以关闭此对话框');
            },
            error: function () {
            }
        });
        return e.preventDefault();
    });

    //删除用户
    $('#deleteconfirm').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('name');
        var modal = $(this);
        modal.find('#deleteuserspan').text(name);
        $('#info').html('&nbsp;');
    });
    $('#deleteusera').click(function (e) {
        $.ajax({
            type: 'GET',
            url: $('#deleteusera').attr('href'),
            data: {'name': $('#deleteuserspan').text()},
            dataType: 'json',
            beforeSend: function () {
                $('#deleteusera').attr('disabled', true);
            },
            complete: function () {
                $('#deleteusera').attr('disabled', false);
            },
            success: function (r) {
                if (r.ok == 'true') {
                    location.reload();
                }
                else {
                    $('#info').html(r.msg);
                }
            },
            error: function () {
            }
        });
        return e.preventDefault();
    });

    //修改密码
    $("#passwd-form").submit(function (e) {
        $("#oldpass").val($.md5("Orange" + $("#name").val() + $("#oldpassPlain").val()));
        $('#newpass').val($.md5("Orange" + $('#name').val() + $('#newpassPlain').val()));
        $.ajax({
            type: 'POST',
            url: $("#passwd-form").attr('action'),
            data: $("#passwd-form").serialize(),
            dataType: 'json',
            beforeSend: function () {
                $("#sbm").attr('disabled', true);
            },
            complete: function () {
                $("#sbm").attr('disabled', false);
            },
            success: function (r) {
                console.log(r);
                if (r.ok == "true") {
                    location.reload();
                }
                else {
                    $('#tip').html(r.msg);
                }
            },
            error: function (a, b, c) {
                console.log(a + '\n' + b + '\n' + c);
            }
        });
        return e.preventDefault();
    });


});
