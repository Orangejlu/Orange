<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 23:07 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%@ include file="../WEB-INF/content/admin2/top.jsp" %>
<%--页面上半部分，container开始--%>
<script>function addmyclass() {
    $('#m-passwd').addClass('active');
}</script>
<style>.input-group {
    margin: 1%;
}</style>
<h3>我的信息</h3>
<div class="table-responsive">
    <table class="table table-hover">
        <tr>
            <th scope="row">角色</th>
            <td>教务管理员</td>
        </tr>
        <tr>
            <th scope="row">用户名</th>
            <td><%=session.getAttribute("logined")%>
            </td>
        </tr>
        <tr>
            <th scope="row">所属院系</th>
            <td><%=session.getAttribute("dept")%>
            </td>
        </tr>
    </table>
</div>
<form action="admin2/pass.do" role="form" method="post" id="change-pass" class="form-inline">
    <h4>修改登录密码</h4>
    <div id="tip" class="text-danger">&nbsp;</div>
    <div class="input-group">
        <label for="oldpassPlain" class="input-group-addon">原密码</label>
        <input type="password" id="oldpassPlain" class="form-control" required>
        <input type="hidden" id="oldpass" name="oldpass">
    </div>
    <div class="input-group">
        <label for="newpassPlain" class="input-group-addon">新密码</label>
        <input type="password" id="newpassPlain" class="form-control" required>
        <input type="hidden" id="newpass" name="newpass">
    </div>
    <input type="hidden" name="name" id="name" value="<%=(String)session.getAttribute("logined")%>">
    <button type="submit" class="btn btn-primary">更改</button>
    <p class="help-block">请注意，管理员有权重置您的密码(但看不到您的密码)。更改成功后需要重新登陆。</p>
</form>
<%--结束container，页面下半部分--%>
<%@ include file="../WEB-INF/content/admin2/bottom.jsp" %>
