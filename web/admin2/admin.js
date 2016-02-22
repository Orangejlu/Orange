jQuery(document).ready(function ($) {
    if (typeof (addmyclass) == "function") {
        addmyclass();
    }
    //获取公告
    $('#notice-detail').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var modal = $(this);
        modal.find('#notice-title').html(button.data('noticetitle'));
        modal.find('#notice-pubtime').html(button.data('noticepubtime'));
        var link = modal.find('#notice-remote-uri').attr('href')
            + 'getnoticecontent.do?noticeid=' + button.data('noticeid');
        var contentbody = $('#notice-content');
        jQuery.ajax({
            type: 'GET',
            url: link,
            beforeSend: function () {
                contentbody.html('正在加载...');
            },
            datatype: "html",
            success: function (result) {
                contentbody.html(result);
            },
            error: function (out) {
                contentbody.html("很抱歉，发生了错误，获取公告内容失败。+<pre>" + out + "</pre>");
            }
        });
    });

    //region teacher
    //文件上传
    $('#file-dlg').on('shown.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var modal = $(this);
        var content = modal.find('#file-upload-content');
        $('#btn-todb').html('');
        //http://yunzhu.iteye.com/blog/2177923
        var formData = new FormData($("#addfileform")[0]);
        $.ajax({
            url: button.data('upload-url'),
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                $('#loading').css('display', 'none');
                content.html(returndata);
                //$('#btn-todb').removeAttr('disabled');
            },
            error: function (returndata) {
                $('#loading').css('display', 'none');
                content.html(returndata);
                //$('#btn-todb').attr("disabled", true);
            }
        });
    });

    //添加单个教师
    $('#add-one-teacher-submit').click(function () {
        $('#addpass').val($.md5("Orange" + $('#addid').val() + $('#addpassPlain').val()));
        $.ajax({
            type: 'POST',
            url: $('#add-one-teacher-form').attr('action'),
            data: $('#add-one-teacher-form').serialize(),
            beforeSend: function () {
                if ($('#addid').val() == "" || $('#addname').val() == "") return false;
                $('#add-one-teacher-submit').attr('disabled', true);
                $('#add-one-teacher-result').html("");
            },
            complete: function () {
                $('#add-one-teacher-submit').removeAttr('disabled');
            },
            success: function (result) {
                $('#add-one-teacher-result').html(result);
            },
            error: function (result) {
                $('#add-one-teacher-result').html(result);
            }
        });
    });

    //更改教师信息
    $('#edit').on('show.bs.modal', function (e) {
        var b = $(e.relatedTarget);
        var m = $(this);
        m.find('#t-id').val(b.data('id'));
        m.find('#t-name').val(b.data('name'));
        m.find('#t-level').val(b.data('level'));
        m.find('#t-email').val(b.data('email'));
        $('#msg').html('&nbsp;');
    });
    $('#edit-form').submit(function (e) {
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'json',
            success: function (r) {
                if (r.ok == 'true') {
                    $('#msg').html(r.msg + ' (2秒后跳转)')
                        .hide().show('nomal', function () {
                        setTimeout(function () {
                            $('#edit').modal('hide');
                            location.reload();
                        }, 2000);
                    });
                } else {
                    $('#msg').html(r.msg);
                }
            },
            error: function () {
                $('#msg').html('出错了');
            }
        });
        return e.preventDefault();
    });

    //重置密码//删除单个教师
    $('#alert').on('show.bs.modal', function (e) {
        var b = $(e.relatedTarget);
        var c = $('#alert-content');
        var type = b.data('type');
        var id = b.data('id');
        var name = b.data('name1');
        if (type == 'reset') {
            c.html('<div><p>您正重置<mark>' + name + '</mark>的密码,此操作不可撤销，是否继续?</p>' +
                '<div class="btn-group"><button class="btn btn-warning"' +
                ' onclick="resetOrDelete(' + id + ',0)">是,重置</button>' +
                '<button class="btn btn-primary" data-dismiss="modal">否,关闭</button></div>' +
                '<div id="tip" class="text-danger">&nbsp;</div></div>');
        }
        else if (type == 'delete') {
            c.html('<div><p>您正打算删除用户<mark>' + name + '</mark>,此操作不可撤销，是否继续?</p>' +
                '<div class="btn-group"><button class="btn btn-danger" ' +
                'onclick="resetOrDelete(' + id + ',1)">是,删除</button>' +
                '<button class="btn btn-primary" data-dismiss="modal">否,关闭</button></div>' +
                '<div id="tip" class="text-danger">&nbsp;</div></div>');
        }
    });
    //endregion
    //region student
    //上传学生名单
    $('#stu-file-dlg').on('shown.bs.modal', function (e) {
        var form = $('#stu-file-upload-form');
        var formData = new FormData($('#stu-file-upload-form')[0]);
        //console.log(form.attr('action'));
        $.ajax({
            url: form.attr('action'),
            data: formData,
            type: 'POST',
            contentType: false,//这句不可少,否则上传的contentType还是urlencoded而不是multipart/form-data
            processData: false,//这句不可少，否则报错Uncaught TypeError: Illegal invocation
            /*
             contentType
             类型：String
             默认值: "application/x-www-form-urlencoded"。发送信息至服务器时内容编码类型。
             默认值适合大多数情况。如果你明确地传递了一个 content-type 给 $.ajax()
             那么它必定会发送给服务器（即使没有数据要发送）。

             processData
             类型：Boolean
             默认值: true。
             默认情况下，通过data选项传递进来的数据，如果是一个对象(技术上讲只要不是字符串)，
             都会处理转化成一个查询字符串，以配合默认内容类型 "application/x-www-form-urlencoded"。
             如果要发送 DOM 树信息或其它不希望转换的信息，请设置为 false。

             http://www.w3school.com.cn/jquery/ajax_ajax.asp
             */
            beforeSend: function () {
                $('#stu-modal-body-content').html('正在上传，请稍后……');
                $('#stu-file-loading').show();
            },
            complete: function () {
                $('#stu-file-loading').hide();
            },
            success: function (r) {
                if (r.ok == "true") {
                    var result = "<table class=\"table table-striped table-hover\"><thread><tr><th>教学号</th><th>学号</th><th>姓名</th><th>性别</th><th>年级</th></tr></thread><tbody>";
                    $.each(r.msg, function (i, item) {
                        result += "<tr><td>" + item.no + "</td>" + "<td>" + item.no2 + "</td><td>" + item.name + "</td><td>" + item.gender + "</td>" + "<td>" + item.grade + "</td></tr>";
                    });
                    result += "</tbody></table>";
                    $('#stu-modal-body-content').html(result);
                    var todb = "<button data-href='" + form.attr('action') + "' id='stu-file-todb'" +
                        " onclick='stuToDB()'" + "class='btn btn-primary'>确认无误,写入数据库</button>";
                    $('#stu-modal-body-msg').html(todb);
                } else {
                    $('#stu-modal-body-msg').html(r.msg);
                }
            },
            error: function () {
                $('#stu-modal-body-msg').html('出错了');
            }
        });
    });

    //编辑学生信息
    $('#edit-stu-detail').on('show.bs.modal', function (e) {
        var b = $(e.relatedTarget);
        var m = $(this);
        m.find('#edit-stu-id').val(b.data('id'));
        m.find('#edit-stu-id2').val(b.data('id2'));
        m.find('#edit-stu-name').val(b.data('name'));
        m.find('#edit-stu-gender').val(b.data('gender'));
        m.find('#edit-stu-grade').val(b.data('grade'));
    });
    $('#edit-stu-detail-form').submit(function (e) {
        $.ajax({
            type: 'post',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'json',
            beforeSend: function () {
                $('#info').html('&nbsp;');
            },
            success: function (r) {
                if (r.ok == 'true') {
                    $('#info').html('修改成功,页面正在跳转');
                    location.reload();
                } else {
                    $('#info').html(r.msg);
                }
            },
            error: function () {
                $('#info').val('发生了错误')
            }
        });
        return e.preventDefault();
    });

    $('#reset-passwd').click(function () {
        $('#all-stu-type').val('reset');
    });
    $('#delete-stu').click(function () {
        $('#all-stu-type').val('delete');
    });
    $('#all-stu').submit(function (e) {
        var list = document.getElementsByName('check-list');
        var hascheck = false;
        for (var i = 0; i < list.length; i++) {
            if (list[i].checked) {
                hascheck = true;
            }
        }
        if (!hascheck) {
            $('#msg').html('至少选中一项');
            return e.preventDefault();
        }
        $.ajax({
            type: 'post',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'json',
            beforeSend: function () {
                $('#msg').html('&nbsp;');
            },
            success: function (r) {
                if (r.ok == 'true') {
                    $('#msg').html(r.msg);
                    if ($('#all-stu-type').val() == 'delete') {
                        $('#msg').append(' 2秒后自动刷新页面');
                        setTimeout(function () {
                            location.reload();
                        }, 2000);
                    }
                }
                else {
                    $('#msg').html(r.msg);
                }
            },
            error: function () {
                $('#msg').html('出错了');
            }
        });
        return e.preventDefault();
    });

    //添加单个学生
    $('#add-one-stu').submit(function (e) {
        $.ajax({
            type: 'post',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'json',
            beforeSend: function () {
                $('#tip').html('&nbsp;');
            },
            success: function (r) {
                if (r.ok == 'true') {
                    location.reload();
                } else {
                    $('#tip').html(r.msg);
                }
            },
            error: function () {
                $('#tip').html('出错了');
            }
        });
        return e.preventDefault();
    });
    //endregion
    //region course
    //添加
    $('.add-course').submit(function (e) {
        var tip = $(this).data("msg");
        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            dataType: "json",
            beforeSend: function () {
                $(tip).html("");
            },
            success: function (r) {
                if (r.ok == "true") {
                    $(tip).html(r.msg + "(2秒后跳转)");
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else
                    $(tip).html(r.msg);
            },
            error: function () {
                $(tip).html("出错了")
            }
        });
        return e.preventDefault();
    });
    //删除
    $('.course-delete').click(function (e) {
        //$(document.body).height()
        var msg = "<div class='alert alert-danger alert-dismissible my-alert' role='alert'>" +
            "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">" +
            "<span aria-hidden=\"true\">&times;</span></button>" +
            "<strong>注意：</strong>";
        $.ajax({
            type: 'GET',
            url: $(this).attr('href'),
            dataType: 'json',
            success: function (r) {
                if (r.ok == "true") {
                    msg += r.msg + "(2秒后跳转)</div>";
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                    msg += r.msg + "</div>";
                }
            },
            error: function () {
                msg += "出错了</div>";
            },
            complete: function () {
                $('#alert-tip').append(msg).css('top', ($(document.body).height() - $('#alert-tip').height()) / 2);
            }
        });
        return e.preventDefault();
    });

    $('#sec-dept').multiselect({
        buttonContainer: '<div class="btn-group form-control" />',
        inheritClass: true,
        enableFiltering: true,
        includeSelectAllOption: true,
        selectAllJustVisible: false,
        selectAllText: '全选',
        nonSelectedText: '未选择',
        nSelectedText: ' - 项已选',
        allSelectedText: '已全选',
        filterPlaceholder: '搜索'
    });
    //$('input.multiselect-search').attr('placeholder','搜索');
    //endregion

    //更改密码
    $('#change-pass').submit(function (e) {
        $('#oldpass').val($.md5('Orange' + $('#name').val() + $('#oldpassPlain').val()));
        $('#newpass').val($.md5('Orange' + $('#name').val() + $('#newpassPlain').val()));
        $('#tip').html('&nbsp;');
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'json',
            success: function (r) {
                if (r.ok == 'true') {
                    location.reload();
                }
                else {
                    $('#tip').html(r.msg);
                }
            },
            error: function () {
                $('#tip').html('出错了');
            }
        });
        return e.preventDefault();
    });

});

