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
 * Created by lin on 2016-01-18-018.
 */
@WebServlet(name = "AddStudentServlet", value = "/admin2/addStudent.do")
public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer types = (Integer) session.getAttribute("type");
        if (logined == null || types == null || types != 1) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String type = request.getParameter("type");
        String sql = "";
        Connection con = null;
        if (type.equals("addOneStu")) {
            String id = request.getParameter("id");
            String id2 = request.getParameter("id2");
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String grade = request.getParameter("grade");
            String d_name = (String) session.getAttribute("dept");
            if (id == null || id2 == null || name == null || gender == null || grade == null
                    || d_name == null || (!gender.equals("M") & !gender.equals("F"))
                    || grade.trim().length() != 4) {
                System.out.println(gender + " " + grade + " " + d_name + gender.equals("M"));
                out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
                return;
            }
            sql = "INSERT INTO student(s_id,s_id2,s_name,s_gender,s_passwd,d_name,s_grade) VALUES (?,?,?,?,?,?,?)";
            con = JDBCUtil.getConnection();
            try {
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                pstmt.setString(2, id2);
                pstmt.setString(3, name);
                pstmt.setString(4, gender);
                pstmt.setString(5, JDBCUtil.MD5("Orange" + id + id));
                pstmt.setString(6, d_name);
                pstmt.setString(7, grade);
                int i = pstmt.executeUpdate();
                if (i > 0) {
                    System.out.println("添加单个学生成功");
                    out.println("{\"ok\":\"true\",\"msg\":\"添加成功\"}");
                    return;
                } else {
                    out.println("{\"ok\":\"false\",\"msg\":\"添加了0条记录\"}");
                    return;
                }
            } catch (SQLException e) {
                out.println("{\"ok\":\"false\"," +
                        "\"msg\":\"添加失败(请检查是否重复添加):[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
//                e.printStackTrace();
                return;
            }
        }//addOneStu
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
