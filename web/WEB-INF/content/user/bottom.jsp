<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-02-15-015
  Time: 09:08 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" language="java" %>

    </div><!--.container-->
<div id="end"></div>
</div><!--#wrap-->
<div class="footer" id="copyright"
     style="background-image: url('<%=basePath%>ip.png');background-size: contain;background-repeat: round;">
    <p>&copy; 2015 Orange JLU.<span>Your IP:<%=request.getRemoteAddr()%></span></p>
    <p><a href="javascript:scrollTo(0,0);" id="gototop">返回顶部</a></p>
</div>
<script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>user/user.js"></script>
</body>
</html>