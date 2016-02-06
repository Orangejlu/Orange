package cn.edu.jlu.orange.servlet.admin;

import cn.edu.jlu.orange.JDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by lin on 2016-01-11-011.
 */
@WebServlet(name = "PasswdServlet", value = "/admin/passwd.do")
public class PasswdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
//        PrintStream out = System.out;
//        out.println("POST");
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        if (logined == null || type == null || type != 0) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }

        String name = request.getParameter("name");
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        if (name == null || oldpass == null || newpass == null || oldpass.length() != 32 || newpass.length() != 32) {
            out.println("{\"ok\":\"false\",\"msg\":\"请检查输入,表单均为必填项\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String sql = "UPDATE admin SET passwd = ? WHERE name = ? AND passwd = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newpass);
            pstmt.setString(2, name);
            pstmt.setString(3, oldpass);
            int i = pstmt.executeUpdate();
            if (i > 0) {
                session.setAttribute("logined", null);
                System.out.println("修改密码成功:" + i + "行受影响");
                out.println("{\"ok\":\"true\",\"msg\":\"修改密码成功\"}");
            } else {
                out.println("{\"ok\":\"false\",\"msg\":\"修改密码失败(可能是您输入的原密码不正确)\"}");
            }
        } catch (SQLException e) {
            out.println("{\"ok\":\"false\",\"msg\":\"修改失败[" + jsonReplace(e.getMessage()) + "]\"}");
            System.out.println("{\"ok\":\"false\",\"msg\":\"修改失败[" + jsonReplace(e.getMessage()) + "]\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("post only");
    }

    private String jsonReplace(String str) {
        return str.replace("\"", "\'").replace(":", "_").replace("\n", " ");
    }

}
