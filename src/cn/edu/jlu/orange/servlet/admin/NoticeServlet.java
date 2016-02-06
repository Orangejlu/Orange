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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by lin on 2016-01-11-011.
 */
@WebServlet(name = "NoticeServlet", value = "/admin/addNotice.do")
public class NoticeServlet extends HttpServlet {
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

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String admin2 = request.getParameter("admin2");
        String teacher = request.getParameter("teacher");
        String student = request.getParameter("student");
        String readtype = "";
        if (admin2 != null) {
            readtype += "1";
        }
        if (teacher != null) {
            readtype += "2";
        }
        if (student != null) {
            readtype += "3";
        }
        if (title == null || content == null || title.equals("") || content.equals("") || readtype.equals("")) {
            out.println("{\"ok\":\"false\",\"msg\":\"请检查表单(标题,内容均不能为空;角色至少勾选一项)\"}");
            return;
        }
        /**1.自动增加ID；2.当前时间
         * 首先(在SQLPlus里)创建序列，
         * <pre>
         *  create sequence notice_id_sequence increment by 1 start with 1 nomaxvalue nocycle cache 10;
         * </pre>
         * sysdate表示当前时间
         * */
        String sql = "INSERT INTO notice values(notice_id_sequence.nextval,?,?,sysdate,?)";
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, readtype);
            int i = pstmt.executeUpdate();
            System.out.println(i + "行受影响:添加公告成功");
            pstmt.close();
            out.println("{\"ok\":\"true\",\"msg\":\"\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\",\"msg\":\"数据库出错\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        String id = request.getParameter("id");
        if (id == null || id.equals("")) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        String sql = "DELETE FROM notice WHERE id = ?";
        Connection con = JDBCUtil.getConnection();
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            int i = pstmt.executeUpdate();
            System.out.println("删除了" + i + "行:删除公告");
            pstmt.close();
            out.println("{\"ok\":\"true\",\"msg\":\"删除成功\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\",\"msg\":\"数据库出错\"}");
        }

    }//doGet
}
