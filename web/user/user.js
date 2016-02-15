/**
 * Created by lin on 2016-02-15-015.
 */
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