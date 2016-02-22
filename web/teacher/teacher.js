/**
 * Created by lin on 2016-02-15-015.
 */
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

    //上成绩
    $('.score-form').submit(function (e) {
        var msg = "<div class='alert alert-info alert-dismissible my-alert' role='alert'>" +
            "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">" +
            "<span aria-hidden=\"true\">&times;</span></button>" +
            "<strong>提示：</strong>";
        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            success: function (r) {
                msg += r.msg + '</div>';
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

    //修改密码
    $('#passwd-form').submit(function (e) {
        $('#old-pass').val($.md5("Orange" + $('#t-id').val() + $('#old-pass-plain').val()));
        $('#new-pass').val($.md5("Orange" + $('#t-id').val() + $('#new-pass-plain').val()));
        $.ajax({
            url: $(this).attr('action'),
            data: $(this).serialize(),
            type: 'POST',
            datatype: 'json',
            beforeSend: function () {
                $('#tip').html('&nbsp;');
            },
            success: function (r) {
                if (r.ok == 'true') {
                    $('#tip').html(r.msg + '（2秒后跳转）');
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                    $('#tip').html(r.msg);
                }
            },
            error: function () {
                $('#tip').html('出错了');
            },
        });
        return e.preventDefault();
    });
});