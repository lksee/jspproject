<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <h1>회원가입</h1>
    <form action="register" method="POST">
        <label for="username">아이디:</label>
        <input type="text" id="username" name="username" required><br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="회원가입">
    </form>
    <%-- error 파라미터가 1이면 이미 존재하는 회원이라고 안내 --%>
    <% if ("1".equals(request.getParameter("error"))) { %>
        <p style="color: red;">이미 존재하는 회원입니다. 다른 아이디를 입력해주세요.</p>
    <% } %>
    <%-- error 파라미터가 2이면 회원가입 실패라고 알림 --%>
    <% if ("2".equals(request.getParameter("error"))) { %>
        <p style="color: red;">회원가입에 실패했습니다. 다시 시도해주세요.</p>
    <% } %>
</body>
</html>