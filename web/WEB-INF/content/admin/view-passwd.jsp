<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-18-018
  Time: 17:57 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>
<h3>更改密码</h3>
<style>.input-group {  margin: 2% auto;  }</style>

<form action="admin/passwd.do" role="form" id="passwd-form" method="post" class="form-inline">
    <div class="input-group">
        <label for="oldpassPlain" class="input-group-addon">原密码</label>
        <input type="password" id="oldpassPlain" class="form-control" required>
        <input type="hidden" id="oldpass" name="oldpass">
    </div>
    <div class="input-group">
        <label for="newpassPlain" class="input-group-addon">新密码</label>
        <input type="password" id="newpassPlain" class="form-control" required>
        <input type="hidden" id="newpass" name="newpass">
    </div>
    <input type="hidden" name="name" id="name" value="<%=(String)session.getAttribute("logined")%>">
    <button type="submit" class="btn btn-primary" id="sbm">更改</button>
    <p class="help-block">更改成功后需要重新登陆。</p>
    <p id="tip" class="text-danger">&nbsp;</p>
</form>
