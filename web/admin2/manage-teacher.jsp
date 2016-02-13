<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
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
    $('#m-teacher').addClass('active');
}</script>
<%
    Connection con = JDBCUtil.getConnection();
    String sql = "SELECT d_name FROM admin WHERE name = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, (String) session.getAttribute("logined"));
    ResultSet rs = pstmt.executeQuery();
    String d_name = "";
    while (rs.next()) {
        d_name = rs.getString("d_name");
        if (d_name != null) break;
    }
    session.setAttribute("d_name", d_name);
%>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="headingOne">
            <h4 class="panel-title">
                <span class="collapsed block" aria-expanded="false" role="button"
                     data-toggle="collapse" data-parent="#accordion"
                     data-target="#collapseOne"
                     aria-expanded="true" aria-controls="collapseOne">
                    批量添加教师
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapseOne" class="panel-collapse collapse"
             role="tabpanel" aria-labelledby="headingOne">
            <div class="panel-body">
                <form role="form" method="post" enctype="multipart/form-data" id="addfileform">

                    <div class="input-group">
                        <label for="addfile" class="input-group-addon">选择文件</label>
                        <input id="addfile" name="addfile" type="file" class="form-control" accept=".csv">
                        <a href="<%=basePath%>admin2/manage-teacher.jsp#file-dlg"
                           class="btn btn-primary input-group-addon"
                           data-toggle="modal"
                           data-target="#file-dlg"
                           data-upload-url="<%=basePath%>admin2/uploadteacherfile.do">上传</a>
                    </div>
                    <p class="help-block">所选文件应为逗号分隔的电子表格文件,后缀名为<code>.csv</code>使用记事本打开格式如下：<br>
        <pre>
    工作证号,姓名,职称,邮箱
    5400000,张三,教授,zs@a.edu.cn
