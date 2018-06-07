<%@ page contentType="text/html; charset=UTF-8"%>
<HTML>
<head>
<title>수강신청 시스템 로그인</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<!-- <BODY>
	<table width="75%" align="center" bgcolor="#FFFF99" border>
		<tr>
			<td><div align="center">Login
	</table>
	<table width="75%" align="center" border>
		<FORM method="post" action="login_verify.jsp">
			<tr>
				<td><div align="center">아이디</div></td>
				<td><div align="center">
						<input type="text" name="userID">
					</div></td>
			</tr>
			<tr>
				<td><div align="center">패스워드</div></td>
				<td><div align="center">
						<input type="password" name="userPassword">
					</div></td>
			</tr>
			<tr>
				<td colspan=2><div align="center">
						<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인"> <INPUT
							TYPE="RESET" VALUE="취소">
					</div></td>
			</tr>
	</table>
	</FORM>
</BODY> -->

<body>
<div class="login-card">
    <h1>Log-in</h1><br>
  <form method="post" action="login_verify.jsp">
    <input type="radio" name="chk_info" class="chkbox" value="student">학생
    <input type="radio" name="chk_info" class = "chkbox" value="professor">교수
    <input type="text" name="userID" placeholder="ID">
    <input type="password" name="userPasswor" placeholder="Password"> 
  	<input type="submit" name="login" class="login login-submit" value="Login"/>
  	<input type="button" name="register" class="login register-submit" value="Register" onclick="location.href='register.jsp' "/>

 
  </form>
</div>
</body>
</HTML>