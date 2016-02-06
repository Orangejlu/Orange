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
import java.net.ConnectException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by lin on 2016-01-11-011.
 */
@WebServlet(name = "AdminServlet", value = "/admin/admin2.do")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String target = request.getParameter("type");
        if (target == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"非法请求\"}");
            return;
        }
        //添加用户
        switch (target) {
            case "add": {
                String name = request.getParameter("uname");
                String passwd = request.getParameter("password");
                String dept = request.getParameter("dept");
                if (name == null || passwd == null || dept == null || passwd.length() != 32
                        || name.equals("") || passwd.equals("") || dept.equals("")) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
                    return;
                }
                if (name.toLowerCase().charAt(0) < 'a' || name.toLowerCase().charAt(0) > 'z') {
                    out.println("{\"ok\":\"false\",\"msg\":\"用户名必须以字母开头\"}");
                    return;
                }
                Connection con = JDBCUtil.getConnection();
                String sql = " INSERT INTO admin(id,name,passwd,type,d_name) " +
                        " values(admin_id_sequence.nextval,?,?,1,?) ";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, passwd);
                    pstmt.setString(3, dept);
                    int i = pstmt.executeUpdate();
                    System.out.println("添加用户成功：" + i + "行受影响");
                    out.println("{\"ok\":\"true\",\"msg\":\"添加用户成功\"}");
                } catch (SQLException e) {
                    //e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"添加失败(用户名不能重复):[" + jsonReplace(e.getMessage()) + "]\"}");
                }
                break;
            }
            //修改密码
            case "change": {
                String name = request.getParameter("username");
                String newpasswd = request.getParameter("newpasswd");
                if (name == null || newpasswd == null || name.equals("") || newpasswd.equals("")) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
                    return;
                }
                //{"ok":"false","msg":"..."}
                String sql = "UPDATE admin SET passwd =? WHERE name = ?";
                Connection con = JDBCUtil.getConnection();
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, newpasswd);
                    pstmt.setString(2, name);
                    int i = pstmt.executeUpdate();
                    System.out.println("修改密码成功：" + i + "行受影响");
                    out.println("{\"ok\":\"true\",\"msg\":\"修改密码成功\"}");
                    return;
                } catch (SQLException e) {
//                e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"修改密码失败[" + jsonReplace(e.getMessage()) + "]\"}");
                    return;
                }
            }
            default:
                out.println("{\"ok\":\"false\",\"msg\":\"参数不正确\"}");
                break;
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

        String name = request.getParameter("name");
        if (name == null || name.equals("")) {
            out.println("{\"ok\":\"false\",\"msg\":\"缺少参数\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String sql = "DELETE FROM admin WHERE name = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            int i = pstmt.executeUpdate();
            System.out.println("删除用户成功：" + i + "行受影响");
            out.println("{\"ok\":\"true\",\"msg\":\"删除用户成功\"}");
            return;
        } catch (SQLException e) {
            out.println("{\"ok\":\"false\",\"msg\":\"删除失败:[" + jsonReplace(e.getMessage()) + "]\"}");
            return;
        }
    }

    private String jsonReplace(String str) {
        return str.replace("\"", "\'").replace(":", "_").replace("\n", " ");
    }

}
