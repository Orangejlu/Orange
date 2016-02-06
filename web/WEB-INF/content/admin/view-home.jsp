<%@ page import="java.sql.*" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<h3>说明</h3>

<p>您是超级管理员，具有院系管理与增删教务账号的权限，点击上方标签即可进入相应管理界面。</p>

<h3>公告管理</h3>

<p>以下是已发布的公告</p>

<div class="container">
    <h4>已发布的公告</h4>
    <button data-target="#new" type="button"
            class="btn btn-primary hidelt9" data-toggle="modal">点击发布公告
    </button>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>#</th>
                <th>标题</th>
                <th>教务</th>
                <th>教师</th>
                <th>学生</th>
                <th>&times;</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection con = JDBCUtil.getConnection();
                ResultSet rs = JDBCUtil.getAllNotice();
                int i = 0;
                while (rs.next()) {
                    String readtype = rs.getString(5);
                    if (readtype == null) readtype = "";
                    String admin2see = "", teachersee = "", studentsee = "";
                    if (readtype.contains("1")) admin2see = "√";
                    if (readtype.contains("2")) teachersee = "√";
                    if (readtype.contains("3")) studentsee = "√";
            %>
            <tr>
                <td><span title="在数据库中的ID为:<%=rs.getString(1)%>"><%=++i%></span>
                </td>
                <td>
                    <a href="admin/#detail" data-target="#detail" data-toggle="modal"
                       title="<%=rs.getString(2)%> 发表于 <%=rs.getString(4)%>"
                       data-title="<%=rs.getString(2)%>"
                       data-time1="<%=rs.getString(4)%>"
                       data-type="<%=rs.getString(5)%>"
                       data-id="<%=rs.getString(1)%>"><%=rs.getString(2)%>
                    </a>
                </td>
                <td><%=admin2see%>
                </td>
                <td><%=teachersee%>
                </td>
                <td><%=studentsee%>
                </td>
                <td><a href="admin/addNotice.do?id=<%=rs.getString(1)%>" class="delete-notice">删除</a></td>
            </tr>
            <%
                }//while
            %>
            </tbody>
        </table>
    </div>
    <button data-target="#new"
            type="button" class="btn btn-primary hidelt9"
            data-toggle="modal">点击发布公告
    </button>
</div>
<style>
    .content-meta {
        color: #999;
        border-bottom: dashed 1px #999;
        margin-bottom: 1%;
        padding-bottom: 1%;;
    }</style>
<%--公告详情--%>
<div class="modal fade" id="detail" tabindex="-1" role="dialog"
     aria-labelledby="notice-title">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h3 id="notice-title"></h3>
            </div>
            <div class="modal-body content">
                <header class="content-meta">
                    <date id="notice-time"></date>
                    <span class="pull-right" id="types"></span>
                </header>
                <div class="content-body" id="notice-content">

                </div>
            </div><!--.modal-body-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!--.modal-content-->
    </div><!--.modal-dialog-->
</div>
<!--.modal-->

<!--发布公告-->
<div class="modal fade" id="new" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">发布公告</h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <form id="add-notice-form" action="admin/addNotice.do" method="post" role="form" class="form">
                        <h4>发布公告</h4>
                        <div class="form-group">
                            <label for="title">标题</label>
                            <input type="text" id="title" class="form-control" name="title" required
                                   placeholder="标题"></div>
                        <div class="form-group">
                            <label for="content">内容</label>
                                <textarea name="content" id="content" class="form-control"
                                          required cols="30" rows="5"
                                          placeholder="内容(填写完成后按Ctrl+Enter即可发布)"></textarea>
                        </div>
                        <style>.whocansee label {
                            margin-left: 5%;
                        }</style>
                        <div class="checkbox whocansee">&nbsp;
                            <label class="pull-left">
                                <input type="checkbox" checked name="admin2">教务</label>
                            <label class="pull-left">
                                <input type="checkbox" checked name="teacher">教师</label>
                            <label class="pull-left">
                                <input type="checkbox" checked name="student">学生</label>
                        </div>
                        <p class="help-block">只有勾选了的用户角色才能看到本条公告。</p>
                        <p id="tip" class="text-danger"></p>
                        <button id="sbm" type="submit" class="btn btn-primary btn-block"
                                style="margin-bottom: 2%;">发布公告
                        </button>
                    </form>
                </div>
            </div><!--.modal-body-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a id="sbm2" href="javascript:sbm.click();" type="button" class="btn btn-primary">发布</a>
            </div>
        </div><!--.modal-content-->
    </div><!--.modal-dialog-->
</div>
<!--.modal-->
