/*https://github.com/placemarker/jQuery-MD5/blob/master/jquery.md5.js*/(function(f){function n(t,w){var v=(t&65535)+(w&65535),u=(t>>16)+(w>>16)+(v>>16);return(u<<16)|(v&65535)}function r(t,u){return(t<<u)|(t>>>(32-u))}function c(A,w,v,u,z,y){return n(r(n(n(w,A),n(u,y)),z),v)}function b(w,v,B,A,u,z,y){return c((v&B)|((~v)&A),w,v,u,z,y)}function h(w,v,B,A,u,z,y){return c((v&A)|(B&(~A)),w,v,u,z,y)}function m(w,v,B,A,u,z,y){return c(v^B^A,w,v,u,z,y)}function a(w,v,B,A,u,z,y){return c(B^(v|(~A)),w,v,u,z,y)}function d(E,z){E[z>>5]|=128<<((z)%32);E[(((z+64)>>>9)<<4)+14]=z;var v,y,w,u,t,D=1732584193,C=-271733879,B=-1732584194,A=271733878;for(v=0;v<E.length;v+=16){y=D;w=C;u=B;t=A;D=b(D,C,B,A,E[v],7,-680876936);A=b(A,D,C,B,E[v+1],12,-389564586);B=b(B,A,D,C,E[v+2],17,606105819);C=b(C,B,A,D,E[v+3],22,-1044525330);D=b(D,C,B,A,E[v+4],7,-176418897);A=b(A,D,C,B,E[v+5],12,1200080426);B=b(B,A,D,C,E[v+6],17,-1473231341);C=b(C,B,A,D,E[v+7],22,-45705983);D=b(D,C,B,A,E[v+8],7,1770035416);A=b(A,D,C,B,E[v+9],12,-1958414417);B=b(B,A,D,C,E[v+10],17,-42063);C=b(C,B,A,D,E[v+11],22,-1990404162);D=b(D,C,B,A,E[v+12],7,1804603682);A=b(A,D,C,B,E[v+13],12,-40341101);B=b(B,A,D,C,E[v+14],17,-1502002290);C=b(C,B,A,D,E[v+15],22,1236535329);D=h(D,C,B,A,E[v+1],5,-165796510);A=h(A,D,C,B,E[v+6],9,-1069501632);B=h(B,A,D,C,E[v+11],14,643717713);C=h(C,B,A,D,E[v],20,-373897302);D=h(D,C,B,A,E[v+5],5,-701558691);A=h(A,D,C,B,E[v+10],9,38016083);B=h(B,A,D,C,E[v+15],14,-660478335);C=h(C,B,A,D,E[v+4],20,-405537848);D=h(D,C,B,A,E[v+9],5,568446438);A=h(A,D,C,B,E[v+14],9,-1019803690);B=h(B,A,D,C,E[v+3],14,-187363961);C=h(C,B,A,D,E[v+8],20,1163531501);D=h(D,C,B,A,E[v+13],5,-1444681467);A=h(A,D,C,B,E[v+2],9,-51403784);B=h(B,A,D,C,E[v+7],14,1735328473);C=h(C,B,A,D,E[v+12],20,-1926607734);D=m(D,C,B,A,E[v+5],4,-378558);A=m(A,D,C,B,E[v+8],11,-2022574463);B=m(B,A,D,C,E[v+11],16,1839030562);C=m(C,B,A,D,E[v+14],23,-35309556);D=m(D,C,B,A,E[v+1],4,-1530992060);A=m(A,D,C,B,E[v+4],11,1272893353);B=m(B,A,D,C,E[v+7],16,-155497632);C=m(C,B,A,D,E[v+10],23,-1094730640);D=m(D,C,B,A,E[v+13],4,681279174);A=m(A,D,C,B,E[v],11,-358537222);B=m(B,A,D,C,E[v+3],16,-722521979);C=m(C,B,A,D,E[v+6],23,76029189);D=m(D,C,B,A,E[v+9],4,-640364487);A=m(A,D,C,B,E[v+12],11,-421815835);B=m(B,A,D,C,E[v+15],16,530742520);C=m(C,B,A,D,E[v+2],23,-995338651);D=a(D,C,B,A,E[v],6,-198630844);A=a(A,D,C,B,E[v+7],10,1126891415);B=a(B,A,D,C,E[v+14],15,-1416354905);C=a(C,B,A,D,E[v+5],21,-57434055);D=a(D,C,B,A,E[v+12],6,1700485571);A=a(A,D,C,B,E[v+3],10,-1894986606);B=a(B,A,D,C,E[v+10],15,-1051523);C=a(C,B,A,D,E[v+1],21,-2054922799);D=a(D,C,B,A,E[v+8],6,1873313359);A=a(A,D,C,B,E[v+15],10,-30611744);B=a(B,A,D,C,E[v+6],15,-1560198380);C=a(C,B,A,D,E[v+13],21,1309151649);D=a(D,C,B,A,E[v+4],6,-145523070);A=a(A,D,C,B,E[v+11],10,-1120210379);B=a(B,A,D,C,E[v+2],15,718787259);C=a(C,B,A,D,E[v+9],21,-343485551);D=n(D,y);C=n(C,w);B=n(B,u);A=n(A,t)}return[D,C,B,A]}function o(u){var v,t="";for(v=0;v<u.length*32;v+=8){t+=String.fromCharCode((u[v>>5]>>>(v%32))&255)}return t}function i(u){var v,t=[];t[(u.length>>2)-1]=undefined;for(v=0;v<t.length;v+=1){t[v]=0}for(v=0;v<u.length*8;v+=8){t[v>>5]|=(u.charCodeAt(v/8)&255)<<(v%32)}return t}function j(t){return o(d(i(t),t.length*8))}function e(v,y){var u,x=i(v),t=[],w=[],z;t[15]=w[15]=undefined;if(x.length>16){x=d(x,v.length*8)}for(u=0;u<16;u+=1){t[u]=x[u]^909522486;w[u]=x[u]^1549556828}z=d(t.concat(i(y)),512+y.length*8);return o(d(w.concat(z),512+128))}function s(v){var y="0123456789abcdef",u="",t,w;for(w=0;w<v.length;w+=1){t=v.charCodeAt(w);u+=y.charAt((t>>>4)&15)+y.charAt(t&15)}return u}function l(t){return unescape(encodeURIComponent(t))}function p(t){return j(l(t))}function k(t){return s(p(t))}function g(t,u){return e(l(t),l(u))}function q(t,u){return s(g(t,u))}f.md5=function(u,v,t){if(!v){if(!t){return k(u)}else{return p(u)}}if(!t){return q(v,u)}else{return g(v,u)}}}(typeof jQuery==="function"?jQuery:this));

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
                    $('#msg').html(r.msg + ' (2秒后此对话框自动关闭)')
                        .hide().show('nomal', function () {
                        setTimeout(function () {
                            $('#edit').modal('hide');
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
            type:'post',
            url:$(this).attr('action'),
            data:$(this).serialize(),
            dataType:'json',
            beforeSend:function(){$('#info').html('&nbsp;');},
            success: function (r) {
                if (r.ok == 'true'){
                    $('#info').html('修改成功,页面正在跳转');
                    location.reload();
                }else{
                    $('#info').html(r.msg);
                }
            },
            error:function(){$('#info').val('发生了错误')}
        });
        return e.preventDefault();
    });

    $('#reset-passwd').click(function(){$('#all-stu-type').val('reset');});
    $('#delete-stu').click(function(){$('#all-stu-type').val('delete');});
    $('#all-stu').submit(function (e) {
        var list = document.getElementsByName('check-list');
        var hascheck = false;
        for (var i = 0;i<list.length;i++){
            if (list[i].checked){hascheck=true;}
        }
        if (!hascheck){
            $('#msg').html('至少选中一项');
            return e.preventDefault();
        }
        $.ajax({
            type:'post',
            url:$(this).attr('action'),
            data:$(this).serialize(),
            dataType:'json',
            beforeSend:function(){$('#msg').html('&nbsp;');},
            success: function (r) {
                if (r.ok == 'true'){
                    $('#msg').html(r.msg);
                    if ($('#all-stu-type').val()=='delete'){
                        $('#msg').append(' 2秒后自动刷新页面');
                        setTimeout(function(){
                            location.reload();
                        },2000);
                    }
                }
                else{$('#msg').html(r.msg);}
            },
            error:function(){$('#msg').html('出错了');}
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