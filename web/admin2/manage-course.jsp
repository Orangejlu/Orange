<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
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
                <span class="collapsed block" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse4"
                      aria-expanded="true" aria-controls="collapse4">
                    开课
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse4" class="panel-collapse collapse in"
             role="tabpane" aria-labelledby="heading4">
            <div class="panel-body">
                <form action=""></form>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>课程</th>
                        <th>教室</th>
                        <th>学期</th>
                        <th>类型</th>
                        <th>学分</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                </table>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading1">
            <h4 class="panel-title">
                <span class="collapsed block" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion" data-target="#collapse1"
                      aria-expanded="true" aria-controls="collapse1">课程</span>
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
                        Connection con = JDBCUtil.getConnection();
                        try {
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT c_id,c_title FROM course");
                            while (rs.next()) {
                                out.print("<tr><td>" + rs.getString("c_id")
                                        + "</td><td>" + rs.getString("c_title") + "</td>" +
                                        "<td><a class='text-danger course-delete' " +
                                        "href='admin2/addcourse.do?target=course&id=" + rs.getString("c_id") + "'>删除</a></td></tr>");
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
                <span class="collapsed block" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse2"
                      aria-expanded="true" aria-controls="collapse2">
                    教室
                </span>
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
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT r_id,r_name,r_size,R_BUILDING  FROM classroom");
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
                <span class="collapsed block" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse3"
                      aria-expanded="true" aria-controls="collapse3">
                    时段
                </span>
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
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT ts_id,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass FROM timeslot");
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
