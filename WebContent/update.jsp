<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
<title>Insert title here</title>
<%
request.setCharacterEncoding("utf-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "c##db";
	String passwd = "db";

	Statement stmt = null;
	Statement p_stmt = null;
	String mySQL = null;
	String p_mySQL = null;
	ResultSet rs = null;
	ResultSet p_rs = null;
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	String userName = request.getParameter("userName");
	
%>

</head>
<body>
<%@ include file="top.jsp" %>


<%
	if (session_id == null) { %>
		<script> 
			alert("로그인 후 사용하세요."); 
			location.href="login.jsp";  
		</script>
<%
	} else { 
		try{
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement(); p_stmt = myConn.createStatement(); 
			
			mySQL = "select s_id, s_name from student where s_id='" + session_id + "'";
			rs = stmt.executeQuery(mySQL);
			
			p_mySQL = "select * from professor where p_id='"+session_id+"'";
			p_rs = p_stmt.executeQuery(p_mySQL);

		}catch(SQLException e){
		    out.println(e);
		    e.printStackTrace();
		}finally{
			if(rs != null && p_rs != null){
				if (rs.next()) {
					userID = rs.getString("s_id");
					userName = rs.getString("s_name");
				}
				else if(p_rs.next()){
					userID = p_rs.getString("p_id");
					userName = p_rs.getString("p_name");
				}
				else {
%>
					<script> 
						alert("세션이 종료되었습니다. 다시 로그인 해주세요."); 
						location.href="login.jsp";  
					</script>  
<%
				}
			}	
%>
<div class="login-card">
    <h1>User Info</h1><br>
  <form method="post" action="update_verify.jsp">
     <input type="radio" name="chk_info" class="chkbox" value="student" checked>학생
    <input type="radio" name="chk_info" class = "chkbox" value="professor">교수
    <input type="text" readonly name="user" placeholder="ID" value=<%=userID %>>
    <input type="password" name="pass" placeholder="Password">
    <input type="password" name="confirmPass" placeholder="Password Confirm">
    <input type="text" name="name" placeholder="이름" value=<%=userName %>>
    <input type="submit" name="register" class="login register-submit" value="Register">
  </form>
</div>
<%	
			stmt.close(); p_stmt.close();
			myConn.close();
		}
	}
%>

</body>
</html>