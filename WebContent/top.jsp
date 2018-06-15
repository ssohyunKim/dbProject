<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<link rel="stylesheet" type="text/css" href="style/top_style.css">
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
	
	//String mode = session_mode;
	
		
	
%>

<nav id="main-menu">
     <ul class="nav-bar">
          <li ><a href="update.jsp"><b><%=home %></b></a></li>
          <li ><a href="insert.jsp">수강신청 입력</a></li>
          <li ><a href="delete.jsp">수강신청 삭제</a></li>
          <li ><a href="select.jsp">수강신청 조회</a></li>
          <li ><a href="#"><b><%=log %></b></a></li>
     
     </ul>
</nav>