function stuToDB() {
    //console.log('click');
    $.ajax({
        type: 'GET',
        url: $('#stu-file-todb').data('href'),
        dataType: 'json',
        success: function (r) {
            if (r.ok == "true") {
                $('#stu-modal-body-msg').append("<br>" + r.msg + "(2秒后跳转)");
                setTimeout(function () {
                    location.reload();
                }, 2000);
            }
            else {
                $('#stu-modal-body-msg').append("<br><p class='text-danger'>" + r.msg + "(可能是已有重复记录)</p>");
            }
        },
        error: function () {
            $('#stu-modal-body-msg').append("<br><p class='text-danger'></p>");
        }
    });
}
//重置密码//删除单个教师
function resetOrDelete(id, type) {
    $.ajax({
        type: 'GET',
        url: 'admin2/resetOrDelete.do',
        data: {'id': id, 'type': type},
        dataType: 'json',
        beforeSend: function () {
            $('#tip').html('&nbsp;');
        },
        success: function (r) {
            if (r.ok == 'true') {
                if (type == 0) {
                    $('#tip').html(r.msg + ' ( 2 秒后自动关闭对话框)').hide().show('slow', function () {
                        setTimeout(function () {
                            $('#alert').modal('hide');
                        }, 2000);
                    });
                }
                if (type == 1) {
                    $('#tip').html(r.msg).hide().show('normal', function () {
                        location.reload();
                    });
                }
            } else {
                $('#tip').html(r).hide().show();
            }
        },
        error: function () {
            $('#tip').html('网络出错了').hide().show();
        }
    });
}