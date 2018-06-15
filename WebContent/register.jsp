<%@ page contentType="text/html; charset=UTF-8"%>
<HTML>
<head>
<title>수강신청 시스템 회원가입</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
</head>
<body>
<div class="login-card">
    <h1>Register</h1><br>
  <form method="post" action="register_verify.jsp">
     <input type="radio" name="chk_info" class="chkbox" value="student" checked>학생
    <input type="radio" name="chk_info" class = "chkbox" value="professor">교수
    <input type="text" name="user" placeholder="ID">
    <input type="password" name="pass" placeholder="Password">
    <input type="password" name="confirmPass" placeholder="Password Confirm">
    <input type="text" name="name" placeholder="이름">
    <input type="submit" name="register" class="login register-submit" value="Register">
  </form>
</div>
</body>
</HTML>