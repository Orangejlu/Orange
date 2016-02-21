package cn.edu.jlu.orange.servlet.user;

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
 * Created by lin on 2016-02-19-019.
 */
@WebServlet(name = "UserPasswdServlet", value = "/user/passwd.do")
public class UserPasswdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 3) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String oldpass = request.getParameter("passwd"),
                newpass = request.getParameter("new-passwd"),
                userid = request.getParameter("user-id");
        if (oldpass == null || newpass == null || userid == null
                || oldpass.length() != 32 || newpass.length() != 32) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement(
                    "UPDATE student SET s_passwd = ? WHERE s_id = ? AND s_passwd = ?");
            pstmt.setString(1, newpass);
            pstmt.setString(2, userid);
            pstmt.setString(3, oldpass);
            int i = pstmt.executeUpdate();
            if (i > 0) {
                session.setAttribute("logined", null);
                System.out.println("学生修改密码成功" + i);
                out.println("{\"ok\":\"true\",\"msg\":\"修改密码成功\"}");
            } else out.println("{\"ok\":\"false\",\"msg\":\"修改失败,请检查原密码是否正确\"}");
            pstmt.close();
            JDBCUtil.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\"," +
                    "\"msg\":\"数据库错误(" + JDBCUtil.jsonReplace(e.getMessage()) + ")\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
