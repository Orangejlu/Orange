<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-18-018
  Time: 13:34 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<footer id="copyright" style="background-image: url('ip.png');background-size: contain;background-repeat: round;">
    <p style="background-color: rgba(255,255,255,.3); color: black;">&copy; 2015 Orange JLU.
        <span>Your IP:<%=request.getRemoteAddr()%></span></p>
    <p><a href="#">返回顶部</a></p>
</footer>
<style>
    .admin-footer p:last-child {
        margin-bottom: 0;
    }</style>

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="admin/admin.js"></script>
</body>

</html>
