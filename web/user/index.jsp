<%@ page import="java.sql.ResultSet" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-15-015
  Time: 20:03 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ include file="../WEB-INF/content/user/top.jsp" %>
<script>function addmyclass() {
    $('#home').addClass('active');
}</script>
<div class="table-responsive">
    <h4>系统公告</h4>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>#<span class="sr-only">序号</span></th>
            <th>标题</th>
            <th>发布时间</th>
        </tr>
        </thead>
        <tbody>
        <%
            ResultSet rs = JDBCUtil.getAllNotice();
            try {
                int i = 0;
                while (rs.next()) {
                    if (rs.getString(JDBCUtil.NOTICE_TYPE).contains("3") && i < JDBCUtil.NOTICE_LIMIT) {
        %>
        <tr>
            <td class="shap"><span title="在数据库中的ID为：<%=rs.getString("id")%>"><%=++i%></span></td>
            <td class="title">
                <a href="<%=basePath%>user/#notice-detail"
                   data-target="#notice-detail"
                   data-toggle="modal"
                   data-noticepubtime="<%=rs.getString("pubtime")%>"
                   data-noticetitle="<%=rs.getString("title")%>"
                   data-noticeid="<%=rs.getString("id")%>"><%=rs.getString("title")%>
                </a>
            </td>
            <td class="pubtime"><%=rs.getString("pubtime")%>
            </td>
        </tr>
        <%
                    }//if
                }//while
            } catch (SQLException e) {
                out.println("<div> colspan=\"3\" class=\"text-danger\">获取公告失败</div>");
            }
        %>
        </tbody>
    </table>
</div>
<!--/.table-responsive-->
<div class="modal fade" id="notice-detail" tabindex="-1" role="dialog"
     aria-labelledby="notice-title">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h3 id="notice-title">公告详情</h3></div>
            <div class="modal-body">
                <header>
                    发布时间： <date id="notice-pubtime"></date>
                </header><br>
                <a href="<%=basePath%>" id="notice-remote-uri" class="hide"></a>
                <div id="notice-content">正在加载公告详情...</div>
            </div><!--.modal-body-->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div><!--/.modal-content-->
    </div><!--/.modal-dialog-->
</div>
<!--/.modal-->

<%@ include file="../WEB-INF/content/user/bottom.jsp" %>