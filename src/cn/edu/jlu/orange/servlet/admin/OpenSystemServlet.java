package cn.edu.jlu.orange.servlet.admin;

import cn.edu.jlu.orange.JDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Created by lin on 2016-02-19-019.
 */
@WebServlet(name = "OpenSystemServlet", value = "/switch.do")
public class OpenSystemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 0) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String open = request.getParameter("open");
        if (open == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        if (open.equals("true")) {
            try {
                Statement stmt = con.createStatement();
                int i = stmt.executeUpdate("UPDATE info SET value = 'true' WHERE key = 'opened'");
                if (i == 0) {
                    i = stmt.executeUpdate("INSERT INTO info(key,value) VALUES ('opened','true')");
                }
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.println("{\"ok\":\"true\",\"msg\":\"opened\"}");
        } else {
            try {
                Statement stmt = con.createStatement();
                int i = stmt.executeUpdate("UPDATE info SET value = 'false' WHERE key = 'opened'");
                stmt.close();
            } catch (SQLException e) {
            }
            out.println("{\"ok\":\"true\",\"msg\":\"notOpen\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 0) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }

        String semester = request.getParameter("semester");
        if (semester == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement("UPDATE info SET value = ? WHERE key = 'semester'");
            pstmt.setString(1, semester);
            int i = pstmt.executeUpdate();
            if (i == 0) {
                pstmt = con.prepareStatement("INSERT INTO info(key,value) VALUES ('semester',?)");
                pstmt.setString(1, semester);
                i = pstmt.executeUpdate();
            }
            pstmt.close();
            out.println("{\"ok\":\"true\",\"msg\":\"" + semester + "\"}");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
