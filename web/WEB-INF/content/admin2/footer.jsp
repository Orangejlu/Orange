<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 19:28 下午
  To change this template use File | Settings | File Templates.
--%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<div class="footer" id="copyright"
     style="background-image: url('<%=basePath%>ip.png');background-size: contain;background-repeat: round;">
    <p style="background-color: rgba(255,255,255,.3); color: black;">&copy; 2015 Orange
        JLU.<span>Your IP:<%=request.getRemoteAddr()%></span></p>
    <p><a href="javascript:scrollTo(0,0);" id="gototop">返回顶部</a></p>
</div>
<script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>admin2/admin.js"></script>
</body>

</html>
