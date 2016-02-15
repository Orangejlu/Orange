<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-15-015
  Time: 09:07 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../../../header.jsp" %>
<%
    if (type != 2) {
        response.sendRedirect(basePath);
        return;
    }
%>
<title>教师首页 - 学生选课系统</title>
<style>
    html, body {
        height: 100%;
    }

    #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        margin: 0 auto -70px;
    }

    #end {
        clear: both;
        height: 70px;
    }

    #copyright {
        height: 70px;
        overflow: hidden;
        padding: 10px 0;
        color: #999;
        text-align: center;
        background-color: #f9f9f9;
        border-top: 1px solid #e5e5e5;
    }

    #copyright p:last-child {
        margin-bottom: 0;
    }

    .input-group {
        margin: 1%;
    }

    ul.nav li:hover {
        background-color: #ccc;
    }
    .container{width: 100%;}
    span.block{display: block;}
</style>
</head>
<body>
<div id="wrap">
    <div class="jumbotron" style="background-image:url('<%=basePath%>img/huar.jpg');color:black;margin-bottom: 0;">
        <div class="container" style="background-color:rgba(255,255,255,.7);"><h2>欢迎使用选课系统</h2></div>
    </div>

    <nav class="navbar navbar-default" style="border-radius:0;margin-bottom: 0;">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">展开或关闭菜单</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <span class="navbar-brand">欢迎您, <mark><%=session.getAttribute("logined")%>
                </mark></span>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li id="home"><a href="<%=basePath%>teacher/">首页</a></li>
                    <li><a href="<%=basePath%>teacher/?reason=logout">注销登录</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <div class="container">
