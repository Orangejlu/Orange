package cn.edu.jlu.orange.servlet;

import cn.edu.jlu.orange.JDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by lin on 2015-12-19-019.
 */
@WebServlet(name = "GetNoticeByIdServlet",value = "/getnoticecontent.do")
public class GetNoticeByIdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String logined = (String) request.getSession().getAttribute("logined");
        Integer type = (Integer) request.getSession().getAttribute("type");
        if (logined == null || type == null) {
            return;
        }
        String id = request.getParameter("noticeid");
        if (id==null)return;
        //System.out.println("参数为"+id);
        String content = JDBCUtil.getNoticeById(id);
        content = content.replace("\n","<br>");
        if (!content.substring(content.indexOf("<!--"), content.indexOf("-->"))
                .contains(type.toString())
                && !type.toString().trim().equals("0")) {
            return;
        }
        response.getWriter().print(content);
    }
}
