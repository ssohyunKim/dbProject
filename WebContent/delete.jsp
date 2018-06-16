<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ include file="top.jsp"%>
<link rel="stylesheet" type="text/css" href="style/table_style.css">
<%
	if (session_id == null)
		response.sendRedirect("login.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head></head>
<title>수강신청 조회</title>

<body>
	<table width="100%" align="center" class="type11" >
<thead>
		<tr class="label">
			<th scope="cols">과목번호</th>
			<th scope="cols">분반</th>
			<th scope="cols">과목명</th>
			<th scope="cols">학점</th>
			<th scope="cols">년도</th>
			<th scope="cols">학기</th>
			<th scope="cols">수업시간</th>
			<th scope="cols">수강 삭제</th>
		</tr>
</thead>
		<%
			Connection myConn = null;
			PreparedStatement pstmt = null;
			//PreparedStatement prof_pstmt = null;
			ResultSet rs = null;
			//ResultSet prof_rs = null;
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(dbdriver);
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "c##db";
			String passwd = "db";
			String userID = session_id;
			//String mode = request.getParameter("chk_info"); /*학생인지 교수인지*/

			String courseID = "";
			int courseNo = 0;
			int courseUnit = 0;
			String courseName = "";
			int courseYear = 0;
			int courseSemester = 0;
			int courseTime = 0;
			String sql = "";
			int totalUnit = 0;
			int totalCourse = 0;

			try {
				myConn = DriverManager.getConnection(dburl, user, passwd);

				if (session_mode.equals("professor")) {
					sql = "select c_id, c_id_no, c_name, c_unit, c_year, c_semester, c_time from teach where p_id=? order by c_id, c_id_no";
				} else {
					sql = "select c_id, c_id_no, c_name, c_unit, c_year, c_semester, c_time from enroll where s_id=? order by c_id, c_id_no";
				}
				pstmt = myConn.prepareStatement(sql);
				pstmt.setString(1, session_id);
				rs = pstmt.executeQuery();

				while (rs.next()) {//수강조회할 과목이 존재할 경우
					courseID = rs.getString("c_id");
					courseNo = rs.getInt("c_id_no");
					courseName = rs.getString("c_name");
					courseUnit = rs.getInt("c_unit");
					courseYear = rs.getInt("c_year");
					courseSemester = rs.getInt("c_semester");
					courseTime = rs.getInt("c_time");
					totalUnit = totalUnit + courseUnit;
					totalCourse++;
		%>
		<tr>

			<td align="center"><%=courseID%></td>
			<td align="center"><%=courseNo%></td>
			<td align="center"><%=courseName%></td>
			<td align="center"><%=courseUnit%></td>
			<td align="center"><%=courseYear%></td>
			<td align="center"><%=courseSemester%></td>
			<td align="center"><%=courseTime%></td>
			<td align="center"><a id="in_b" href="delete_verify.jsp?c_id=<%=courseID%>&c_id_no=<%=courseNo%>">취소</a></td>
		</tr>

		<%
			}
			} catch (SQLException se) {
				System.out.println(se.getMessage());
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException sqle) {
					}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				if (myConn != null)
					try {
						myConn.close();
					} catch (SQLException sqle) {
					}
			}
		%>
	</table>

	<div align="center">
		<p>
			현재까지
			<%=totalCourse%>과목, 총
			<%=totalUnit%>학점 수강신청 했습니다
		</p>
	</div>
</body>
</html>
