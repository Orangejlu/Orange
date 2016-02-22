<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-22-022
  Time: 14:30 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/teacher/top.jsp" %>
<script>function addmyclass() {
    $('#score').addClass('active');
}</script>
<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>学号</th>
            <th>姓名</th>
            <th>课程</th>
            <th>成绩</th>
        </tr>
        </thead>
        <%
            Connection con = JDBCUtil.getConnection();
            String sql = "SELECT s_id,s_name,c_id,c_title,tk_score,tk_point,tk_credit " +
                    " FROM student NATURAL JOIN takes NATURAL JOIN sec NATURAL JOIN course " +
                    " WHERE t_id = ? AND sec_semester = (SELECT value FROM info WHERE key = 'semester') " +
                    " ORDER BY s_id, c_id";
            Set<String> course = new LinkedHashSet<>();
            try {
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, (String) session.getAttribute("userId"));
                ResultSet rs = pstmt.executeQuery();
                String score;
                while (rs.next()) {
                    if (course.contains(rs.getString("s_id") + rs.getString("c_id"))) {
                        continue;
                    }
                    course.add(rs.getString("s_id") + rs.getString("c_id"));
                    score = rs.getString("tk_score");
                    if (score == null) {
                        score = "";
                    }
                    out.println("<tr><td>" + rs.getString("s_id") + "</td><td>" + rs.getString("s_name") +
                            "</td><td>" + rs.getString("c_title") + "</td><td style='width: 25%;'><form " +
                            "action='teacher/score.do' class='score-form'><input type='hidden' name='id' value='" +
                            rs.getString("s_id") + "-" + rs.getString("c_id") + "'><div class='input-group'><input" +
                            " type='text' name='score'" + " value='" + score + "' title='成绩栏可填0-100数字或‘ABCDE’或‘优良中差不及格’'" +
                            " class='form-control'><span class='input-group-btn'><button type='submit' " +
                            "class='btn btn-primary'>提交</button></span></div></form></td></tr>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        %>
    </table>
</div>
<div id="alert-tip" style="position: fixed;left: 15px;z-index: 999;"></div>
<%@ include file="../WEB-INF/content/teacher/bottom.jsp" %>