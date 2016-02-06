<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-15-015
  Time: 20:02 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%
    if(type != 2){
        response.sendRedirect(basePath);return;
    }
%>
<title>首页 - 学生选课系统</title>
</head>
<body>

<%@ include file="../footer.jsp" %>
