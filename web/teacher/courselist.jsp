<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-22-022
  Time: 13:49 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/teacher/top.jsp" %>
<script>function addmyclass() {
    $('#courselist').addClass('active');
    $(window).resize(function () {
        $('.th').width(($('tr').width() - $('.th1').width()) / 7);
    });
    $(window).resize();
}</script>

<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th class="th1">&nbsp;</th>
            <th class="th">周一</th>
            <th class="th">周二</th>
            <th class="th">周三</th>
            <th class="th">周四</th>
            <th class="th">周五</th>
            <th class="th">周六</th>
            <th class="th">周日</th>
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
            String sql = "SELECT c_title,r_name,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass" +
                    " FROM sec NATURAL JOIN teacher NATURAL JOIN classroom " +
                    "NATURAL JOIN timeslot NATURAL JOIN course WHERE t_id = ? AND sec_semester = (" +
                    "SELECT value FROM info WHERE key = 'semester')";
            try {
                PreparedStatement pstm = con.prepareStatement(sql);
                pstm.setString(1, (String) session.getAttribute("userId"));
                ResultSet rs = pstm.executeQuery();
                while (rs.next()) {
                    //System.out.println(rs.getString("c_title"));
                    for (int i = Integer.parseInt(rs.getString("ts_sclass")) - 1;
                         i < Integer.parseInt(rs.getString("ts_eclass")); i++) {
                        lists[i][Integer.parseInt(rs.getString("ts_day")) - 1] +=
                                rs.getString("c_title") + "；" + rs.getString("ts_sclass") + "-"
                                        + rs.getString("ts_eclass") + "节(" + rs.getString("ts_sweek") + "-"
                                        + rs.getString("ts_eweek") + "周)；" + rs.getString("r_name");
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

<%@ include file="../WEB-INF/content/teacher/bottom.jsp" %>
