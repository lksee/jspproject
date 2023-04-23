<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta keyword="jsp board tutorial">
    <title>게시판</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
	<div class="container">
        <h1>게시판</h1>
        <hr>
        <div class="row">
            <div class="col-md-12">
                <a href="index.jsp" class="btn btn-primary">목록</a>
            </div>
        </div>
        <hr>
		<%
			int id = Integer.parseInt(request.getParameter("id"));
			try {
				Class.forName("org.mariadb.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/board", "board", "playdata");
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM board WHERE id=?");
				pstmt.setInt(1, id);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
		%>
		<h2><%= rs.getString("title") %></h2>
		<p><%= rs.getString("author") %></p>
		<p><%= rs.getString("created_at") %></p>
		<p><%= rs.getString("content") %></p>
		<a href="edit.jsp?id=<%= id %>" class="btn btn-primary">수정</a>
		<%
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</div>
</body>
</html>