package cn.edu.jlu.orange.servlet.admin;

import cn.edu.jlu.orange.JDBCUtil;
import oracle.sql.NUMBER;

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
 * Created by lin on 2016-01-11-011.
 */
@WebServlet(name = "DeptServlet", value = "/admin/dept.do")
public class DeptServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //{"ok":"false","msg":"..."}
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        if (logined == null || type == null || type != 0) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String d_id = request.getParameter("d-id");
        String d_name = request.getParameter("d-name");
        if (d_id == null || d_name == null || d_id.equals("") || d_name.equals("")) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误(表单均为必填项)\"}");
            return;
        }
        String sql = "INSERT INTO department(d_id,d_name) VALUES(?,?)";
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, d_id);
            pstmt.setString(2, d_name);
            int i = pstmt.executeUpdate();
            System.out.println("添加院系成功：" + i + "行受影响");
            pstmt.close();
            out.println("{\"ok\":\"true\",\"msg\":\"添加院系成功\"}");
        } catch (SQLException e) {
            //e.printStackTrace();
            //{"ok":"false","msg":"添加出错(ORA-00001: 违反唯一约束条件 (OUSER.UQ_D_ID))"}
            out.println("{\"ok\":\"false\"," +
                    "\"msg\":\"添加出错(请检查是否与已有项目重复):[" + jsonReplace(e.getMessage()) + "]\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        if (logined == null || type == null || type != 0) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String d_id = request.getParameter("d-id");
        if (d_id == null || d_id.equals("")) {
//            {"ok":"false","msg":"..."};
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        String sql = "DELETE FROM department WHERE d_id = ?";
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, d_id);
            int i = pstmt.executeUpdate();
            System.out.println("删除成功：" + i + "行受影响(删除院系)");
            out.println("{\"ok\":\"true\",\"msg\":\"删除院系成功\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\"," +
                    "\"msg\":\"数据库出错(可能是该院系的教师和学生或课程相关没有被删除):" +
                    "[" + jsonReplace(e.getMessage()) + "]\"}");
        }
    }

    private String jsonReplace(String str) {
        return str.replace("\"", "\'").replace(":", "_").replace("\n", " ");
    }
}
