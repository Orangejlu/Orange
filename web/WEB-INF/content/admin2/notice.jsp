<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 20:24 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<%ResultSet rs = JDBCUtil.getAllNotice();%>
<div class="table-responsive">
    <h4>系统公告</h4>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>#</th>
            <th>标题</th>
            <th>发布时间</th>
        </tr>
        </thead>
        <tbody>

        <%
            String basePath1 = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
            int i = 0;
            while (rs.next()) {
                if (rs.getString(JDBCUtil.NOTICE_TYPE).contains("1") && i < JDBCUtil.NOTICE_LIMIT) {
        %>
        <tr>
            <td class="shap"><span title="在数据库中的ID为：<%=rs.getString("id")%>"><%=++i%></span></td>
            <td class="title">
                <a href="<%=basePath1%>admin2/#notice-detail"
                   data-target="#notice-detail"
                   data-toggle="modal"
                   data-noticepubtime="<%=rs.getString("pubtime")%>"
                   data-noticetitle="<%=rs.getString("title")%>"
                   data-noticeid="<%=rs.getString("id")%>"><%=rs.getString("title")%>
                </a>
            </td>
            <td class="pubtime">
                <date><%=rs.getString("pubtime")%>
                </date>
            </td>
        </tr>
        <%
                }//if
            }//while rs.next
            if (i != 0) {
        %>
        <!--[if lt IE 9]>
        <i style="display: block;text-align: center;background-color: #fff;">
            您的浏览器不支持bootstrap的模态框技术因此将不能看到公告详情</i>
        <![endif]-->
        <%
            }
        %>
        </tbody>
    </table>
</div>
<div class="modal fade" id="notice-detail" tabindex="-1" role="dialog"
     aria-labelledby="notice-title">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h3 id="notice-title">公告详情</h3></div>
            <div class="modal-body">
                <header>
                    <date id="notice-pubtime"></date>
                </header>
                <a href="<%=basePath1%>" id="notice-remote-uri" class="hide"></a>
                <div id="notice-content">正在加载公告详情...</div>
            </div><!--.modal-body-->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div><!--.modal-content-->
    </div><!--.modal-dialog-->
</div>
<!--.modal-->
