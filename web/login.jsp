<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-09-009
  Time: 22:03 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%@ include file="header.jsp" %>
<title>登录</title>
<style>
    html {
        height: 100%;
    }

    body {
        height: 100%;
        background-image: url("img/stone.jpg");
        /*background-image: url("http://appserver.m.bing.net/BackgroundImageService/TodayImageService.svc/GetTodayImage?dateOffset=0&urlEncodeHeaders=true&osName=Windows&osVersion=10&orientation=1024x768&deviceName=orange&mkt=zh-CN");*/
        background-repeat: no-repeat;
        background-size: cover;
    }

    #login {
        background: rgba(255, 255, 255, .6);
        padding-bottom: 2%;
    }

    #login .input-group {
        margin: 2% auto;
    }
</style>
</head>
<body>

<div class="container">

    <div class="col-lg-4 col-md-6 col-sm-8 col-xs-10 mycenter" id="login">
        <form class="form" role="form" action="login.do" method="post" id="login-form">
            <h2>
                <small><a href="./">&nbsp;</a></small>
                登录
            </h2>
            <div class="input-group">
                <label for="username" class="input-group-addon">账号</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="教学号或工作证号" required
                       autofocus>
            </div>
            <div class="input-group">
                <label for="passwordPlain" class="input-group-addon">密码</label>
                <input type="password" id="passwordPlain" class="form-control" placeholder="初始密码是用户名" required>
                <input type="hidden" id="password" name="password" value="">
            </div>
            <div class="text-danger" id="tip">&nbsp;</div>
            <input type="submit" value="登录" class="btn btn-lg btn-primary btn-block" id="login-form-submit" />
        </form>
        <!--[if lt IE 9]>
        <script>
            var login_u = document.getElementById('username');
            var login_p = document.getElementById("passwordPlain");
            login_u.disabled = true;
            login_p.disabled = true;
        </script>
        <![endif]-->
    </div>

</div> <!-- .container -->

<%@include file="footer.jsp" %>
