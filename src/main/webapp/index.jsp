<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
    rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
    crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h2>게시판</h2>
        <%-- 세션에 username이 있으면 로그인 상태로 간주 --%>
        <%
            String username = (String) session.getAttribute("username");
            if (username != null) {
        %>
        <p><%= username %>님, 환영합니다.</p>
        <p><a href="logout">로그아웃</a></p>

        <%-- 세션에 username이 없으면 로그인되지 않은 상태 --%>
        <% } else { %>
        <p><a href="login.jsp">로그인</a></p>
        <p><a href="register.jsp">회원가입</a></p>
        <% } %>
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
            <%
                Connection conn = (Connection) request.getServletContext().getAttribute("conn");
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM board ORDER BY id DESC")) {
                    while(rs.next()) {
            %>
                <tr>
                    <td><%=rs.getInt("id")%></td>
                    <td><a href="view.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
                    <td><%= rs.getString("author")%></td>
                    <td><%= rs.getString("created_at")%></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>
        <%
            if (username != null) {
        %>
        <div>
            <a href="write.jsp" class="btn btn-primary">글쓰기</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
