package cn.edu.jlu.orange.servlet;

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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by lin on 2016-01-11-011.
 * 使用ajax post账号密码给此Servlet
 * 登录成功返回跳转地址，否则返回提示信息。
 */
@WebServlet(name = "LoginCheckServlet", urlPatterns = "/login.do")
public class LoginCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String result = "";

        //有post数据
        if (request.getParameter("username") != null && request.getParameter("password") != null) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username == null || password == null || username.equals("") || password.length() != 32) {
                out.println("{\"ok\":\"false\",\"msg\":\"用户名或密码不能为空\"}");
                return;
            }

            username = username.toLowerCase();
            System.out.println("username=" + username + " password=" + password);

            Connection con = JDBCUtil.getConnection();
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            //管理员账号以字母开头
            if (username.charAt(0) >= 'a' && username.charAt(0) <= 'z') {
                String sql = "SELECT name,type,d_name FROM admin WHERE name = ? AND passwd = ?";

                try {
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        //id:int name:varchar passwd:char type:int
                        System.out.println("name:" + rs.getString(1) + " type:" + rs.getInt(2));
                        if (rs.getInt(2) == 0) {
                            //把 账号名,账号类型 写入会话
                            session.setAttribute("logined", rs.getString(1));
                            session.setAttribute("type", 0);
                            System.out.println("管理员登录成功");
                            //response.sendRedirect("admin/");
                            out.println("{\"ok\":\"true\",\"msg\":\"admin/\"}");
                            return;
                        }
                        if (rs.getInt(2) == 1) {
                            session.setAttribute("logined", rs.getString(1));
                            session.setAttribute("type", 1);
                            session.setAttribute("dept", rs.getString("d_name"));
                            System.out.println("教务登录成功");
                            //response.sendRedirect("admin2/");
                            out.println("{\"ok\":\"true\",\"msg\":\"admin2/\"}");
                            return;
                        }
                    }//while
                } catch (Exception e) {
                    e.printStackTrace();
                    //session.setAttribute("msg", "数据库出错");
                    //response.sendRedirect(referer);
                    out.println("{\"ok\":\"false\",\"msg\":\"数据库出错\"}");
                    return;
                }
                System.out.println("管理员尝试登录失败");

            } else {
                //教师、学生 账号不是以字母开头
                String sql = "SELECT * FROM student WHERE s_id = ? AND s_passwd = ?";
                try {
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        session.setAttribute("logined", rs.getString("s_name"));
                        session.setAttribute("userId", rs.getString("s_id"));
                        session.setAttribute("type", 3);
                        session.setAttribute("dept", rs.getString("d_name"));
                        System.out.println("学生登录");
                        //response.sendRedirect("user/");
                        out.println("{\"ok\":\"true\",\"msg\":\"user/\"}");
                        return;
                    }

                    sql = "SELECT * FROM teacher WHERE t_id = ? AND t_passwd = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        session.setAttribute("logined", rs.getString("t_name"));
                        session.setAttribute("userId", rs.getString("t_id"));
                        session.setAttribute("type", 2);
                        session.setAttribute("dept", rs.getString("d_name"));
                        System.out.println("教师登录");
                        //response.sendRedirect("teacher/");
                        out.println("{\"ok\":\"true\",\"msg\":\"teacher/\"}");
                        return;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    //session.setAttribute("msg", "数据库出错");
                    out.println("{\"ok\":\"false\",\"msg\":\"数据库出错\"}");
                }
                System.out.println("登录失败");
            }//学生、教师账号不是字母开头

        }//有post数据

        //session.setAttribute("msg", "用户名或密码错误");
        session.setAttribute("logined", null);
        //response.sendRedirect("login.jsp?reason=loginfailed");
        out.println("{\"ok\":\"false\",\"msg\":\"用户名或密码错误\"}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp?reason=login");
    }
}
