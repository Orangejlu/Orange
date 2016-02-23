<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-17-017
  Time: 15:20 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <base href="<c:url value="/"/>">
    <!--link rel="stylesheet" href="css/style.css" /-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <%--<script src="js/jquery-2.1.4.min.js"></script>--%>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <i style="display: block;text-align: center;background-color: #fff;">您的浏览器版本太低！建议使用
        <a href="http://www.google.cn/chrome/browser/desktop/index.html" target="_blank">Chrome</a>、
        <a href="http://www.mozilla.org" target="_blank">FireFox</a>等现代浏览器访问本站！</i>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<title>404 - 学生选课系统</title>
</head>
<body>
<div class="container">
    <div class="col-lg-4 col-md-6 col-sm-8 col-xs-10 mycenter">
        <div class="panel panel-default">
            <div class="panel-heading"><h1 class="panel-title">404 Not Found</h1></div>
            <div class="panel-body">
                <blockquote>
                    <p>很抱歉，您请求的资源当前不可用,请检查网址</p>
                    <p><a href=".">返回首页</a></p>
                </blockquote>
            </div>
            <div class="panel-footer">&copy; 2015 Orange</div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
