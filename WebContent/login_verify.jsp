<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>

<html>
<head>
<title></title>
<%
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
%>

<%
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
	//p_stmt = myConn.createStatement();
	mySQL = "select s_id, s_pwd from student where s_id='" + userID + "' and s_pwd='" + userPassword + "'";
	rs = stmt.executeQuery(mySQL);
	if (rs.next()) {
		session.setAttribute("user", userID);
		response.sendRedirect("main.jsp");
	} else { //사용자 정보가 없을 때
%>
<script>
	alert("사용자아이디 혹은 암호가 틀렸습니다"); //메시지 알림 후
	location.href = "login.jsp";
</script>
<%
	}
	stmt.close();
	myConn.close();
%>