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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by lin on 2016-02-22-022.
 */
@WebServlet(name = "ScoreServlet", value = "/teacher/score.do")
public class ScoreServlet extends HttpServlet {
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
        String id = request.getParameter("id"),
                score = request.getParameter("score");
        if (id == null || score == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        String s_id = id.substring(0, id.indexOf('-')),
                c_id = id.substring(id.indexOf('-') + 1);
        //System.out.println(s_id + " " + c_id);
        String point = "0", creadit = "0";
        boolean passed = true;
        switch (score) {
            case "优秀":
            case "A":
            case "优":
                point = "4";
                break;
            case "B":
            case "良好":
            case "良":
                point = "3";
                break;
            case "C":
            case "中等":
            case "中":
                point = "2";
                break;
            case "D":
            case "差":
            case "及格":
                point = "1";
                break;
            case "E":
            case "不及格":
                point = "0";
                passed = false;
                break;
            default:
                int s;
                try {
                    s = Integer.parseInt(score);
                } catch (Exception e) {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误(分数只能是0-100的数字或‘ABSDE’或优良中差不及格)\"}");
                    return;
                }
                if (s >= 0 && s < 60) {
                    point = "0";
                    passed = false;
                } else if (s >= 60 && s < 65) {
                    point = "1";
                } else if (s >= 65 && s < 70) {
                    point = "1.5";
                } else if (s >= 70 && s < 75) {
                    point = "2";
                } else if (s >= 75 && s < 80) {
                    point = "2.5";
                } else if (s >= 80 && s < 85) {
                    point = "3";
                } else if (s >= 85 && s < 90) {
                    point = "3.5";
                } else if (s >= 90 && s <= 100) {
                    point = "4";
                } else {
                    out.println("{\"ok\":\"false\",\"msg\":\"参数错误(分数只能是0-100的数字或‘ABSDE’或优良中差不及格)\"}");
                    return;
                }
        }

        Connection con = JDBCUtil.getConnection();
        String sql = "SELECT sec_creadits FROM sec WHERE c_id = ?";
        if (passed)

        {
            //region 取得课程的学分
            try {
                PreparedStatement preparedStatement = con.prepareStatement(sql);
                preparedStatement.setString(1, c_id);
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    creadit = rs.getString("sec_creadits");
                    //System.out.println(creadit);
                }
                rs.close();
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }//endregion
        }

        sql = "UPDATE takes SET tk_score = ? , tk_point = ? , tk_credit = ? WHERE s_id = ? AND c_id = ?";
        try

        {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, score);
            pstmt.setString(2, point);
            pstmt.setString(3, creadit);
            pstmt.setString(4, s_id);
            pstmt.setString(5, c_id);
            int i = pstmt.executeUpdate();
            if (i > 0) {
                System.out.println("修改成绩成功");
                out.println("{\"ok\":\"true\",\"msg\":\"成绩修改成功\"}");
            } else {
                out.println("{\"ok\":\"false\",\"msg\":\"操作失败\"}");
            }
        } catch (
                SQLException e
                )

        {
            e.printStackTrace();
            out.println("{\"ok\":\"false\",\"msg\":\"操作失败(" + JDBCUtil.jsonReplace(e.getMessage()) + ")\"}");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
