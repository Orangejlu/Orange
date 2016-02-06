<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-09-009
  Time: 22:05 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//    System.out.println("URI:"+request.getRequestURL());
//    System.out.println(basePath);
    String reason = request.getParameter("reason");
    if (reason != null && reason.equals("logout")) {
        session.setAttribute("logined", null);
        out.println("logout");
        response.sendRedirect(basePath+"login.jsp?reason=haslogout");
        return;
    }
    String logined = (String) session.getAttribute("logined");
    if (logined == null && request.getParameter("reason") == null) {
        response.sendRedirect(basePath+"login.jsp?reason=login");
        return;
    }
    Integer type = (Integer) session.getAttribute("type");
    if (type == null) type = -1;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <base href="<%=basePath%>">
    <!--link rel="stylesheet" href="css/style.css" /-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-2.1.4.min.js"></script>
    <!--[if lt IE 9]>
    <i style="display: block;text-align: center;background-color: #fff;">您的浏览器版本太低！请使用使用
        <span>IE 9+</span>、
        <a href="http://www.google.cn/chrome/browser/desktop/index.html" target="_blank">Chrome</a>、
        <a href="http://www.mozilla.org" target="_blank">FireFox</a>等现代浏览器访问本站！否则将不能登录！</i>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

