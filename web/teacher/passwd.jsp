<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-22-022
  Time: 14:35 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/teacher/top.jsp" %>
<script>function addmyclass() {
    $('#password').addClass('active');
}</script>
<form action="<%=basePath%>teacher/passwd.do" class="form-inline" id="passwd-form">
    <div class="input-group">
        <label for="old-pass-plain" class="input-group-addon">原密码</label>
        <input type="password" id="old-pass-plain" class="form-control" required>
        <input type="hidden" name="old-pass" id="old-pass">
    </div>
    <div class="input-group">
        <label for="new-pass-plain" class="input-group-addon">新密码</label>
        <input type="password" id="new-pass-plain" class="form-control" required>
        <input type="hidden" id="new-pass" name="new-pass">
    </div>
    <div class="input-group">
        <input type="hidden" name="t-id" id="t-id" value="<%=session.getAttribute("userId")%>">
        <button type="submit" class="btn btn-primary">修改密码</button>
    </div>
    <p class="help-block">注意：管理员可以重置您的密码()但看不到您的密码；修改密码后需要重新登录</p>
</form>
<p class="text-danger" id="tip">&nbsp;</p>
<div class="table-responsive">
    <table class="table table-striped table-hover">
        <%
            Connection con = JDBCUtil.getConnection();
            String sql = "SELECT t_id,t_name,t_level,t_email,d_name FROM teacher WHERE t_id = ?";
            try {
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, (String) session.getAttribute("userId"));
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    out.println("<tr><th>编号</th><td>" + rs.getString("t_id") + "</td></tr>");
                    out.println("<tr><th>姓名</th><td>" + rs.getString("t_name") + "</td></tr>");
                    out.println("<tr><th>职称</th><td>" + rs.getString("t_level") + "</td></tr>");
                    out.println("<tr><th>邮箱</th><td>" + rs.getString("t_email") + "</td></tr>");
                    out.println("<tr><th>学院</th><td>" + rs.getString("d_name") + "</td></tr>");
                }
            } catch (SQLException e) {
            }
        %>
    </table>
</div>
<%@ include file="../WEB-INF/content/teacher/bottom.jsp" %>
