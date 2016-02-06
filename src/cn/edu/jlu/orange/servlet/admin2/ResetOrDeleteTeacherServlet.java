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
 * Created by lin on 2016-01-12-012.
 */
@WebServlet(name = "ResetOrDeleteTeacherServlet", value = "/admin2/resetOrDelete.do")
public class ResetOrDeleteTeacherServlet extends HttpServlet {
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
        //参数
        String id = request.getParameter("t-id"),
                name = request.getParameter("t-name"),
                level = request.getParameter("t-level"),
                email = request.getParameter("t-email");
        if (id == null || name == null || level == null || email == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String sql = " UPDATE teacher SET t_name = ? , t_level = ? , t_email = ? " +
                " WHERE t_id = ? AND d_name = ? ";

        PreparedStatement pstmt;
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, level);
            pstmt.setString(3, email);
            pstmt.setString(4, id);
            pstmt.setString(5, (String) session.getAttribute("dept"));
            int i = pstmt.executeUpdate();
            if (i > 0) {
                System.out.println(session.getAttribute("logined") + "(教务)修改" + name + "(教师)资料成功");
                out.println("{\"ok\":\"true\",\"msg\":\"修改成功\"}");
                return;
            }
        } catch (SQLException e) {
            out.println("{\"ok\":\"false\"" +
                    ",\"msg\":\"执SQL语句发生了异常:[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
            return;
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        String target = request.getParameter("type");
        String id = request.getParameter("id");
        if (target == null || id == null || target.equals("") || id.equals("")) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        PreparedStatement pstmt = null;
        String sql;
        //重置
        if (target.equals("0")) {
            sql = "UPDATE teacher SET t_passwd = ? WHERE t_id = ?";
            try {
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, JDBCUtil.MD5("Orange" + id + id));
                pstmt.setString(2, id);
                int i = pstmt.executeUpdate();
                System.out.println("重置密码:" + i + "行受影响");
                if (i > 0) {
                    out.println("{\"ok\":\"true\",\"msg\":\"重置密码成功<!--" + i + "行受影响-->\"}");
                    return;
                }
            } catch (SQLException e) {
                out.println("{\"ok\":\"false\"," +
                        "\"msg\":\"数据库异常" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                return;
            }
        }
        //删除
        else if (target.equals("1")) {
            sql = "DELETE FROM teacher WHERE t_id = ?";
            try {
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                int i = pstmt.executeUpdate();
                System.out.println("删除教师:" + i + "行受影响");
                if (i > 0) {
                    out.println("{\"ok\":\"true\",\"msg\":\"删除成功\"}");
                    return;
                }
            } catch (SQLException e) {
                out.println("{\"ok\":\"false\",\"msg\":\"删除失败(可能是有其他约束关系尚未删除):" +
                        "[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
                return;
            }
        }//delete
    }
}
