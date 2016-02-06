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
 * Created by lin on 2016-01-13-013.
 */
@WebServlet(name = "ChangePasswordServlet", value = "/admin2/pass.do")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        if (logined == null || type == null || type != 1) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        // {"ok":"false","msg":"..."}
        String name = request.getParameter("name");
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        if (name == null || oldpass == null || newpass == null
                || name.equals("") || oldpass.length() != 32 || newpass.length() != 32) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
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
                System.out.println("教务更改密码成功");
                session.setAttribute("logined", null);
                session.setAttribute("type", -1);
                out.println("{\"ok\":\"true\",\"msg\":\"更改成功\"}");
                return;
            } else {
                out.println("{\"ok\":\"false\",\"msg\":\"原密码错误\"}");
                return;
            }
        } catch (SQLException e) {
            out.println("{\"ok\":\"false\",\"msg\":\"数据库异常:[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
