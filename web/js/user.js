/*https://github.com/placemarker/jQuery-MD5/blob/master/jquery.md5.js*/(function(f){function n(t,w){var v=(t&65535)+(w&65535),u=(t>>16)+(w>>16)+(v>>16);return(u<<16)|(v&65535)}function r(t,u){return(t<<u)|(t>>>(32-u))}function c(A,w,v,u,z,y){return n(r(n(n(w,A),n(u,y)),z),v)}function b(w,v,B,A,u,z,y){return c((v&B)|((~v)&A),w,v,u,z,y)}function h(w,v,B,A,u,z,y){return c((v&A)|(B&(~A)),w,v,u,z,y)}function m(w,v,B,A,u,z,y){return c(v^B^A,w,v,u,z,y)}function a(w,v,B,A,u,z,y){return c(B^(v|(~A)),w,v,u,z,y)}function d(E,z){E[z>>5]|=128<<((z)%32);E[(((z+64)>>>9)<<4)+14]=z;var v,y,w,u,t,D=1732584193,C=-271733879,B=-1732584194,A=271733878;for(v=0;v<E.length;v+=16){y=D;w=C;u=B;t=A;D=b(D,C,B,A,E[v],7,-680876936);A=b(A,D,C,B,E[v+1],12,-389564586);B=b(B,A,D,C,E[v+2],17,606105819);C=b(C,B,A,D,E[v+3],22,-1044525330);D=b(D,C,B,A,E[v+4],7,-176418897);A=b(A,D,C,B,E[v+5],12,1200080426);B=b(B,A,D,C,E[v+6],17,-1473231341);C=b(C,B,A,D,E[v+7],22,-45705983);D=b(D,C,B,A,E[v+8],7,1770035416);A=b(A,D,C,B,E[v+9],12,-1958414417);B=b(B,A,D,C,E[v+10],17,-42063);C=b(C,B,A,D,E[v+11],22,-1990404162);D=b(D,C,B,A,E[v+12],7,1804603682);A=b(A,D,C,B,E[v+13],12,-40341101);B=b(B,A,D,C,E[v+14],17,-1502002290);C=b(C,B,A,D,E[v+15],22,1236535329);D=h(D,C,B,A,E[v+1],5,-165796510);A=h(A,D,C,B,E[v+6],9,-1069501632);B=h(B,A,D,C,E[v+11],14,643717713);C=h(C,B,A,D,E[v],20,-373897302);D=h(D,C,B,A,E[v+5],5,-701558691);A=h(A,D,C,B,E[v+10],9,38016083);B=h(B,A,D,C,E[v+15],14,-660478335);C=h(C,B,A,D,E[v+4],20,-405537848);D=h(D,C,B,A,E[v+9],5,568446438);A=h(A,D,C,B,E[v+14],9,-1019803690);B=h(B,A,D,C,E[v+3],14,-187363961);C=h(C,B,A,D,E[v+8],20,1163531501);D=h(D,C,B,A,E[v+13],5,-1444681467);A=h(A,D,C,B,E[v+2],9,-51403784);B=h(B,A,D,C,E[v+7],14,1735328473);C=h(C,B,A,D,E[v+12],20,-1926607734);D=m(D,C,B,A,E[v+5],4,-378558);A=m(A,D,C,B,E[v+8],11,-2022574463);B=m(B,A,D,C,E[v+11],16,1839030562);C=m(C,B,A,D,E[v+14],23,-35309556);D=m(D,C,B,A,E[v+1],4,-1530992060);A=m(A,D,C,B,E[v+4],11,1272893353);B=m(B,A,D,C,E[v+7],16,-155497632);C=m(C,B,A,D,E[v+10],23,-1094730640);D=m(D,C,B,A,E[v+13],4,681279174);A=m(A,D,C,B,E[v],11,-358537222);B=m(B,A,D,C,E[v+3],16,-722521979);C=m(C,B,A,D,E[v+6],23,76029189);D=m(D,C,B,A,E[v+9],4,-640364487);A=m(A,D,C,B,E[v+12],11,-421815835);B=m(B,A,D,C,E[v+15],16,530742520);C=m(C,B,A,D,E[v+2],23,-995338651);D=a(D,C,B,A,E[v],6,-198630844);A=a(A,D,C,B,E[v+7],10,1126891415);B=a(B,A,D,C,E[v+14],15,-1416354905);C=a(C,B,A,D,E[v+5],21,-57434055);D=a(D,C,B,A,E[v+12],6,1700485571);A=a(A,D,C,B,E[v+3],10,-1894986606);B=a(B,A,D,C,E[v+10],15,-1051523);C=a(C,B,A,D,E[v+1],21,-2054922799);D=a(D,C,B,A,E[v+8],6,1873313359);A=a(A,D,C,B,E[v+15],10,-30611744);B=a(B,A,D,C,E[v+6],15,-1560198380);C=a(C,B,A,D,E[v+13],21,1309151649);D=a(D,C,B,A,E[v+4],6,-145523070);A=a(A,D,C,B,E[v+11],10,-1120210379);B=a(B,A,D,C,E[v+2],15,718787259);C=a(C,B,A,D,E[v+9],21,-343485551);D=n(D,y);C=n(C,w);B=n(B,u);A=n(A,t)}return[D,C,B,A]}function o(u){var v,t="";for(v=0;v<u.length*32;v+=8){t+=String.fromCharCode((u[v>>5]>>>(v%32))&255)}return t}function i(u){var v,t=[];t[(u.length>>2)-1]=undefined;for(v=0;v<t.length;v+=1){t[v]=0}for(v=0;v<u.length*8;v+=8){t[v>>5]|=(u.charCodeAt(v/8)&255)<<(v%32)}return t}function j(t){return o(d(i(t),t.length*8))}function e(v,y){var u,x=i(v),t=[],w=[],z;t[15]=w[15]=undefined;if(x.length>16){x=d(x,v.length*8)}for(u=0;u<16;u+=1){t[u]=x[u]^909522486;w[u]=x[u]^1549556828}z=d(t.concat(i(y)),512+y.length*8);return o(d(w.concat(z),512+128))}function s(v){var y="0123456789abcdef",u="",t,w;for(w=0;w<v.length;w+=1){t=v.charCodeAt(w);u+=y.charAt((t>>>4)&15)+y.charAt(t&15)}return u}function l(t){return unescape(encodeURIComponent(t))}function p(t){return j(l(t))}function k(t){return s(p(t))}function g(t,u){return e(l(t),l(u))}function q(t,u){return s(g(t,u))}f.md5=function(u,v,t){if(!v){if(!t){return k(u)}else{return p(u)}}if(!t){return q(v,u)}else{return g(v,u)}}}(typeof jQuery==="function"?jQuery:this));
jQuery(document).ready(function ($) {
    //居中
    $(window).resize(function () {
        $('.mycenter').css({
            position: 'fixed',
            left: ($(window).width() - $('.mycenter').outerWidth()) / 2,
            top: ($(window).height() - $('.mycenter').outerHeight()) * 0.3 + $(document).scrollTop()
        });
    });
    $(window).resize();


    //登录
    $('#login-form').submit(function (e) {
        var u = $('#username');
        var p = $("#passwordPlain");
        var tip = $('#tip');
        var b = $('#login-form-submit');
        $.ajax({
            type: 'POST',
            url: 'login.do',
            data: {
                'username': u.val(),
                'password': $.md5("Orange" + u.val() + p.val())
            },
            dataType: 'json',
            beforeSend: function () {
                tip.html('&nbsp;');
                if (u.val() == '' || p.val() == '') {
                    tip.html('用户名或密码不能为空');
                    return false;
                }
                b.attr('disabled',true);
                b.val('正在登录,请稍后');
            },
            success: function (r) {
                //console.log(r);
                if (r.ok == 'true') {
                    window.location.href = r.msg;
                } else {
                    tip.html(r.msg);
                }
            },
            error: function () {
                $('#tip').html('网络错误');
            },
            complete:function(){
                b.removeAttr('disabled');
                b.val('登录');
            }
        });
        //https://www.ibm.com/developerworks/cn/web/wa-aj-authenticate/
        //为了避免提交表单时刷新页面，您必须使用 preventDefault 函数。
        //要访问 preventDefault 函数，您必须传递处理函数（即使作为一个参数）或者使用它访问该函数。
        return e.preventDefault();
    });


    $("#add-admin").submit(function () {
        var v = $.md5("Orange" + $("#uname").val() + $("#passwdPlain").val());
        $("#passwd").val(v);
        return true;
    });


});
