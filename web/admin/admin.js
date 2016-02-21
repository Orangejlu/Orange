jQuery(document).ready(function ($) {
    //active
    if (typeof (addMyClass) == 'function')addMyClass();

    $('#openbtn').click(function (e) {
        $.ajax({
            url: $(this).attr('href'),
            type: 'POST',
            dataType: 'json',
            success: function (r) {
                //console.log(r);
                if (r.ok == 'true')
                    if (r.msg == 'opened') {
                        $('#opened').html('开放');
                        $('#openbtn').html('关闭选课').attr('href', 'switch.do?open=false');
                    } else {
                        $('#opened').html('未开放');
                        $('#openbtn').html('开放选课').attr('href', 'switch.do?open=true');
                    }
            },
            error: function () {
                alert('出错了');
            }
        });
        return e.preventDefault();
    });

    $('#semester-form').submit(function (e) {
        $.ajax({
            url: $(this).attr('action'),
            type: 'GET',
            dataType: 'json',
            data: $(this).serialize(),
            success: function (r) {
                if (r.ok == 'true') {
                    $('#semester-current').html(r.msg);
                }
            },
            error: function () {
                alert('出错了');
            },
        });
        return e.preventDefault();
    });

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