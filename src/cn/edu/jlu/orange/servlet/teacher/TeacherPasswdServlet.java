package cn.edu.jlu.orange.servlet.teacher;

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
 * Created by lin on 2016-02-22-022.
 */
@WebServlet(name = "TeacherPasswdServlet", value = "/teacher/passwd.do")
public class TeacherPasswdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 2) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String oldpass = request.getParameter("old-pass"),
                newpass = request.getParameter("new-pass"),
                userid = request.getParameter("t-id");
        if (oldpass == null || newpass == null || userid == null
                || oldpass.length() != 32 || newpass.length() != 32) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String sql = "UPDATE teacher set t_passwd = ? WHERE t_id = ? AND t_passwd = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newpass);
            pstmt.setString(2, userid);
            pstmt.setString(3, oldpass);
            int i = pstmt.executeUpdate();
            if (i > 0) {
                System.out.println("教师修改密码成功");
                out.println("{\"ok\":\"true\",\"msg\":\"修改成功\"}");
                session.setAttribute("logined", null);
            } else {
                out.println("{\"ok\":\"false\",\"msg\":\"修改失败，可能是原密码错误\"}");
            }
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\"," +
                    "\"msg\":\"修改失败，数据库错误(" + JDBCUtil.jsonReplace(e.getMessage()) + ")\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
