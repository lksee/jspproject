package com.playdata.login;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // password 해싱
        String hashedPassword = hashPassword(password);

        if(isAvailableUsername(username)) {
            // 사용자 정보 등록
            int rowsInserted = registerUser(username, hashedPassword);

            if(rowsInserted > 0){
                // 회원가입 성공
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                response.sendRedirect("index.jsp");
            } else {
                // 회원가입 실패
                response.sendRedirect("register.jsp?error=2");
            }
        } else {
            // 사용자 정보가 이미 존재하면 회원가입 실패
            response.sendRedirect("register.jsp?error=1");
        }
    }

    /**
     * 데이터베이스에 사용자 정보 조회
     * @param username
     * @return true: 사용 가능한 사용자 이름, false: 이미 존재하는 사용자 이름
     */
    private boolean isAvailableUsername(String username) {
        // 데이터베이스에 사용자 정보 조회
        String query = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement statement = getConnection().prepareStatement(query);) {
            statement.setString(1, username);

            // 쿼리 실행
            try (ResultSet rs = statement.executeQuery();) {
                if (rs.next()) {
                    // 이미 존재하는 사용자는 사용 불가
                    return false;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return true;
    }

    /**
     * 데이터베이스에 사용자 정보 저장
     * @param username
     * @param hashedPassword
     * @return 0: 회원가입 실패, 1: 회원가입 성공
     */
    private int registerUser(String username, String hashedPassword) {
        // 데이터베이스에 사용자 정보 저장
        // insert 쿼리문 준비
        String query = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (PreparedStatement statement = getConnection().prepareStatement(query);) {
            statement.setString(1, username);
            statement.setString(2, hashedPassword);

            // 쿼리 실행 결과 반환
            return statement.executeUpdate();

        } catch (SQLException ex) {
            // 회원가입 실패
            ex.printStackTrace();
        }

        return 0;
    }

    /**
     * password 해싱
     * @param password
     * @return hashedPassword
     */
    private String hashPassword(String password) {
        String hashedPassword = "";
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            hashedPassword = Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return hashedPassword;
    }

    /**
     * 데이터베이스 Connection 반환
     * @return Connection
     * @throws SQLException
     */
    private Connection getConnection() throws SQLException {
        return (Connection) getServletContext().getAttribute("conn");
    }
}

