<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-15-015
  Time: 21:11 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort() + path + "/";%>
    <%--<base href="<c:url value="/"></c:url>">--%>
    <!--link rel="stylesheet" href="css/style.css" /-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <i style="display: block;text-align: center;background-color: #fff;">您的浏览器版本太低！建议使用
        <a href="http://www.google.cn/chrome/browser/desktop/index.html" target="_blank">Chrome</a>、
        <a href="http://www.mozilla.org" target="_blank">FireFox</a>等现代浏览器访问本站！</i>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title>出错了</title>
</head>
<body>

<div class="container">
    <div class="col-lg-4 col-md-6 col-sm-8 col-xs-10 mycenter">
        <div class="panel panel-default">
            <div class="panel-heading"><h1 class="panel-title">服务器错误</h1></div>
            <div class="panel-body">
                <p>很抱歉，服务器出错了,请联系管理员</p>

                <p><a href="<%=basePath%>">返回首页</a></p>
                <blockquote>
                    <h3>错误信息</h3>
                    <% if (exception != null) {
                        out.println("<pre>" + exception.toString() + "</pre>");
                    } %>
                </blockquote>
                <% String referer = request.getHeader("referer");
                    if (referer != null) {
                        out.println("<p><a href=\"" + referer + "\">返回来源页</a></p>");
                    }
                %>
            </div>
            <div class="panel-footer">&copy; 2015 Orange</div>
        </div>
    </div>
</div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/user.js"></script>
</body>
</html>
