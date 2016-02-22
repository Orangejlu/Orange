<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-21-021
  Time: 15:51 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/user/top.jsp" %>
<script>function addmyclass() {
    $('#score').addClass('active');
}</script>

<form action="" class="form-inline">
    <div class="input-group">
        <label for="semester" class="input-group-addon">查询学期</label>
        <select name="semester" id="semester" class="form-control">
            <%
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                for (int i = year - 4; i < year + 4; i++) {
                    if (now.get(Calendar.MONTH) < 6) {
                        if (i == year - 1) {
                            out.println("<option value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                            out.println("<option selected value='" + i + "-" + (i + 1) + "-2'>第" + i + "-" + (i + 1) + "学年 第2学期</option>");
                        } else {
                            out.println("<option value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                            out.println("<option value='" + i + "-" + (i + 1) + "-2'>第" + i + "-" + (i + 1) + "学年 第2学期</option>");
                        }
                    } else {
                        if (i == year) {
                            out.println("<option selected value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                            out.println("<option value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                        } else {
                            out.println("<option value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                            out.println("<option value='" + i + "-" + (i + 1) + "-1'>第" + i + "-" + (i + 1) + "学年 第1学期</option>");
                        }
                    }
                }
            %>
        </select>
    </div>
    <div class="input-group">
        <button type="submit" class="btn btn-primary">查询</button>
    </div>
</form>
<div id="result" class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>课程</th>
            <th>成绩</th>
            <th>绩点</th>
            <th>学分</th>
        </tr>
        </thead>
        <tbody>
        <%!
            String replaceNull(String string) {
                if (string == null)
                    string = "";
                return string;
            }
        %>
        <%
            String semester = request.getParameter("semester");
            Map courseList = new HashMap<String, String>();
            if (semester != null) {
                Connection con = JDBCUtil.getConnection();
                String sql = "SELECT s_id,c_id,sec_id,c_title,tk_score,tk_point,tk_credit,sec_semester" +
                        " FROM takes NATURAL JOIN course NATURAL JOIN sec WHERE sec_semester = ? AND s_id = ?ORDER BY sec_id";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, semester);
                    pstmt.setString(2, (String) session.getAttribute("userId"));
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        courseList.put(rs.getString("c_title"), "<tr><td>" + rs.getString("c_title")
                                + "</td><td>" + replaceNull(rs.getString("tk_score")) + "</td><td>"
                                + replaceNull(rs.getString("tk_point")) + "</td><td>"
                                + replaceNull(rs.getString("tk_credit")) + "</td></tr>");
                        /*out.println("<tr><td>" + rs.getString("sec_id") + "</td><td>" + rs.getString("c_title")
                                + "</td><td>" + replaceNull(rs.getString("tk_score")) + "</td><td>"
                                + replaceNull(rs.getString("tk_point")) + "</td><td>"
                                + replaceNull(rs.getString("tk_credit")) + "</td></tr>");*/
                    }
                } catch (SQLException e) {

                }
            }
            Iterator iter = courseList.entrySet().iterator();
            while (iter.hasNext()) {
                Map.Entry entry = (Map.Entry) iter.next();
                out.println(entry.getValue());
            }
        %></tbody>
    </table>
</div>
<%@ include file="../WEB-INF/content/user/bottom.jsp" %>
