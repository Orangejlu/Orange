package cn.edu.jlu.orange.servlet.admin2;

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
 * Created by lin on 2016-02-13-013.
 */
@WebServlet(name = "AddCourseRoomTimeServlet", value = "/admin2/addcourse.do")
public class AddCourseRoomTimeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 1) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String target = request.getParameter("type");
        if (target == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        boolean error = false;
        Connection con = JDBCUtil.getConnection();
        String sql;
        switch (target) {
            //region //course
            case "course": {
                String courseId = request.getParameter("course-id"),
                        courseTitle = request.getParameter("course-title");
                if (courseId == null || courseTitle == null) {
                    error = true;
                    break;
                }
                sql = "INSERT INTO course(c_id,c_title) VALUES (?,?)";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, courseId);
                    pstmt.setString(2, courseTitle);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("插入课程:" + i + "条记录");
                        out.println("{\"ok\":\"true\",\"msg\":\"添加课程成功(" + i + "条)\"}");
                    } else {
                        out.println("{\"ok\":\"false\",\"msg\":\"添加课程失败\"}");
                    }
                } catch (SQLException e) {
                    //e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"添加课程失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }//endregion
            //region //room
            case "room": {
                String roomId = request.getParameter("room-id"),
                        roomName = request.getParameter("room-name"),
                        roomSize = request.getParameter("room-size"),
                        roomBuilding = request.getParameter("room-building");
                if (roomId == null || roomName == null || roomSize == null || roomBuilding == null) {
                    error = true;
                    break;
                }
                sql = "INSERT INTO classroom(r_id,r_name,r_size,r_building) VALUES (?,?,?,?)";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, roomId);
                    pstmt.setString(2, roomName);
                    pstmt.setString(3, roomSize);
                    pstmt.setString(4, roomBuilding);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("添加教室成功:" + i + "条记录");
                        out.println("{\"ok\":\"true\",\"msg\":\"添加教室成功:(" + i + "条记录)\"}");
                    } else {
                        out.println("{\"ok\":\"false\",\"msg\":\"添加教室失败\"}");
                    }
                } catch (SQLException e) {
                    //e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"添加教室失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }//endregion
            //region //timeslot
            case "ts": {
                String tsId = request.getParameter("ts-id"),
                        tsStartWeek = request.getParameter("ts-sw"),
                        tsEndWeek = request.getParameter("ts-ew"),
                        tsDay = request.getParameter("ts-day"),
                        tsStartClass = request.getParameter("ts-sc"),
                        tsEndClass = request.getParameter("ts-ec");
                if (tsId == null || tsStartWeek == null || tsEndWeek == null
                        || tsDay == null || tsStartClass == null || tsEndClass == null) {
                    error = true;
                    break;
                }
                sql = "INSERT INTO timeslot(ts_id,ts_sweek,ts_eweek,ts_day,ts_sclass,ts_eclass) VALUES (?,?,?,?,?,?)";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, tsId);
                    pstmt.setString(2, tsStartWeek);
                    pstmt.setString(3, tsEndWeek);
                    pstmt.setString(4, tsDay);
                    pstmt.setString(5, tsStartClass);
                    pstmt.setString(6, tsEndClass);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("添加时段成功:" + i + "条记录");
                        out.println("{\"ok\":\"true\",\"msg\":\"添加时段成功:(" + i + "条记录)\"}");
                    } else out.println("{\"ok\":\"true\",\"msg\":\"添加时段失败\"}");
                } catch (SQLException e) {
                    //e.printStackTrace();
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"添加时段失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }//endregion
        }
        if (error)
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //鉴权
        String logined = (String) session.getAttribute("logined");
        Integer type = (Integer) session.getAttribute("type");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (logined == null || type == null || type != 1) {
            out.println("{\"ok\":\"false\",\"msg\":\"权限不足\"}");
            return;
        }
        String target = request.getParameter("target"),
                id = request.getParameter("id");
        if (target == null || id == null) {
            out.println("{\"ok\":\"false\",\"msg\":\"参数错误\"}");
            return;
        }
        Connection con = JDBCUtil.getConnection();
        String sql;
        switch (target) {
            case "course": {
                sql = "DELETE FROM course WHERE c_id = ?";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, id);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("删除课程成功:" + i + "条记录已删除");
                        out.println("{\"ok\":\"true\",\"msg\":\"删除课程成功:(" + i + "条记录已删除)\"}");
                    } else {
                        out.println("{\"ok\":\"false\",\"msg\":\"删除课程失败\"}");
                    }
                } catch (SQLException e) {
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"删除课程失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }
            case "room": {
                sql = "DELETE FROM classroom WHERE r_id = ?";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, id);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("删除教室成功:" + i + "条记录已删除");
                        out.println("{\"ok\":\"true\",\"msg\":\"删除教室成功:(" + i + "条记录已删除)\"}");
                    } else {
                        out.println("{\"ok\":\"false\",\"msg\":\"删除教室失败\"}");
                    }
                } catch (SQLException e) {
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"删除教室失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }
            case "ts": {
                sql = "DELETE FROM timeslot WHERE ts_id = ?";
                try {
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, id);
                    int i = pstmt.executeUpdate();
                    if (i > 0) {
                        System.out.println("删除时段成功:" + i + "条记录已删除");
                        out.println("{\"ok\":\"true\",\"msg\":\"删除时段成功:(" + i + "条记录已删除)\"}");
                    } else
                        out.println("{\"ok\":\"false\",\"msg\":\"删除时段失败\"}");
                } catch (SQLException e) {
                    out.println("{\"ok\":\"false\"," +
                            "\"msg\":\"删除时段失败:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
                }
                return;
            }
        }//switch
    }
}
