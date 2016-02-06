package cn.edu.jlu.orange;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Properties;

public class JDBCUtil {
    static String driver = "oracle.jdbc.driver.OracleDriver";
    static String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
    static String user = "ouser";
    static String pass = "Ozszs233";
    static Connection con = null;

    static {
        try {
//            FileInputStream in = new FileInputStream(new File(""));
            InputStream in = JDBCUtil.class.getClassLoader().getResourceAsStream("cn/edu/jlu/orange/config.properties");
            Properties config = new Properties();
            config.load(in);
            driver = config.getProperty("driver");
            url = config.getProperty("url");
            user = config.getProperty("user");
            pass = config.getProperty("pass");
            System.out.println("读取配置文件完成");
        } catch (Exception e) {
            System.out.println("读取配置文件出错,将使用默认配置");
            e.printStackTrace();
            driver = "oracle.jdbc.driver.OracleDriver";
            url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
            user = "ouser";
            pass = "Ozszs233";
        }
    }

    public static Connection getConnection() {
        if (con != null) return con;
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("已获取数据库连接");
        } catch (Exception e) {
            System.out.println("连接到数据库时出现异常");
        }
        return con;
    }

    public static void closeConnection() {
        if (con == null) return;
        try {
            con.close();
            con = null;
        } catch (SQLException e) {
            System.out.println("关闭数据库连接时出现异常");
        }
    }

    /**
     * java MD5加密
     * http://zhidao.baidu.com/questions/181935414.html
     *
     * @date 2015-12-17
     */
    public static String MD5(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte b[] = md.digest();
            int i;
            StringBuffer sb = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0) i += 256;
                if (i < 16) sb.append("0");
                sb.append(Integer.toHexString(i));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String NOTICE_TYPE = "type";
    public static int NOTICE_LIMIT = 10;

    public static ResultSet getAllNotice() {
        Connection con = JDBCUtil.getConnection();
        //id,title,content,pubtime,type
        String sql = "SELECT * FROM notice ORDER BY pubtime DESC";
        try {
            Statement stmt = con.createStatement();
            return stmt.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("获取公告失败");
        }
        return null;
    }

    public static String getNoticeById(String id) {
        String notice = "<!--0-->获取公告内容失败";
        Connection con = JDBCUtil.getConnection();
        try {
            String sql = "SELECT content,type FROM notice WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            //java.sql.SQLException: 索引中丢失  IN 或 OUT 参数:: 1
            //http://blog.csdn.net/zjx2388/article/details/2077894
            //没有setInt或者用的是setString不匹配
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            //java.sql.SQLException: 未调用 ResultSet.next
            while (rs.next()) {
                notice = "<!--" + rs.getString("type") + "-->" + rs.getString("content");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("获取公告内容失败");
        }
        return notice;
    }

    public static String jsonReplace(String str) {
        return str.replace("\"", "\\\"").replace(":", "_").replace("\n", ".");
    }

    public static void main(String[] argv) {
        System.out.println(JDBCUtil.MD5("Orangeorangeorange"));
    }

    //JSP 获取真实IP地址的代码
    //http://www.jb51.net/article/21272.htm
    public static String getIp(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}