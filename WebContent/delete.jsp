<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html>
	<head>
		<title>수강신청 취소</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
<body>
<%@ include file="top.jsp" %>
<%   
	if (session_id == null) 
		response.sendRedirect("login.jsp");
	
	Connection myConn = null;      
	Statement stmt = null;
	CallableStatement cstmt = null;
	String mySQL = "";
	String semesterSQL = "";
	ResultSet myResultSet = null;
	String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user="c##db";     String passwd="db";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String str_course_day = "";
	int presentSemester = 0;
	try {
		Class.forName(dbdriver);
        myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
	} catch(SQLException ex) {
    	System.err.println("SQLException: " + ex.getMessage());
	}
	
	if(!session_mode.equals("student")) {	
%> <!--professor login-->
		<table width="75%" align="center" id="delete_table">
		<br>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
		    <th>강의 삭제</th>
		</tr>
<%	
			mySQL = "select t.c_id, t.c_id_no, c.c_name, teach t, professor p where p.p_id='"+ session_id +"' and t.p_id = p.p_id and c.c_id = t.c_id and t.c_id_no = c.c_id_no";
			try{
				myResultSet = stmt.executeQuery(mySQL);
				if (myResultSet != null) {
					while (myResultSet.next()) {	
						String c_id = myResultSet.getString("c_id");
						int c_id_no = myResultSet.getInt("c_id_no");			
						String c_name = myResultSet.getString("c_name");
						int c_semester = myResultSet.getInt("c_semester");
						
						mySQL = "{? = call getStrDay(?)}";
						cstmt = myConn.prepareCall(mySQL);
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
						
						
						semesterSQL = "{call getNextSemester(?)}";
						cstmt = myConn.prepareCall(semesterSQL);
						cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
						cstmt.execute();
						presentSemester = cstmt.getInt(1);
						
						if (c_semester == presentSemester){
%>
					<tr>
					  <td align="center"><%= c_id %></td>
					  <td align="center"><%= c_id_no %></td>
					  <td align="center"><%= c_name %></td>
					  <td align="center"><a id="in_b" href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">삭제</a></td>
					</tr>
<%
						}
					}
				}
			}catch(SQLException e){
			    out.println(e);
			    e.printStackTrace();
			}
			stmt.close();  
			myConn.close();
	} 
	else {
%>
		<table width="75%" align="center" id="delete_table">
		<br>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>학점</th>
		    <th>수강취소</th>
		</tr>
<%
			
			mySQL = "select e.c_id, e.c_id_no, e.c_semester, c.c_name, c.c_unit, from course c, enroll e, teach t where e.s_id='"+ session_id +"' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and t.c_id = c.c_id and t.c_id_no = c.c_id_no";
			try{
				myResultSet = stmt.executeQuery(mySQL);
				if (myResultSet != null) {
					while (myResultSet.next()) {	
						String c_id = myResultSet.getString("c_id");
						int c_id_no = myResultSet.getInt("c_id_no");
						int c_semester = myResultSet.getInt("c_semester");
						String c_name = myResultSet.getString("c_name");
						int c_unit = myResultSet.getInt("c_unit");

						
						semesterSQL = "{call getNextSemester(?)}";
						cstmt = myConn.prepareCall(semesterSQL);
						cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
						cstmt.execute();
						presentSemester = cstmt.getInt(1);
						
						if(c_semester == presentSemester){
%>				
					<tr>
					  <td align="center"><%= c_id %></td> 
					  <td align="center"><%= c_id_no %></td> 
					  <td align="center"><%= c_name %></td>
					  <td align="center"><%= c_unit %></td>
					  <td align="center"><a id="in_b" href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">취소</a></td>
					</tr>
<%
						}
					}
				}
			}catch(SQLException e){
			    out.println(e);
			    e.printStackTrace();
			}
			stmt.close();  
			myConn.close();
			}
%>
</table></body></html>