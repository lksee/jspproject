package com.playdata.login;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Base64;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 패스워드 암호화 처리
        String hashedPassword = hashPassword(password);

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 로그인 성공 시 세션에 사용자 정보 저장
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);

                    // 로그인 성공 시 로그인 실패 횟수 초기화
                    resetFailedLoginAttempts(username);

                    // 로그인 성공 시 메인 페이지로 리다이렉트
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                } else {
                    // 로그인 실패 시 실패 횟수 기록
                    recordFailedLoginAttempt(username);

                    // 로그인 실패 시 에러 메시지 출력
                    request.setAttribute("error", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                    rd.forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    /**
     * 패스워드 암호화 처리
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
     * 로그인 실패 횟수 기록
     * @param username
     */
    private void recordFailedLoginAttempt(String username) {
        String sql = "UPDATE users SET login_fail_count = login_fail_count + 1 WHERE username = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 로그인 실패 횟수 초기화
     * @param username
     */
    private void resetFailedLoginAttempts(String username) {
        String sql = "UPDATE users SET login_fail_count = 0 WHERE username = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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