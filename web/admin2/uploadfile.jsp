<%@ page import="java.io.FileReader" %>
<%@ page import="org.apache.commons.csv.CSVRecord" %>
<%@ page import="java.io.Reader" %>
<%@ page import="org.apache.commons.csv.CSVFormat" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="cn.edu.jlu.orange.JDBCUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2016-01-09-009
  Time: 12:50 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" language="java" errorPage="../error.jsp" %>
<%
    if (!request.getMethod().toLowerCase().equals("post")) {
        return;
    }
%>
<%!
    //http://bbs.csdn.net/topics/70473069
    //jsp里面的函数不能用out.print吗？
    private String parseSCV(String file, JspWriter out, String d_name) throws java.io.IOException, SQLException {
        String msg = "";
        String sql = "INSERT INTO teacher(t_id,t_name,t_level,t_email,t_passwd,d_name) VALUES(?,?,?,?,?,?)";
        Connection con = JDBCUtil.getConnection();
        int i = 0;
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            Reader in = new FileReader(file);
//            加上withHeader(),否则record.get报错
//            No header mapping was specified, the record values can't be accessed by name
//http://stackoverflow.com/questions/27323639/no-header-mapping-was-specified-the-record-values-cant-be-accessed-by-name-ap
            Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(in);
            for (CSVRecord record : records) {
                pstmt.setString(1, record.get("工作证号"));
                pstmt.setString(2, record.get("姓名"));
                pstmt.setString(3, record.get("职称"));
                pstmt.setString(4, record.get("邮箱"));
                pstmt.setString(5, JDBCUtil.MD5("Orange" + record.get("工作证号") + record.get("工作证号")));
                pstmt.setString(6, d_name);
                i += pstmt.executeUpdate();
                out.println("<tr><td>" + record.get("工作证号") + "</td><td>"
                        + record.get("姓名") + "</td><td>"
                        + record.get("职称") + "</td><td>"
                        + record.get("邮箱") + "</td></tr>");
            }
            System.out.println(i + "行已插入");
        } catch (FileNotFoundException e) {
            msg = "FileNotFoundException" + e.getMessage();
        } catch (IOException e) {
            msg = "IOException" + e.getMessage();
        } catch (Exception e) {
            msg = "发生了异常" + e.getMessage();
            e.printStackTrace();
        }
        return msg;
    }
%>
<div id="return-content">
    <%
        String msg = (String) session.getAttribute("message");
        if (msg != null) {
            out.print("<blockquote><div class=\"help-block text-info\">" + msg + "</div></blockquote>");
            session.setAttribute("message", null);
        }
        String filename = (String) session.getAttribute("filename");
        System.out.println(filename);
        if (filename != null && !filename.equals("")) {
            Connection con = JDBCUtil.getConnection();
            String sql = "SELECT d_name FROM admin WHERE name = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, (String) session.getAttribute("logined"));
            ResultSet rs = pstmt.executeQuery();
            String d_name = "";
            while (rs.next()) {
                d_name = rs.getString("d_name");
                break;
            }
    %>
    <div class="table-responsive">
        <h4>上传内容</h4>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>工作证号</th>
                <th>姓名</th>
                <th>职称</th>
                <th>邮箱</th>
            </tr>
            </thead>
            <tbody>
            <%
                String result = parseSCV(filename, out, d_name);
            %>
            </tbody>
        </table>
    </div>
    <div><p class="text-info"><%=result%></p><p class="text-info">2秒后页面重新加载...</p></div>
    <script>setTimeout(function(){location.reload();},2000);</script>
    <%
        }//filename != ""
    %>
</div>
