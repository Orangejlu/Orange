<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 23:06 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ include file="../WEB-INF/content/admin2/top.jsp" %>
<%--页面上半部分，container开始--%>
<script>function addmyclass() {
    $('#m-student').addClass('active');
}</script>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading1">
            <h4 class="panel-title">
                <span class="collapsed block" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse1"
                      aria-expanded="true" aria-controls="collapse1">
                    从文件批量添加学生
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse1" class="panel-collapse collapse"
             role="tabpanel" aria-labelledby="heading1">
            <div class="panel-body">
                <form action="<%=basePath%>admin2/studentFileUpload.do" id="stu-file-upload-form"
                      role="form" method="post" enctype="multipart/form-data">
                    从csv文件上传，格式应如下所示(密码默认与教学号一致)：<a href="<%=basePath%>admin2/student-sample.csv">下载示例文件</a>
<pre>教学号,学号,姓名,性别,年级
54131000,55131000,张三,男,2013</pre>
                    <div class="input-group">
                        <label for="stu-file" class="input-group-addon">选择文件</label>
                        <input id="stu-file" name="stu-file" type="file" class="form-control" accept=".csv">
                        <a class="btn btn-primary input-group-addon"
                           data-toggle="modal" data-target="#stu-file-dlg">上传</a>
                    </div>
                </form>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
        <%--TODO 学生名单文件上传--%>
        <div class="modal fade" id="stu-file-dlg" tabindex="-1" role="dialog" aria-labelledby="fileupload">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h3 id="fileupload">上传文件 <img src="<%=basePath%>img/loading.gif" alt="Loading"
                                                      id="stu-file-loading">
                        </h3>
                    </div>
                    <div class="modal-body">
                        <div id="stu-modal-body-content"></div>
                        <div id="stu-modal-body-msg"></div>
                        <table></table>
                    </div><!--.modal-body-->
                    <div class="modal-footer">
                        <button type="button" class="btn" data-dismiss="modal">关闭</button>
                    </div>
                </div><!--.modal-content-->
            </div><!--.modal-dialog-->
        </div><!--.modal-->
    </div><!--.panel-->

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading2">
            <h4 class="panel-title">
                <span class="block collapsed" aria-expanded="false" role="button"
                      data-toggle="collapse" data-parent="#accordion"
                      data-target="#collapse2"
                      aria-expanded="true" aria-controls="collapse2">
                    学院学生一览
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse2" class="panel-collapse collapse in"
             role="tabpanel" aria-labelledby="heading2">
            <div class="panel-body">
                <div class="table-responsive" style="max-height: 500px;">
                    <style>.checkbox-label {
                        display: flex;
                    }</style>
                    <script>
                        function selectAll() {
                            var flag = true;
                            if ($('#flag').val() == 0) {
                                flag = true;
                                $('#flag').val(1);
                            }
                            else {
                                flag = false;
                                $('#flag').val(0);
                            }
                            //console.log(flag + " ");
                            $('.select-all').prop('checked', flag);
                            $('input[name="check-list"]').prop('checked', flag);
                            //firefox中 checkbox属性checked="checked"已有，但复选框却不显示打钩的原因
                            //http://blog.sina.com.cn/s/blog_6657f20e0101g793.html
                            //attr换成prop
                        }
                    </script>
                    <table class="table table-striped table-hover" id="stu-table">
                        <form action="admin2/stu.do" id="all-stu" role="form">
                            <thead>
                            <tr>
                                <th><label class="checkbox-label">
                                    <input type="checkbox" class="select-all" onchange="selectAll()">
                                    <span class="sr-only">全选</span></label>
                                    <input type="hidden" id="flag" value="0">
                                </th>
                                <th>#</th>
                                <th>教学号</th>
                                <th>学号</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>年级</th>
                                <th>编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <sql:setDataSource var="sql" driver="oracle.jdbc.driver.OracleDriver"
                                               url="jdbc:oracle:thin:@127.0.0.1:1521:orcl"
                                               user="ouser" password="Ozszs233"/>

                            <sql:query var="result" dataSource="${sql}">
                                SELECT s_id,s_id2,s_name,s_gender,s_grade FROM student ORDER BY s_id
                            </sql:query>
                            <c:set var="i" value="0"/>
                            <c:forEach var="row" items="${result.rows}">
                                <c:set var="i" value="${i+1}"/>
                                <tr>
                                    <td>
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="check-list"
                                                   id="check-<c:out value="${row.s_id}"/>"
                                                   value="<c:out value="${row.s_id}"/>">
                                        </label></td>
                                    <td><c:out value="${i}"/></td>
                                    <td><c:out value="${row.s_id}"/></td>
                                    <td><c:out value="${row.s_id2}"/></td>
                                    <td><c:out value="${row.s_name}"/></td>
                                    <td>
                                            <%--http://www.runoob.com/jsp/jstl-core-choose-tag.html--%>
                                        <c:choose>
                                            <c:when test="${row.s_gender == 'M'}">
                                                男
                                            </c:when>
                                            <c:otherwise>女</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${row.s_grade}"/></td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-warning"
                                                data-target="#edit-stu-detail"
                                                data-toggle="modal"
                                                data-id="<c:out value="${row.s_id}"/>"
                                                data-id2="<c:out value="${row.s_id2}"/>"
                                                data-name="<c:out value="${row.s_name}"/>"
                                                data-gender="<c:out value="${row.s_gender}"/>"
                                                data-grade="<c:out value="${row.s_grade}"/>"
                                                id="edit-info-<c:out value='${row.s_id}'/>">编辑信息
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <c:if test="${i>0}">
                                <tfoot>
                                <tr>
                                    <th><label class="checkbox-label">
                                        <input type="checkbox" class="select-all" onchange="selectAll()">
                                        <span class="sr-only">全选</span></label>
                                    </th>
                                    <th>#</th>
                                    <th>教学号</th>
                                    <th>学号</th>
                                    <th>姓名</th>
                                    <th>性别</th>
                                    <th>年级</th>
                                    <th>编辑</th>
                                </tr>
                                <tr>
                                    <td><span class="sr-only">选中项：</span></td>
                                    <td colspan="5">
                                        <div id="msg" class="text-danger"></div>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-primary" id="reset-passwd">重置密码
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-danger" id="delete-stu">删除
                                        </button>
                                    </td>
                                </tr>
                                </tfoot>
                            </c:if>
                            <input type="hidden" id="all-stu-type" name="type" value="">
                        </form>
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
                    添加单个学生
                </span>
            </h4>
        </div><!--.panel-heading-->
        <div id="collapse3" class="panel-collapse collapse"
             role="tabpanel" aria-labelledby="heading3">
            <div class="panel-body">
                <form action="admin2/addStudent.do" method="post" role="form"
                      id="add-one-stu" class="form-horizontal">
                    <div class="form-group">
                        <label for="stuid" class="col-sm-2 control-label">教学号</label>
                        <div class="col-sm-10">
                            <input type="text" id="stuid" name="id" class="form-control" required></div>
                    </div>
                    <div class="form-group">
                        <label for="stuid2" class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-10">
                            <input type="text" id="stuid2" name="id2" class="form-control" required></div>
                    </div>
                    <div class="form-group">
                        <label for="stuname" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" id="stuname" name="name" class="form-control" required></div>
                    </div>
                    <div class="form-group">
                        <label for="stugender" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <select type="text" id="stugender" name="gender" class="form-control" required>
                                <option value="M">男(M-male)</option>
                                <option value="F">女(F-Female)</option>
                            </select></div>
                    </div>
                    <div class="form-group">
                        <label for="stugrade" class="col-sm-2 control-label">年级</label>
                        <div class="col-sm-10">
                            <select type="text" id="stugrade" name="grade" class="form-control" required>
                                <%
                                    //Java获取当前时间的年月日方法
                                    //http://blog.csdn.net/kookob/article/details/6885383
                                    Calendar now = Calendar.getInstance();
                                    int year = now.get(Calendar.YEAR);
                                %>
                                <option value="<%=year+4%>"><%=year + 4%>
                                </option>
                                <option value="<%=year+3%>"><%=year + 3%>
                                </option>
                                <option value="<%=year+2%>"><%=year + 2%>
                                </option>
                                <option value="<%=year+1%>"><%=year + 1%>
                                </option>
                                <option value="<%=year%>" selected><%=year%>
                                </option>
                                <option value="<%=year-1%>"><%=year - 1%>
                                </option>
                                <option value="<%=year-2%>"><%=year - 2%>
                                </option>
                                <option value="<%=year-3%>"><%=year - 3%>
                                </option>
                                <option value="<%=year-4%>"><%=year - 4%>
                                </option>
                            </select></div>
                    </div>
                    <input type="hidden" name="type" value="addOneStu">
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <span class="text-danger" id="tip">&nbsp;</span>
                        </div>
                    </div>
                </form>
            </div><!--.panel-body-->
        </div><!--.pabel-collapse-->
    </div><!--.panel-->

    <div class="modal fade" id="edit-stu-detail" tabindex="-1" role="dialog"
         aria-labelledby="title">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 id="title">编辑信息</h3></div>
                <div class="modal-body">
                    <form id="edit-stu-detail-form" action="admin2/stu.do" class="form-horizontal" method="post">
                        <div class="form-group">
                            <label for="edit-stu-id" class="col-sm-2 control-label">教学号</label>
                            <div class="col-sm-10">
                                <input type="text" id="edit-stu-id" name="edit-stu-id" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-stu-id2" class="col-sm-2 control-label">学号</label>
                            <div class="col-sm-10">
                                <input type="text" id="edit-stu-id2" name="edit-stu-id2" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-stu-name" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" id="edit-stu-name" name="edit-stu-name" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-stu-gender" class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <select type="text" id="edit-stu-gender" name="edit-stu-gender" class="form-control">
                                    <option value="M">男 (M-male)</option>
                                    <option value="F">女 (F-Female)</option>
                                </select></div>
                        </div>
                        <div class="form-group">
                            <label for="edit-stu-grade" class="col-sm-2 control-label">年级</label>
                            <div class="col-sm-10">
                                <input type="text" id="edit-stu-grade" name="edit-stu-grade" class="form-control">
                            </div>
                        </div>
                        <input type="hidden" name="type" value="edit">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button id="edit-stu-info" type="submit" class="btn btn-primary">修改</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <span id="info" class="text-danger">&nbsp;</span>
                            </div>
                        </div>
                    </form>
                </div><!--.modal-body-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div><!--.modal-content-->
        </div><!--.modal-dialog-->
    </div><!--.modal-->

</div>
<%--结束container，页面下半部分--%>
<%@ include file="../WEB-INF/content/admin2/bottom.jsp" %>
