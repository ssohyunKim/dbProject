<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<link rel="stylesheet" type="text/css" href="top_style.css">
<%
	String session_id = (String) session.getAttribute("user");
	String session_name = (String) session.getAttribute("user_name");
	String session_mode=(String)session.getAttribute("chk_info");
	String log;
	if (session_id == null)
		log = "<a href=login.jsp>로그인</a>";
		
	else
		log = "<a href=logout.jsp>로그아웃</a>";
		
	String home;
	if(session_id == null)
		home = "HOME";
	else
		home = session_id;
		
	
%>
<%-- <table width="75%" align="center" bgcolor="#FFFF99" border>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a href="update.jsp">사용자정보 수정</b></td>
		<td align="center"><b><a href="insert.jsp">수강신청 입력</b></td>
		<td align="center"><b><a href="delete.jsp">수강신청 삭제</b></td>
		<td align="center"><b><a href="select.jsp">수강신청 조회</b></td>
	</tr>
</table> --%>

<!-- <style>
 nav {
  font-family: Open Sans, sans-serif;
  font-size: 20px;
  font-weight: 300;
  margin: 50px auto;
  width: 700px;
  height: 40px;
  /*   border: 1px dotted silver; */
}

/* list styles */

ul {
  width: 700px;
  margin: 0px auto;
  /*   overflow: auto; */
  list-style: none;
}

li {
  float: left;
  /*   display: inline; */
  padding-right: 20px;
  padding-left: 20px;
  border-right: 1px dotted #999;
}

li:last-child {
  border: none;
}

li a {
  text-decoration: none;
  color: #888;
}

li a:hover {
  color: #333;
  border-bottom: 2px solid red;
}

li.active a {
  color: red;
  font-weight: normal;
  border-bottom: none;
}
</style> -->

<nav id="main-menu">
     <ul class="nav-bar">
          <li ><a href="update.jsp"><b><%=home %></b></a></li>
          <li ><a href="insert.jsp">수강신청 입력</a></li>
          <li ><a href="delete.jsp">수강신청 삭제</a></li>
          <li ><a href="select.jsp">수강신청 조회</a></li>
          <li ><a href="#"><b><%=log %></b></a></li>
     
     </ul>
</nav>