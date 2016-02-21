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

    //选课/退选
    $('a.select').click(function (e) {
        var a = $(this);
        var url = $(this).attr('href');
        var urlbase = url.split('?')[0];
        var selected = false;
        if (url.split('?')[1].charAt(9) == 't') {
            selected = true;
        }
        console.log(urlbase + selected);
        $.ajax({
            type: 'POST',
            url: url,
            dataType: 'json',
            success: function (r) {
                if (r.ok == 'true') {
                    if (selected) {
                        //退选
                        a.html('选课').removeClass('btn-success').addClass('btn-primary');
                        a.attr('href', urlbase + '?' + url.split('?')[1].replace(/true/, 'false'));
                    } else {
                        //选课
                        a.html('退选').removeClass('btn-primary').addClass('btn-success');
                        a.attr('href', urlbase + '?' + url.split('?')[1].replace(/false/, 'true'));
                    }
                }
            },
            error: function () {
            },
        });
        return e.preventDefault();
    });

    //修改密码
    $('#user-passwd-form').submit(function (e) {
        var msg = "<div class='alert alert-danger alert-dismissible my-alert' role='alert'>" +
            "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">" +
            "<span aria-hidden=\"true\">&times;</span></button>" +
            "<strong>注意：</strong>";
        $('#old-passwd').val($.md5("Orange" + $('#user-id').val() + $('#passwd-plain').val()));
        $('#new-passwd').val($.md5("Orange" + $('#user-id').val() + $('#new-passwd-plain').val()));
        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            dataType: 'json',
            data: $(this).serialize(),
            success: function (r) {
                if (r.ok == 'true') {
                    msg += r.msg + '(2秒后跳转)</div>';
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else msg += r.msg + '</div>';
            },
            error: function () {
                msg += "出错了<div>";
            },
            complete: function () {
                $('#alert-tip').append(msg).css('top', ($(document.body).height() - $('#alert-tip').height()) / 2);
            }
        });
        return e.preventDefault();
    });
});