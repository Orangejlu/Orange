<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-04-004
  Time: 13:47 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%@ include file="header.jsp" %>
<title>学生选课系统</title>
</head>
<body>
    <%
      if(logined != null){
        if (session.getAttribute("type")!=null)
          switch ((Integer)session.getAttribute("type")){
            case 0:response.sendRedirect("admin/");break;
            case 1:response.sendRedirect("admin2/");break;
            case 2:response.sendRedirect("teacher/");break;
            case 3:response.sendRedirect("user/");break;
            default:response.sendRedirect("login.jsp?reason=login");
          }
        else{
          response.sendRedirect("login.jsp?reason=login");
        }
      }
      %>
<%@include file="footer.jsp" %>