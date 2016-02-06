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
 * Created by lin on 2016-01-25-025.
 */
@WebServlet(name = "AllStuServlet", value = "/admin2/stu.do")
public class AllStuServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("utf-8");
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
        switch (type) {
            //region //编辑
            case "edit":
                String id = request.getParameter("edit-stu-id");
                String id2 = request.getParameter("edit-stu-id2");
                String name = request.getParameter("edit-stu-name");
                String gender = request.getParameter("edit-stu-gender");
                String grade = request.getParameter("edit-stu-grade");
                if (id == null || id2 == null || name == null || gender == null || grade == null
                        || (!gender.equals("M") & !gender.equals("F"))
                        || grade.trim().length() != 4) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
                    return;
                }
                sql = "UPDATE student set s_id2 = ? , s_name = ? , s_gender = ? , s_grade = ? WHERE s_id = ?";
                con = JDBCUtil.getConnection();
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, id2);
                    pstmt.setString(2, name);
                    pstmt.setString(3, gender);
                    pstmt.setString(4, grade);
                    pstmt.setString(5, id);
//                System.out.println(id + " " + id2 + " " + name + " " + gender + " " + grade);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        out.println("{\"ok\":\"true\",\"msg\":\"修改成功\"}");
                        return;
                    } else {
                        out.println("{\"ok\":\"false\",\"msg\":\"修改失败\"}");
                        return;
                    }
                } catch (SQLException e) {
//                e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"执行修改操作失败:(" + JDBCUtil.jsonReplace(e.getMessage()) + ")\"}");
                    return;
                }//endregion
            // region //重置
            case "reset": {
                String list[] = request.getParameterValues("check-list");
                if (list == null) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误(请至少选中一项)\"}");
                    return;
                }
                sql = "UPDATE student SET s_passwd = ? WHERE s_id = ?";
                con = JDBCUtil.getConnection();
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    int i = 0;
                    for (String item : list) {
                        pstmt.setString(1, JDBCUtil.MD5("Orange" + item + item));
                        pstmt.setString(2, item);
                        i += pstmt.executeUpdate();
                    }
                    if (i > 0) {
                        System.out.println("reset s_passwd:" + i + " row");
                        out.println("{\"ok\":\"true\",\"msg\":\"重置成功!(" + i + "条记录已修改)\"}");
                        return;
                    }
                } catch (SQLException e) {
//                e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"执行数据库语句出错:[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
                    return;
                }
                break;
            }//endregion
            //region //删除
            case "delete": {
                String list[] = request.getParameterValues("check-list");
                if (list == null) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误(请至少选中一项)\"}");
                    return;
                }
                sql = "DELETE FROM student WHERE s_id = ?";
                con = JDBCUtil.getConnection();
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    int i = 0;
                    for (String item : list) {
                        pstmt.setString(1, item);
                        i += pstmt.executeUpdate();
                    }
                    if (i > 0) {
                        System.out.println("Delete stu: " + i + " item(s)");
                        out.println("{\"ok\":\"true\",\"msg\":\"删除成功 (" + i + "条记录已删除)\"}");
                        return;
                    }
                } catch (SQLException e) {
//                e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"执行删除操作失败(请刷新重试):[" + JDBCUtil.jsonReplace(e.getMessage()) + "]\"}");
                    return;
                }
                break;
            }//endregion
        }
        out.println("{\"ok\":\"false\",\"msg\":\"非法请求\"}");
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
/*
DEPARTMENT
STUDENT
TEACHER
TIMESLOT
CLASSROOM
PLACETIME
COURSE
SEC
TAKES
TEACHES
ADMIN
NOTICE

*/
