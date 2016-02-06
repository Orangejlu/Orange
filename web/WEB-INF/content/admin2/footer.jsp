<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2015-12-19-019
  Time: 19:28 下午
  To change this template use File | Settings | File Templates.
--%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

<div class="footer" id="copyright" style="background-image: url('ip.png');background-size: contain;background-repeat: round;">
    <p>&copy; 2015 Orange JLU.<span>Your IP:<%=request.getRemoteAddr()%></span></p>

    <p>
        <a href="javascript:scrollTo(0,0);" id="gototop">返回顶部</a>
    </p>

</div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="admin2/admin.js"></script>
</body>

</html>
