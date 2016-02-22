<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-19-019
  Time: 16:24 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/user/top.jsp" %>
<script>function addmyclass() {
    $('#select').addClass('active');
}</script>
<%
    Connection con = JDBCUtil.getConnection();
    boolean opened = false;
    String s_grade = "";
    try {
        Statement stmt = con.createStatement();
        //region 检查是否开放选课
        ResultSet rs = stmt.executeQuery("SELECT * FROM info WHERE key = 'opened'");
        while (rs.next()) {
            if (rs.getString("value").equals("true"))
                opened = true;
        }//endregion
        //region 获得用户的年级
        rs = stmt.executeQuery("SELECT s_grade FROM student WHERE s_id = " + session.getAttribute("userId"));
        while (rs.next()) {
            s_grade = rs.getString("s_grade");
        }//endregion
        rs.close();
        stmt.close();
    } catch (SQLException e) {
    }
    if (opened) {
%>
<div class="table-responsive">
    <table class="table table-striped table-hover">
        <h4>可选课程列表</h4>
        <thead>
        <tr>
            <th>选课</th>
            <th>编号</th>
            <th>课程</th>
            <th>教师</th>
            <th>学分类型</th>
            <th>时间地点</th>
        </tr>
        </thead>
        <tbody>
        <%!
            boolean hastake(String s_id, String sec_id) {
                Connection con = JDBCUtil.getConnection();
                try {
                    PreparedStatement pstmt = con.prepareStatement(
                            "SELECT s_id FROM takes WHERE s_id = ? AND sec_id = ?");
                    pstmt.setString(1, s_id);
                    pstmt.setString(2, sec_id);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        rs.close();
                        pstmt.close();
                        return true;
                    }
                    rs.close();
                    pstmt.close();
                    return false;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return false;
            }
        %>
        <%
            //region 获得用户可选的所有课程
            //SELECT sec_id,c_title,sec_semester,sec_creadits,sec_type,t_name,sec_depts,s_grade,
            // r_name,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass FROM sec  natural join course
            // natural join teacher natural join classroom  natural join timeslot
            // WHERE sec_depts LIKE '%软件学院%' AND s_grade = '2013'
            String sql = "SELECT sec_id,c_id,c_title,sec_semester,sec_creadits,sec_type,t_id,t_name," +
                    "sec_depts,s_grade,r_name,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass " +
                    " FROM sec  natural join course  natural join teacher natural join classroom natural join" +
                    " timeslot WHERE sec_depts LIKE ? AND s_grade = ? AND sec_semester = (" +
                    "SELECT value FROM info WHERE key = 'semester')  ORDER BY sec_id";
            try {
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "%" + session.getAttribute("dept") + "%");
                pstmt.setString(2, s_grade);
                ResultSet rs = pstmt.executeQuery();
                String btn;
                while (rs.next()) {
                    btn = "<a class='btn btn-xs btn-primary select' href='" + basePath
                            + "user/select.do?selected=false&sec-id=" + rs.getString("sec_id")
                            + "&cid=" + rs.getString("c_id") + "'>选课</a>";
                    if (hastake((String) session.getAttribute("userId"), rs.getString("sec_id"))) {
                        btn = "<a class='btn btn-xs btn-success select' href='" + basePath
                                + "user/select.do?selected=true&sec-id=" + rs.getString("sec_id")
                                + "&cid=" + rs.getString("c_id") + "'>退选</a>";
                    }
                    //System.out.println("可选列表：" + rs.getString("c_title"));
                    out.println("<tr><td>" + btn + "</td><td>" + rs.getString("sec_id") + "</td><td>"
                            + rs.getString("c_title") + "</td><td>" + rs.getString("t_name") + "</td><td>"
                            + rs.getString("sec_creadits") + "学分；" + rs.getString("sec_type") + "</td><td>第"
                            + rs.getString("ts_sweek") + "-" + rs.getString("ts_eweek") + "周；星期"
                            + rs.getString("ts_day") + "；第" + rs.getString("ts_sclass") + "-"
                            + rs.getString("ts_eclass") + "节</td></tr>");
                }
            } catch (SQLException e) {

            }//endregion
        %>
        </tbody>
    </table>
    <a href="<%=basePath%>user/courselist.jsp">当前课表查看</a>
</div>
<%
    } else {
        out.print("<strong style='font-size: xx-large;'>当前未开放选课</strong>");
    }
%>
<%@ include file="../WEB-INF/content/user/bottom.jsp" %>