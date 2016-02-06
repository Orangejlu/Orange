package cn.edu.jlu.orange.servlet.admin2;

import cn.edu.jlu.orange.JDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by lin on 2016-01-09-009.
 */
@WebServlet(name = "AddOneTeacherServlet",value = "/admin2/addteacher.do")
public class AddOneTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        if (logined == null || type == null || type != 1) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }

        String id = request.getParameter("addid");
        String name = request.getParameter("addname");
        String level = request.getParameter("addlevel");
        String email = request.getParameter("addemail");
        String d_name = (String) request.getSession().getAttribute("d_name");

        if (id == null || name == null || level == null || email == null || d_name == null) {
            out.println("<div>error</div>");
            return;
        }
        //t_id,t_name,t_level,t_email,t_passwd,d_name
        String sql = "INSERT INTO teacher values(?,?,?,?,?,?)";
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, name);
            pstmt.setString(3, level);
            pstmt.setString(4, email);
            pstmt.setString(5, JDBCUtil.MD5("Orange" + id + id));
            pstmt.setString(6, d_name);
            int i = pstmt.executeUpdate();
            out.println("<div>" + i + "行已添加成功</div>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div>" + e.getMessage() + "</div>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<div>12你好3</div>");
    }
}
