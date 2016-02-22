<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sun.org.apache.regexp.internal.RE" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-22-022
  Time: 13:59 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/teacher/top.jsp" %>
<script>function addmyclass() {
    $('#stulist').addClass('active');
}</script>
<form action="" class="form-inline">
    <div class="input-group">
        <label for="sec" class="input-group-addon">选择课程</label>
        <select name="sec" id="sec" class="form-control">
            <%
                Connection con = JDBCUtil.getConnection();
                String sql = "SELECT sec_id,c_id,c_title,ts_sweek,ts_eweek,ts_sclass,ts_eclass" +
                        " FROM sec NATURAL JOIN course NATURAL JOIN timeslot WHERE t_id = ?" +
                        " AND sec_semester = (SELECT value FROM info WHERE key = 'semester') ORDER BY sec_id";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, (String) session.getAttribute("userId"));
                    ResultSet rs = pstmt.executeQuery();
                    String secId = request.getParameter("sec");
                    String selected;
                    while (rs.next()) {
                        selected = "";
                        if (secId != null && secId.equals(rs.getString("sec_id")))
                            selected = "selected";
                        out.println("<option " + selected + " value='" + rs.getString("sec_id") + "'>"
                                + rs.getString("c_title") + "(" + rs.getString("ts_sclass") + "-"
                                + rs.getString("ts_eclass") + "节 " + rs.getString("ts_sweek") + "-"
                                + rs.getString("ts_eweek") + "周)</option>");
                    }
                    rs.close();
                    pstmt.close();
                } catch (SQLException e) {

                }
            %>
        </select>
    </div>
    <div class="input-group">
        <button type="submit" class="btn btn-primary">查询</button>
    </div>
</form>
<%
    String secId = request.getParameter("sec");
    if (secId != null) {

%>
<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>学号</th>
            <th>教学号</th>
            <th>姓名</th>
            <th>性别</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                PreparedStatement pstmt = con.prepareStatement(
                        "SELECT s_id,s_id2,s_name,s_gender" +
                                " FROM student NATURAL JOIN sec NATURAL JOIN takes" +
                                " WHERE sec_id = ? ORDER BY s_id");
                pstmt.setString(1, secId);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("s_id") + "</td><td>"
                            + rs.getString("s_id2") + "</td><td>" + rs.getString("s_name")
                            + "</td><td>" + rs.getString("s_gender") + "</td></tr>");
                }
            } catch (SQLException e) {
            }
        %>
        </tbody>
    </table>
</div>
<%
    }
%>
<%@ include file="../WEB-INF/content/teacher/bottom.jsp" %>
