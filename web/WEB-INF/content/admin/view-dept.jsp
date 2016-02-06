<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-17-017
  Time: 12:03 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%
    Connection con = JDBCUtil.getConnection();
    String sql = "SELECT to_char(d_id,'09') as id,d_name FROM department ORDER BY d_id";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
%>
<div class="container">
    <h3>院系一览</h3>
    <form class="form-inline" action="admin/dept.do" method="post" id="add-dept-form">
        <h4 class="sr-only">添加院系</h4>
        <p class="help-block text-info">编号两位数且不能与已有编号重复，
            名称20个字符(十个汉字)以内且不能与已有名称重复</p>
        <div class="form-group">
            <label for="d-id">编号</label>
            <input type="number" class="form-control" id="d-id"
                   name="d-id" max="99" min="01" pattern="\d{2}"
                   placeholder="54" required>
        </div>
        <div class="form-group">
            <label for="d-name">名称</label>
            <input type="text" class="form-control" id="d-name"
                   name="d-name" maxlength="20" placeholder="软件学院"
                   required>
        </div>
        <button id="sbm" type="submit" class="btn btn-primary">添加</button>
        <p id="tip" class="text-danger">&nbsp;</p>
    </form>

    <div class="alert alert-block hide" id="warning-block">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <h4>Warning!</h4>Best check yo self, you're not...
    </div>

    <script type="text/javascript">
        $(function () {
            $('[data-toggle="popover"]').popover()
        })
    </script>

    <div class="table-responsive">
        <p class="text-danger text-justify">(警告:数据库中其他表依赖于院系表,因此除非该院系的所有相关记录均已删除,否则将不能删除院系)</p>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
                    <span class="sr-only">序号</span>
                </th>
                <th><span class="glyphicon glyphicon-list" aria-hidden="true"></span>院系编号</th>
                <th><span class="glyphicon glyphicon-home" aria-hidden="true"></span>院系名称</th>
                <th><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    <span class="sr-only">删除</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 0;
                while (rs.next()) {
            %>
            <tr>
                <td><%=++i%>
                </td>
                <td><%=rs.getString(1)%>
                </td>
                <td><%=rs.getString("d_name")%>
                </td>
                <td><a class="text-danger delete-dept" href="admin/dept.do?d-id=<%=rs.getString("id")%>">删除</a></td>

            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<!--.container-->