<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("login.jsp");
    }
%>
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
        <hr>
        <h3>글쓰기</h3>
        <form method="post" action="create.jsp">
            <div class="input-group mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <input type="hidden" name="author" value='<%=username%>'>
            <div class="input-group mb-3">
                <lable for="content" class="form-label">내용</lable>
                <textarea id="content" name="content" rows="5" class="form-control" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">글쓰기</button>
        </form>
        <div>
        </div>
    </div>
</body>
</html>
