<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
  int id = Integer.parseInt(request.getParameter("id"));
  String title = request.getParameter("title");
  String content = request.getParameter("content");
  String author = request.getParameter("author");

  try {
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/board", "board", "playdata");
    PreparedStatement pstmt = conn.prepareStatement("UPDATE board SET title=?, content=?, author=? WHERE id=?");
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);
    pstmt.setInt(4, id);
    pstmt.executeUpdate();
    response.sendRedirect("view.jsp?id=" + id);
  } catch (Exception e) {
    e.printStackTrace();
  }
%>