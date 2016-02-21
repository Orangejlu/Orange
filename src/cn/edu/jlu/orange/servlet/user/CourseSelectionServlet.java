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
import java.sql.Statement;

/**
 * Created by lin on 2016-02-21-021.
 */
@WebServlet(name = "CourseSelectionServlet", value = "/user/select.do")
public class CourseSelectionServlet extends HttpServlet {
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

        String sec_id = request.getParameter("sec-id"),
                c_id = request.getParameter("cid");
        if (request.getParameter("selected") == null || sec_id == null || c_id == null)
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");

        Connection con = JDBCUtil.getConnection();
        String sql;
        PreparedStatement pstmt;
        if (request.getParameter("selected").equals("true")) {
            //退选
            sql = "DELETE FROM takes WHERE s_id = ? AND c_id = ? AND sec_id = ?";
            try {
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, (String) session.getAttribute("userId"));
                pstmt.setString(2, c_id);
                pstmt.setString(3, sec_id);
                int i = pstmt.executeUpdate();
                if (i > 0) {
                    System.out.println("退选成功" + i);
                    out.println("{\"ok\":\"true\",\"msg\":\"退选成功\"}");
                    pstmt.close();
                    return;
                } else out.println("{\"ok\":\"false\",\"msg\":\"退选失败\"}");
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            //选课
            sql = "INSERT INTO takes(s_id,c_id,sec_id) VALUES (?,?,?)";
            try {
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, (String) session.getAttribute("userId"));
                pstmt.setString(2, c_id);
                pstmt.setString(3, sec_id);
                int i = pstmt.executeUpdate();
                if (i > 0) {
                    System.out.println("插入记录选课成功" + i + "条记录" + session.getAttribute("userId") + c_id + " " + sec_id);
                    out.println("{\"ok\":\"true\",\"msg\":\"选课成功\"}");
                    pstmt.close();
                    return;
                } else out.println("{\"ok\":\"false\",\"msg\":\"选课失败\"}");
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("{\"ok\":\"false\",\"msg\":\"选课失败[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
