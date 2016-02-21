<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-19-019
  Time: 13:58 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/user/top.jsp" %>
<script>function addmyclass() {
    $('#passwd').addClass('active');
}</script>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading3">
            <h4 class="panel-title">
                <span class="block collapsed" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse3"
                      aria-expanded="true" aria-controls="collapse">
                    我的信息
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse3" class="panel-collapse collapse"
             role="tabpanel" aria-labelledby="heading3">
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <%
                            Connection con = JDBCUtil.getConnection();
                            try {
                                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM student WHERE s_id = ?");
                                pstmt.setString(1, (String) session.getAttribute("userId"));
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    out.println("<tr><th>姓名</th><td>" + rs.getString("s_name") + "</td></tr>");
                                    out.println("<tr><th>学号</th><td>" + rs.getString("s_id") + "</td></tr>");
                                    out.println("<tr><th>教学号</th><td>" + rs.getString("s_id2") + "</td></tr>");
                                    out.println("<tr><th>学院</th><td>" + rs.getString("d_name") + "</td></tr>");
                                    out.println("<tr><th>性别</th><td>" + rs.getString("s_gender") + "</td></tr>");
                                    out.println("<tr><th>年级</th><td>" + rs.getString("s_grade") + "</td></tr>");
                                }
                            } catch (SQLException e) {
                                out.println("<tr><td></td><td>查询数据库出错了</td></tr>");
                            }
                        %>
                    </table>
                </div>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading4">
            <h4 class="panel-title">
                <span class="block collapsed" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse4"
                      aria-expanded="true" aria-controls="collapse">
                    修改密码
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse4" class="panel-collapse collapse in"
             role="tabpanel" aria-labelledby="heading3">
            <div class="panel-body">
                <form action="<%=basePath%>user/passwd.do" class="form-inline" id="user-passwd-form">
                    <div class="input-group">
                        <input type="hidden" id="user-id" name="user-id" value="<%=session.getAttribute("userId")%>">
                        <label for="passwd-plain" class="input-group-addon">原密码</label>
                        <input type="password" id="passwd-plain" class="form-control" required>
                        <input type="hidden" id="old-passwd" name="passwd">
                    </div>
                    <div class="input-group">
                        <label for="new-passwd-plain" class="input-group-addon">新密码</label>
                        <input type="password" id="new-passwd-plain" class="form-control" required>
                        <input type="hidden" id="new-passwd" name="new-passwd">
                    </div>
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary">修改密码</button>
                    </div>
                    <p class="help-block">提示：修改密码后需要重新登录。</p>
                </form>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->
</div>
<%@ include file="../WEB-INF/content/user/bottom.jsp" %>