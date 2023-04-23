package com.playdata.util;

import javax.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    public static Connection getConnection(ServletContext context) throws SQLException {
        // DB 접속 정보, web.xml context-param으로 설정된 값을 가져왔습니다.
        String url = context.getInitParameter("DB_URL");
        String user = context.getInitParameter("DB_USER");
        String password = context.getInitParameter("DB_PASSWORD");

        // JDBC Driver 로딩
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return DriverManager.getConnection(url, user, password);
    }
}
