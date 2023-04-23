<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    if (request.getParameter("author") == null || request.getParameter("author").equals("")) {
        response.sendRedirect("index.jsp");
        return;
    } else {
        String requestValue = (String) request.getParameter("author");
        String sessionValue = (String) session.getAttribute("username");

        if(!requestValue.equals(sessionValue)) {
            response.sendRedirect("index.jsp");
            return;
        }
    }

    String sql = "insert into board (title, content, author) values (?, ?, ?)";
    Connection conn = (Connection) request.getServletContext().getAttribute("conn");
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, request.getParameter("title"));
        stmt.setString(2, request.getParameter("content"));
        stmt.setString(3, request.getParameter("author"));
        int resultCnt = stmt.executeUpdate();
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>