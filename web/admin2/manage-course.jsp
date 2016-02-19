<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 23:06 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%@ include file="../WEB-INF/content/admin2/top.jsp" %>
<%--页面上半部分，container开始--%>
<script>function addmyclass() {
    $('#m-course').addClass('active');
}</script>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading4">
            <h4 class="panel-title">
                <a class="collapsed block" aria-expanded="false" role="button"
                   data-toggle="collapse" data-parent="#accordion"
                   data-target="#collapse4"
                   aria-expanded="true" aria-controls="collapse4">
                    开课
                </a>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse4" class="panel-collapse collapse in"
             role="tabpane" aria-labelledby="heading4">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/addcourse.do" class="form-inline add-course" data-msg="#tip0">
                    <div class="input-group">
                        <label for="sec-id" class="input-group-addon">编号</label>
                        <input type="text" id="sec-id" name="sec-id" class="form-control" required placeholder="540001">
                    </div>
                    <div class="input-group">
                        <label for="sec-course" class="input-group-addon">课程</label>
                        <select name="sec-course" id="sec-course" class="form-control">
                            <option value="false">请选择课程</option>
                            <%
                                Connection con = JDBCUtil.getConnection();
                                try {
                                    PreparedStatement pstmt = con.prepareStatement("SELECT c_id,c_title FROM course WHERE d_name = ?");
                                    pstmt.setString(1, (String) session.getAttribute("dept"));
                                    ResultSet rs = pstmt.executeQuery();
                                    int i = 0;
                                    while (rs.next()) {
                                        i++;
                                        out.println("<option value='" + rs.getString("c_id") + "'>"
                                                + rs.getString("c_title") + "</option>");
                                    }
                                    if (i == 0) {
                                        out.println("<option value='false'>请先在下方添加课程</option>");
                                    }
                                } catch (SQLException e) {

                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="sec-semester" class="input-group-addon">学期</label>
                        <select name="sec-semester" id="sec-semester" class="form-control">
                            <%
                                Calendar now = Calendar.getInstance();
                                int year = now.get(Calendar.YEAR);
                                for (int i = year - 4; i < year + 4; i++) {
                                    if (i == year) {
                                        out.println("<option selected value = '" + i + "-" + (i + 1) + "-1" + "'>"
                                                + i + "-" + (i + 1) + "学年第1学期</option>");
                                        out.println("<option value = '" + i + "-" + (i + 1) + "-2" + "'>"
                                                + i + "-" + (i + 1) + "学年第2学期</option>");
                                    } else {
                                        out.println("<option value = '" + i + "-" + (i + 1) + "-1" + "'>"
                                                + i + "-" + (i + 1) + "学年第1学期</option>");
                                        out.println("<option value = '" + i + "-" + (i + 1) + "-2" + "'>"
                                                + i + "-" + (i + 1) + "学年第2学期</option>");
                                    }
                                }
                            %>
                            <option value=""></option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="sec-creadits" class="input-group-addon">学分</label>
                        <input type="text" id="sec-creadits" name="sec-creadits" class="form-control" required
                               placeholder="2">
                    </div>

                    <div class="input-group">
                        <label for="sec-type" class="input-group-addon">类型</label>
                        <select name="sec-type" id="sec-type" class="form-control">
                            <option value="必修">必修</option>
                            <option value="选修">选修</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="sec-teacher" class="input-group-addon">教师</label>
                        <select name="sec-teacher" id="sec-teacher" class="form-control">
                            <option value="false">请选择授课教师</option>
                            <%
                                try {
                                    PreparedStatement pstmt = con.prepareStatement("SELECT t_id,t_name FROM teacher WHERE d_name = ?");
                                    pstmt.setString(1, (String) session.getAttribute("dept"));
                                    ResultSet rs = pstmt.executeQuery();
                                    int i = 0;
                                    while (rs.next()) {
                                        i++;
                                        out.println("<option value='" + rs.getString("t_id") + "'>"
                                                + rs.getString("t_name") + "</option>");
                                    }
                                    if (i == 0) {
                                        out.println("<option value='false'>请先在[教师管理]页面添加教师</option>");
                                    }
                                } catch (SQLException e) {

                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group" title="可以选择该课程的院系">
                        <label for="sec-dept" class="input-group-addon">院系</label>
                        <select name="sec-dept" id="sec-dept" class="form-control" multiple>
                            <%
                                try {
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT d_id,d_name FROM department");
                                    while (rs.next()) {
                                        if (rs.getString("d_name").equals(session.getAttribute("dept")))
                                            out.print("<option selected value='" + rs.getString("d_name") + "'>"
                                                    + rs.getString("d_name") + "</option>");
                                        else out.print("<option value='" + rs.getString("d_name") + "'>"
                                                + rs.getString("d_name") + "</option>");
                                    }
                                } catch (SQLException e) {

                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group" title="可以选择该课程的年级">
                        <label for="sec-grade" class="input-group-addon">年级</label>
                        <select name="sec-grade" id="sec-grade" class="form-control">
                            <%
                                for (int i = year - 4; i < year + 4; i++) {
                                    if (i == year)
                                        out.print("<option selected value='" + i + "'>" + i + "</option>");
                                    else out.print("<option value='" + i + "'>" + i + "</option>");

                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="sec-room" class="input-group-addon">教室</label>
                        <select name="sec-room" id="sec-room" class="form-control">
                            <option value="false">请选择上课教室</option>
                            <%
                                try {
                                    PreparedStatement pstmt = con.prepareStatement(
                                            "SELECT r_id,r_name FROM classroom WHERE d_name = ?");
                                    pstmt.setString(1, (String) session.getAttribute("dept"));
                                    ResultSet rs = pstmt.executeQuery();
                                    int i = 0;
                                    while (rs.next()) {
                                        i++;
                                        out.println("<option value='" + rs.getString("r_id") + "'>"
                                                + rs.getString("r_name") + "</option>");
                                    }
                                    if (i == 0) {
                                        out.println("<option value='false'>请先在下方添加教室</option>");
                                    }
                                } catch (SQLException e) {

                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="sec-ts" class="input-group-addon">时段</label>
                        <select name="sec-ts" id="sec-ts" class="form-control">
                            <option value="false">请选择上课时间</option>
                            <%
                                try {
                                    PreparedStatement pstmt = con.prepareStatement("SELECT ts_id,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass FROM timeslot WHERE d_name = ?");
                                    pstmt.setString(1, (String) session.getAttribute("dept"));
                                    ResultSet rs = pstmt.executeQuery();
                                    int i = 0;
                                    while (rs.next()) {
                                        i++;
                                        out.println("<option value='" + rs.getString("ts_id") + "'>第"
                                                + rs.getString("ts_sweek") + "-" + rs.getString("ts_eweek")
                                                + "周，星期" + rs.getString("ts_day") + "，第"
                                                + rs.getString("ts_sclass") + "-" + rs.getString("ts_eclass")
                                                + "节</option>");
                                    }
                                    if (i == 0) {
                                        out.println("<option value='false'>请先在下方添加时段</option>");
                                    }
                                } catch (SQLException e) {

                                }
                            %>
                        </select>
                    </div>
                    <input type="hidden" name="type" value="sec">
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary">添加</button>
                    </div>
                    <div class="text-danger" id="tip0">&nbsp;</div>
                </form>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>课程</th>
                        <th>学期</th>
                        <th>学分</th>
                        <th>类型</th>
                        <th>教师</th>
                        <th title="可选择该课程的院系和年级">院系年级</th>
                        <th>时间地点</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            PreparedStatement pstmt = con.prepareStatement(
                                    "SELECT sec_id,c_title,sec_semester,sec_creadits,sec_type,t_name," +
                                            "sec_depts,s_grade,r_name,ts_sweek,ts_eweek,ts_day,ts_sclass," +
                                            "ts_eclass FROM sec  natural join course  natural join teacher" +
                                            " natural join classroom  natural join timeslot WHERE d_name = ?");
                            pstmt.setString(1, (String) session.getAttribute("dept"));
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.println("<tr><td>" + rs.getString("sec_id") + "</td><td>"
                                        + rs.getString("c_title") + "</td><td>" + rs.getString("sec_semester")
                                        + "</td><td>" + rs.getString("sec_creadits") + "</td><td>"
                                        + rs.getString("sec_type") + "</td><td>" + rs.getString("t_name")
                                        + "</td><td>" + rs.getString("sec_depts") + rs.getString("s_grade")
                                        + "</td><td>" + rs.getString("r_name") + "；第"
                                        + rs.getString("ts_sweek") + "-" + rs.getString("ts_eweek") + "，星期"
                                        + rs.getString("ts_day") + "，第" + rs.getString("ts_sclass") + "-"
                                        + rs.getString("ts_eclass") + "节</td><td><a class='text-danger " +
                                        "course-delete' href='admin2/addcourse.do?target=sec&id="
                                        + rs.getString("sec_id") + "'>删除</a></td></tr>");
                            }
                            rs.close();
                            pstmt.close();
                        } catch (SQLException e) {
                            out.println("\"\"查询数据库出错了\"\"");
                        }
                    %>
                    </tbody>
                </table>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading1">
            <h4 class="panel-title">
                <a class="collapsed block" aria-expanded="false" role="button"
                   data-toggle="collapse" data-parent="#accordion" data-target="#collapse1"
                   aria-expanded="true" aria-controls="collapse1">课程</a>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse1" class="panel-collapse collapse"
             role="tabpane" aria-labelledby="heading1">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/addcourse.do" class="form-inline add-course" data-msg="#tip">
                    <div class="input-group">
                        <label for="course-id" class="input-group-addon">课程编号</label>
                        <input type="text" id="course-id" name="course-id" class="form-control" required
                               placeholder="540101">
                    </div>
                    <div class="input-group">
                        <label for="course-title" class="input-group-addon">课程名称</label>
                        <input type="text" id="course-title" name="course-title" class="form-control" required
                               placeholder="C语言程序设计">
                    </div>
                    <input type="hidden" name="type" value="course">
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary">添加课程</button>
                    </div>
                    <div class="text-danger" id="tip">&nbsp;</div>
                </form>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>课程编号</th>
                        <th>课程名称</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            PreparedStatement pstmt = con.prepareStatement(
                                    "SELECT c_id,c_title,d_name FROM course WHERE d_name = ?");
                            pstmt.setString(1, (String) session.getAttribute("dept"));
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.print("<tr><td>" + rs.getString("c_id")
                                        + "</td><td>" + rs.getString("c_title") + "</td>"
                                        + "<td><a class='text-danger course-delete' "
                                        + "href='admin2/addcourse.do?target=course&id="
                                        + rs.getString("c_id") + "'>删除</a></td></tr>");
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='3' class='text-danger'>发生了异常(" + e.getMessage() + ")</td></tr>");
                        }
                    %>
                    </tbody>
                </table>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading2">
            <h4 class="panel-title">
                <a class="collapsed block" aria-expanded="false" role="button"
                   data-toggle="collapse" data-parent="#accordion"
                   data-target="#collapse2"
                   aria-expanded="true" aria-controls="collapse2">
                    教室
                </a>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse2" class="panel-collapse collapse"
             role="tabpane" aria-labelledby="heading2">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/addcourse.do" class="form-inline add-course" data-msg="#tip2">
                    <div class="input-group">
                        <label for="room-id" class="input-group-addon">教室编号</label>
                        <input type="text" id="room-id" name="room-id" class="form-control" required
                               placeholder="540201">
                    </div>
                    <div class="input-group">
                        <label for="room-name" class="input-group-addon">教室名称</label>
                        <input type="text" id="room-name" name="room-name" class="form-control" required
                               placeholder="F11">
                    </div>
                    <div class="input-group">
                        <label for="room-size" class="input-group-addon">教室容量</label>
                        <input type="number" id="room-size" name="room-size" class="form-control" required
                               placeholder="200">
                    </div>
                    <div class="input-group">
                        <label for="room-buildling" class="input-group-addon">所属楼宇</label>
                        <input type="text" id="room-buildling" name="room-building" class="form-control" required
                               placeholder="经信">
                    </div>
                    <input type="hidden" name="type" value="room">
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary">添加教室</button>
                    </div>
                    <div id="tip2" class="text-danger">&nbsp;</div>
                </form>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>教室编号</th>
                        <th>教室名称</th>
                        <th>教室容量</th>
                        <th>所属楼宇</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            PreparedStatement pstmt = con.prepareStatement(
                                    "SELECT r_id,r_name,r_size,R_BUILDING  FROM classroom WHERE d_name = ?");
                            pstmt.setString(1, (String) session.getAttribute("dept"));
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.print("<tr><td>" + rs.getString("r_id")
                                        + "</td><td>" + rs.getString("r_name")
                                        + "</td><td>" + rs.getString("r_size")
                                        + "</td><td>" + rs.getString("R_BUILDING")
                                        + "</td><td><a class='text-danger course-delete' " +
                                        "href='admin2/addcourse.do?target=room&id=" + rs.getString("r_id") + "'>删除</a></td></tr>");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='4' class='text-danger'>发生了异常(" + e.getMessage() + ")</td></tr>");
                        }
                    %>
                    </tbody>
                </table>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading3">
            <h4 class="panel-title">
                <a class="collapsed block" aria-expanded="false" role="button"
                   data-toggle="collapse" data-parent="#accordion"
                   data-target="#collapse3"
                   aria-expanded="true" aria-controls="collapse3">
                    时段
                </a>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse3" class="panel-collapse collapse"
             role="tabpane" aria-labelledby="heading3">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/addcourse.do" class="form-inline add-course" data-msg="#tip3">
                    <div class="input-group">
                        <label for="ts-id" class="input-group-addon">编号</label>
                        <input type="text" class="form-control" id="ts-id" name="ts-id" required placeholder="540301">
                    </div>
                    <div class="input-group">
                        <label for="ts-sw" class="input-group-addon">始周</label>
                        <input type="number" class="form-control" id="ts-sw" name="ts-sw" required value="1">
                    </div>
                    <div class="input-group">
                        <label for="ts-ew" class="input-group-addon">末周</label>
                        <input type="number" class="form-control" id="ts-ew" name="ts-ew" required value="16">
                    </div>
                    <div class="input-group">
                        <label for="ts-day" class="input-group-addon">星期</label>
                        <select name="ts-day" id="ts-day" class="form-control">
                            <option value="1">周一</option>
                            <option value="2">周二</option>
                            <option value="3">周三</option>
                            <option value="4">周四</option>
                            <option value="5">周五</option>
                            <option value="6">周六</option>
                            <option value="7">周日</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="ts-sc" class="input-group-addon">始节</label>
                        <select name="ts-sc" id="ts-sc" class="form-control">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select></div>
                    <div class="input-group">
                        <label for="ts-ec" class="input-group-addon">末节</label>
                        <select name="ts-ec" id="ts-ec" class="form-control">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12" selected>12</option>
                        </select>
                    </div>
                    <input type="hidden" name="type" value="ts">
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary">添加时段</button>
                    </div>
                    <div id="tip3" class="text-danger">&nbsp;</div>
                </form>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>描述</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            PreparedStatement pstmt = con.prepareStatement(
                                    "SELECT ts_id,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass FROM timeslot WHERE d_name = ?");
                            pstmt.setString(1, (String) session.getAttribute("dept"));
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.print("<tr><td>" + rs.getString("ts_id")
                                        + "</td><td>第" + rs.getString("ts_sweek") + " - " +
                                        rs.getString("ts_eweek") + "周， " +
                                        "星期" + rs.getString("ts_day") + "， " +
                                        "第" + rs.getString("ts_sclass") + " - " +
                                        rs.getString("ts_eclass") + "节</td><td><a class='text-danger course-delete'" +
                                        " href='admin2/addcourse.do?target=ts&id=" + rs.getString("ts_id") + "'>删除</a></td></tr>");
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='2' class='text-danger'>发生了异常(" + e.getMessage() + ")</td></tr>");
                        }
                    %>
                    </tbody>
                </table>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->
    <div id="alert-tip" style="position: fixed;right: 15px;z-index: 999;"></div>
</div>
<%--结束container，页面下半部分--%>
<%@ include file="../WEB-INF/content/admin2/bottom.jsp" %>