</pre>
                    第一行是表头(必须与上例一毛一样);各项内容不应包含特殊字符,否则可能不能识别.密码将会设为和工作证号一致。
                    </p>
                    <blockquote><a href="<%=basePath%>admin2/sample.csv">下载示例文件</a></blockquote>
                </form>

                <div class="modal fade" id="file-dlg" tabindex="-1" role="dialog" aria-labelledby="fileupload">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h3 id="fileupload">上传文件 <img src="<%=basePath%>img/loading.gif" alt="Loading"
                                                              id="loading">
                                </h3>
                            </div>
                            <div class="modal-body">
                                <div id="file-upload-content"></div>
                                <div id="todb"></div>
                            </div><!--.modal-body-->
                            <div class="modal-footer">
                                <button type="button" class="btn" data-dismiss="modal">关闭</button>
                                <%--<button type="button" class="btn btn-primary" disabled id="btn-todb">插入数据库</button>--%>
                            </div>
                        </div><!--.modal-content-->
                    </div><!--.modal-dialog-->
                </div>
                <!--.modal-->
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="headingTWO">
            <h4 class="panel-title">
                <span class="block" role="button" data-toggle="collapse" data-parent="#accordion"
                     data-target="#collapseTWO"
                     aria-expanded="true" aria-controls="collapseTWO">
                    <mark><%=d_name%>
                    </mark>
                    教师一览
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapseTWO" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTWO">
            <div class="panel-body">
                <div class="table-responsive" style="max-height: 500px;">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th title="序号" class="text-center"><span class="glyphicon glyphicon-list"></span><span
                                    class="sr-only">序号</span></th>
                            <th title="工作证号"><span class="glyphicon glyphicon-minus"></span><span
                                    class="sr-only">工作证号</span></th>
                            <th title="姓名"><span class="glyphicon glyphicon-user"></span><span class="sr-only">姓名</span>
                            </th>
                            <th title="职称"><span class="glyphicon glyphicon-leaf"></span><span class="sr-only">职称</span>
                            </th>
                            <th title="邮箱" class="text-center"><span class="glyphicon glyphicon-envelope"></span><span
                                    class="sr-only">邮箱</span></th>
                            <th title="编辑信息" class="text-center"><span class="glyphicon glyphicon-edit"></span><span
                                    class="sr-only">编辑</span></th>
                            <th title="重置密码与删除" class="text-center"><span
                                    class="glyphicon glyphicon-repeat"></span><span
                                    class="sr-only">重置密码</span>&nbsp;<span
                                    class="glyphicon glyphicon-remove"></span><span
                                    class="sr-only">删除</span></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            int i = 0;
                            sql = "SELECT * FROM teacher WHERE d_name = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setString(1, d_name);
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                                //t_id,t_name,t_level,t_email,t_passwd,d_name
                        %>
                        <tr>
                            <td class="text-center"><%=++i%>
                            </td>
                            <td><%=rs.getString("t_id")%>
                            </td>
                            <td><%=rs.getString("t_name")%>
                            </td>
                            <td><%=rs.getString("t_level")%>
                            </td>
                            <td><%=rs.getString("t_email")%>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-info" data-toggle="modal"
                                        data-id="<%=rs.getString("t_id")%>"
                                        data-name="<%=rs.getString("t_name")%>"
                                        data-level="<%=rs.getString("t_level")%>"
                                        data-email="<%=rs.getString("t_email")%>"
                                        data-target="#edit">编辑信息
                                </button>
                            </td>
                            <td class="text-center">
                                <div class="btn-group" style="width: 115px;">
                                    <button class="btn-warning btn btn-sm" id="reset-passwd"
                                            data-name1="<%=rs.getString("t_name")%>"
                                            data-target="#alert" data-id="<%=rs.getString("t_id")%>"
                                            data-toggle="modal" data-type="reset">重置密码
                                    </button>
                                    <button class="btn-danger btn btn-sm" id="delete-teacher"
                                            daa-name="<%=rs.getString("t_name")%>"
                                            data-name1="<%=rs.getString("t_name")%>"
                                            data-target="#alert" data-id="<%=rs.getString("t_id")%>"
                                            data-toggle="modal" data-type="delete">删除
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading3">
            <h4 class="panel-title">
                <span class="block collapsed" aria-expanded="false" role="button"
                     data-toggle="collapse" data-parent="#accordion"
                     data-target="#collapse3"
                     aria-expanded="true" aria-controls="collapse3">
                    添加单个教师
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse3" class="panel-collapse collapse"
             role="tabpanel" aria-labelledby="heading3">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/addteacher.do" role="form" id="add-one-teacher-form">
                    <div class="input-group">
                        <label for="addid" class="input-group-addon">编号</label>
                        <input type="text" class="form-control" id="addid" name="addid" required>
                    </div>
                    <div class="input-group">
                        <label for="addname" class="input-group-addon">姓名</label>
                        <input type="text" class="form-control" id="addname" name="addname" required>
                    </div>
                    <div class="input-group">
                        <label for="addlevel" class="input-group-addon">职称</label>
                        <input type="text" id="addlevel" name="addlevel" class="form-control">
                    </div>
                    <div class="input-group">
                        <label for="addemail" class="input-group-addon">邮箱</label>
                        <input type="email" id="addemail" class="form-control" name="addemail">
                    </div>
                    <input type="hidden" name="d_name" value="<%=d_name%>">
                    <p class="text-info help-block" id="add-one-teacher-result"></p>
                    <button class="btn btn-primary btn-block" id="add-one-teacher-submit">提交</button>
                </form>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <!--提示框-->
    <div class="modal fade" id="alert" tabindex="-1" role="dialog"
         aria-labelledby="notice-title">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 id="notice-title">警告</h3></div>
                <div class="modal-body" id="alert-content">

                </div><!--.modal-body-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div><!--.modal-content-->
        </div><!--.modal-dialog-->
    </div><!--.modal-->
    <!--提示框结束-->

    <div class="modal fade" id="edit" tabindex="-1" role="dialog"
         aria-labelledby="edit-title">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 id="edit-title">编辑</h3></div>
                <div class="modal-body" id="edit-content">
                    <form action="admin2/resetOrDelete.do" role="form" method="post" id="edit-form">
                        <div class="input-group">
                            <span class="input-group-addon">编号</span>
                            <input type="text" id="t-id" name="t-id" class="form-control" readonly>
                        </div>
                        <div class="input-group">
                            <label for="t-name" class="input-group-addon">姓名</label>
                            <input type="text" id="t-name" name="t-name" class="form-control">
                        </div>
                        <div class="input-group">
                            <label for="t-level" class="input-group-addon">职称</label>
                            <input type="text" id="t-level" name="t-level" class="form-control">
                        </div>
                        <div class="input-group">
                            <label for="t-email" class="input-group-addon">邮箱</label>
                            <input type="email" id="t-email" name="t-email" class="form-control">
                        </div>
                        <%--<div class="input-group">
                            <label for="t-email" class="input-group-addon">密码</label>
                            <input type="password" id="t-pass-plain" class="form-control" >
                            <input type="hidden" id="t-pass" name="t-pass">
                        </div>--%>
                        <div id="msg">&nbsp;</div>
                        <input type="submit" class="btn btn-block btn-primary" id="edit-info">
                    </form>
                </div><!--.modal-body-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div><!--.modal-content-->
        </div><!--.modal-dialog-->
    </div><!--.modal-->
</div>
<!--.panel-group-->

<%--结束container，页面下半部分--%>
<%@ include file="../WEB-INF/content/admin2/bottom.jsp" %>
