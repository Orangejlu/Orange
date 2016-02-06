<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-17-017
  Time: 12:50 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%@ include file="../WEB-INF/content/admin2/top.jsp" %>
<%--页面上半部分，container开始--%>
<script>function addmyclass() {
    $('#home').addClass('active');
}</script>
<%@ include file="../WEB-INF/content/admin2/notice.jsp" %>
<%--结束container，页面下半部分--%>
<%@ include file="../WEB-INF/content/admin2/bottom.jsp" %>