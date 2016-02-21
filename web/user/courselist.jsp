<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-21-021
  Time: 15:49 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/user/top.jsp" %>
<script>function addmyclass() {
    $('#courselist').addClass('active');
}</script>

<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th>周一</th>
            <th>周二</th>
            <th>周三</th>
            <th>周四</th>
            <th>周五</th>
            <th>周六</th>
            <th>周日</th>
        </tr>
        </thead>
        <tbody>
        <%
            String lists[][] = new String[12][8];
            for (int i = 0; i < 12; i++) {
                for (int j = 0; j < 8; j++) {
                    lists[i][j] = "";
                }
            }
            Connection con = JDBCUtil.getConnection();
            String sql = "SELECT c_title,t_name,r_name,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass" +
                    " FROM takes NATURAL JOIN sec NATURAL JOIN teacher NATURAL JOIN classroom " +
                    "NATURAL JOIN timeslot NATURAL JOIN course WHERE s_id = ? AND sec_semester = (" +
                    "SELECT value FROM info WHERE key = 'semester')";
            try {
                PreparedStatement pstm = con.prepareCall(sql);
                pstm.setString(1, (String) session.getAttribute("userId"));
                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    //System.out.println(rs.getString("c_title"));
                    for (int i = Integer.parseInt(rs.getString("ts_sclass")) - 1;
                         i < Integer.parseInt(rs.getString("ts_eclass")); i++) {
                        lists[i][Integer.parseInt(rs.getString("ts_day")) - 1] +=
                                "[" + rs.getString("c_title") + "<br>" + rs.getString("t_name")
                                        + "<br>" + rs.getString("r_name") + "]";
                    }
                }
            } catch (SQLException e) {
            }

            for (int i = 0; i < 12; i++) {
                out.print("<tr><th>" + (i + 1) + "</th>");
                for (int j = 0; j < 8; j++) {
                    out.print("<td>" + lists[i][j] + "</td>");
                }
                out.println("</tr>");
            }
        %>
        </tbody>
    </table>
</div>
<%@ include file="../WEB-INF/content/user/bottom.jsp" %>
