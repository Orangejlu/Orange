package cn.edu.jlu.orange.servlet.admin2;

import cn.edu.jlu.orange.JDBCUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

/**
 * Created by lin on 2016-02-12-012.
 */
@WebServlet(name = "StudentFileUploadServlet", value = "/admin2/studentFileUpload.do")
public class StudentFileUploadServlet extends HttpServlet {
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

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(1024 * 100);//设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
        factory.setRepository(new File(getServletContext().getRealPath("/WEB-INF/temp")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setProgressListener(
                (pBytesRead, pContentLength, arg3)
                        -> System.out.println("文件大小为：" + pContentLength
                        + ",当前已处理：" + pBytesRead + " arg3=" + arg3)
        );
        upload.setHeaderEncoding("UTF-8");
        if (!ServletFileUpload.isMultipartContent(request)) {
            //按照传统方式获取数据
            out.println("{\"ok\":\"false\",\"msg\":\"上传方式非法\"}");
            System.out.println("不是文件表单");
            return;
        }
        String fullName = null;
        try {
            List<FileItem> list = upload.parseRequest(request);
            for (FileItem item : list) {
                if (!item.isFormField()) {//不是普通表单域，是文件
                    String filename = item.getName();
                    System.out.println(filename);
                    if (filename == null || filename.trim().equals("")) {
                        continue;
                    }
                    filename = filename.substring(filename.lastIndexOf("\\") + 1);
                    String fileExtName = filename.substring(filename.lastIndexOf(".") + 1);
                    if (!fileExtName.toLowerCase().equals("csv")) {
//                        message = "不支持的文件类型！";
//                        request.getSession().setAttribute("message", message);
                        System.out.println("不支持的文件类型(上传学生名单)");
                        continue;
                    }

                    InputStream in = item.getInputStream();
                    File savaDir = new File(getServletContext().getRealPath("/WEB-INF/upload/stu/"));
                    if (!savaDir.exists()) {
                        savaDir.mkdirs();
                    }
                    fullName = savaDir.getAbsolutePath() + File.separator + filename;
                    FileOutputStream fout = new FileOutputStream(fullName);

                    byte buffer[] = new byte[1024];
                    int len;
                    while ((len = in.read(buffer)) > 0) {
                        fout.write(buffer, 0, len);
                    }
                    in.close();
                    fout.close();
                }//文件域
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        String msg = "";
        if (fullName != null) {
            System.out.println("上传路径=" + fullName);
            try {
                JSONArray array = new JSONArray();
                Reader in = new FileReader(fullName);
                Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(in);
                for (CSVRecord record : records) {
                    JSONObject item = new JSONObject();
                    item.put("no", record.get("教学号"));
                    item.put("no2", record.get("学号"));
                    item.put("name", record.get("姓名"));
                    item.put("gender", record.get("性别"));
                    item.put("grade", record.get("年级"));
                    array.add(item);
                    //System.out.println(item.toJSONString());
                }
                //System.out.println(array.toString());
                in.close();
                session.setAttribute("stu-file-name", fullName);
                out.println("{\"ok\":\"true\",\"msg\":" + array.toJSONString() + "}");
                return;
            } catch (FileNotFoundException e) {
                msg = "找不到文件:" + e.getMessage();
            } catch (IOException e) {
                msg = "IOException:" + e.getMessage();
            } catch (IllegalArgumentException e) {
                msg = "文件内容格式不正确,请参考示例文件:" + e.getMessage();
            } catch (Exception e) {
                msg = "发生了异常:" + e.getMessage();
                e.printStackTrace();
            }
        } else {
            msg = "文件上传失败啊";
        }
        out.println("{\"ok\":\"false\",\"msg\":\"" + msg + "\"}");
        System.out.println(msg);
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
        String filename = (String) session.getAttribute("stu-file-name");
        Connection con = JDBCUtil.getConnection();
        String sql = "INSERT INTO student(s_id,s_id2,s_name,s_gender,s_passwd,d_name,s_grade) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement pstmt;
        int i = 0;
        try {
            Reader in = new FileReader(filename);
            Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(in);
            pstmt = con.prepareStatement(sql);
            for (CSVRecord record : records) {
                pstmt.setString(1, record.get("教学号"));
                pstmt.setString(2, record.get("学号"));
                pstmt.setString(3, record.get("姓名"));
                String gender = record.get("性别");
                switch (gender) {
                    case "M":
                    case "male":
                    case "男":
                        gender = "M";
                        break;
                    case "F":
                    case "female":
                    case "女":
                        gender = "F";
                        break;
                }
                pstmt.setString(4, gender);
                pstmt.setString(5, JDBCUtil.MD5("Orange" + record.get("教学号") + record.get("教学号")));
                pstmt.setString(6, (String) request.getSession().getAttribute("d_name"));
                pstmt.setString(7, record.get("年级"));
                i += pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"ok\":\"false\",\"msg\":\"出错了:" + JDBCUtil.jsonReplace(e.getMessage()) + "\"}");
            return;
        }
        out.println("{\"ok\":\"true\",\"msg\":\"插入了" + i + "条记录\"}");
        System.out.println("学生名单上传-插入了" + i + "条记录");
    }
}
