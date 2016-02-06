<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-17-017
  Time: 12:03 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.*" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<form action="admin/admin2.do" method="post" class="form-inline" id="add-admin-form" role="form">
    <h3>添加教务用户</h3>
    <p class="help-block">用户名不能与已有用户名重复,且只能以字母开头。</p>
    <%//alter table admin add constraint uq_admin_name unique(name);%>
    <style>.input-group {
        margin: 0;
        padding: 1px;
    }</style>
    <div class="input-group">
        <label for="uname" class="input-group-addon">用户名</label>
        <input type="text" id="uname" class="form-control"
               name="uname" required placeholder="software">
    </div>
    <div class="input-group">
        <label for="passwdPlain" class="input-group-addon">密&nbsp;&nbsp;&nbsp;码</label>
        <input type="password" id="passwdPlain" required placeholder="******" class="form-control">
        <input type="hidden" id="password" name="password">
    </div>
    <div class="form-group">
        <select name="dept" class="form-control" id="adddept" name="adddept">
            <option value="">请选择所属院系</option>
            <%
                Connection con = JDBCUtil.getConnection();
                String sql = "SELECT d_id,d_name FROM department";
                ResultSet rs = null;
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        out.println("<option value=\"" + rs.getString("d_name") + "\">"
                                + rs.getString("d_id") + "-" + rs.getString("d_name") + "</option>");
                    }
                } catch (SQLException e) {
                }
            %>
        </select>
    </div>
    <input type="hidden" value="add" name="type">
    <button id="add-admin-sbm" class="btn btn-primary" type="submit">添加</button>
    <p id="tip" class="text-danger">&nbsp;</p>
</form>

<div class="table-responsive">
    <h3>教务用户一览</h3>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span><span class="sr-only">序号</span>
            </th>
            <th><span class="glyphicon glyphicon-user" aria-hidden="true"></span>用户名</th>
            <th><span class="glyphicon glyphicon-home" aria-hidden="true"></span>所属</th>
            <th><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                <span class="sr-only">修改密码</span>
            </th>
            <th><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                <span class="sr-only">删除</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%
            sql = "SELECT id,name,type,d_name FROM admin WHERE type = 1 ORDER BY type,id";
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            int i = 0;
            boolean hasresult = false;
            while (rs.next()) {
                hasresult = true;
        %>
        <tr>
            <td><span title="在数据库中的ID为：<%=rs.getString("id")%>"><%=++i%></span></td>
            <td><%=rs.getString("name")%>
            </td>
            <td><%=rs.getString("d_name")%>
            </td>
            <td>
                <button data-target="#changepasswd" class="btn btn-default"
                        data-toggle="modal"
                        data-name="<%=rs.getString("name")%>">修改密码
                </button>
            </td>
            <td>
                <button data-target="#deleteconfirm" class="btn btn-danger"
                        data-toggle="modal"
                        data-name="<%=rs.getString("name")%>">删除
                </button>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<%
    if (hasresult) {
%>
<div class="modal fade" id="changepasswd" tabindex="-1"
     role="dialog" aria-labelledby="changepasswdheader">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="changepasswdheader">修改密码</h4>
            </div>
            <div class="modal-body">
                <form id="change-passwd-form" method="post" role="form" action="admin/admin2.do">
                    <div class="form-group">
                        <label for="username" class="control-label">用户名</label>
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="form-group">
                        <label for="newpasswdPlain" class="control-label">新密码:</label>
                        <input type="password" id="newpasswdPlain" class="form-control">
                        <input type="hidden" name="newpasswd" id="newpasswd">
                    </div>
                    <input type="hidden" value="change" name="type">
                    <button type="submit" id="sbm" class="btn btn-primary btn-block">修改密码</button>
                    <div id="msg" class="text-danger">&nbsp;</div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a id="sbm2" href="javascript:sbm.click();" type="button" class="btn btn-primary">修改</a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteconfirm" tabindex="-1" role="dialog" aria-labelledby="deleteheader">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteheader">确认删除
                </h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        <h3 class="panel-title">警告</h3>
                    </div>
                    <div class="panel-body">
                        <div>
                            您正打算删除用户：<span id="deleteuserspan"></span>，
                            此操作将不能撤销，您确认这样做吗？
                        </div>
                    </div>
                    <div class="panel-footer">好好的为什么要删除呢(-｡-;)</div>
                </div>
                <p id="info" class="text-danger">&nbsp;</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                <a href="admin/admin2.do" id="deleteusera" type="button"
                        class="btn btn-default">确认删除
                </a>
            </div>
        </div>
    </div>
</div>

<%
    }
%>
