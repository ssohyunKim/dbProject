<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" type="text/css" href="style/table_style.css">
      <title>수강신청입력</title>
   </head>
<body>
<%@ include file="top.jsp" %>
<%    
   request.setCharacterEncoding("UTF-8");
   Connection myConn = null;      Statement stmt = null;
   ResultSet myResultSet = null;   String mySQL = "";
   CallableStatement cstmt = null;
   String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
   String user="c##db";        String passwd="db";
   String dbdriver = "oracle.jdbc.driver.OracleDriver";


   if(session_id==null) response.sendRedirect("login.jsp");  
   if(session_mode.equals("student")== true){
%> 
   
      <table  width="1000" align="center" class="type11">
      <br>
      <tr>
         <th>과목번호</th>
         <th>분반</th>
         <th>과목명</th>
         <th>학기</th>
         <th>학점</th>
         <th>수업시간</th>
         <th>담당교수</th>
          <th>수강신청</th>
      </tr>
<%

         try {
            Class.forName(dbdriver);
             myConn =  DriverManager.getConnection (dburl, user, passwd);
             stmt = myConn.createStatement();

          } catch(SQLException ex) {
              System.err.println("SQLException: " + ex.getMessage());
          }
         mySQL = "SELECT t.c_id, t.c_id_no, t.c_name, t.c_unit, t.c_year, t.c_semester, t.c_time, p.p_name FROM teach t, professor p WHERE p.p_id=t.p_id order by t.c_id, t.c_id_no";
         try{
            myResultSet = stmt.executeQuery(mySQL);

            if (myResultSet != null) {
               while (myResultSet.next()) {   
                  String c_id = myResultSet.getString("c_id");//과목번호
                  int c_id_no = myResultSet.getInt("c_id_no");//분반   
                  String c_name = myResultSet.getString("c_name");//과목명
                  int c_unit = myResultSet.getInt("c_unit");//학점
                  int c_year = myResultSet.getInt("c_year");//년도
                  int c_semester = myResultSet.getInt("c_semester");//학기
                  String p_name = myResultSet.getString("p_name");//담당교수
                  int c_time = myResultSet.getInt("c_time");//수업시간
%>
               <tr>
                 <td align="center"><%= c_id %></td> 
                 <td align="center"><%= c_id_no %></td>
                 <td align="center"><%= c_name %></td>
                 <td align="center"><%= c_year %>-<%= c_semester%></td> 
                 <td align="center"><%= c_unit %></td>
                 <td align="center"><%= c_time%></td>
                 <td align="center"><%= p_name %></td>
                 <td align="center"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">신청</a></td>
               </tr>
<%               
               //session.setAttribute("c_id", c_id);
               //session.setAttribute("c_id_no",Integer.toString(c_id_no));
               }
            %>
            </table>
            <%   
            }
         }catch(SQLException e){
             out.println(e);
             e.printStackTrace();
         }
         
         stmt.close();  
         myConn.close();
   }else{
%> 
      <!-- professor login 시 -->      
      <table border="1" width="800" align="center" class="type11">
      <tr><th style="padding-top: 1%; padding-bottom: 1%;">과목명</th>
            <th>분반</th>
            <th>학점</th>
            <th>학기</th>
            <th>수업 시간</th>
            <th>인원</th>
             <th>강의 추가</th>
         </tr>
         <tr></tr><tr></tr><tr></tr>
         <tr></tr><tr></tr><tr></tr>
         <tr>   </tr>
         <form action="insert_verify.jsp?id=<%=session_id%>" method="post">
            <td align="center"><input type="text" name="c_name" id="in" value="수업명"></td>
            <td align="center"><input type="text" name="c_id_no" id="in" value="001"></td>
            <td align="center"><input type="text" name="c_unit" id="in" value="3"></td>
            <td align="center"><input type="text" name="c_semester" style="width:70px;" id="in" value="1"></td>
            <td align="center"><input type="text" name="c_time"  id="in" value="1"></td>
            <td align="center"><input type="text" name="c_max" style="width:65px;" id="in"></td>
            <td align="center"><input type="submit" value="추가" id="in_b" style="font-family: ppi;" value="1"></td>
         </form>
         </tr>
         </table>

<%
      
   }
   //session.setAttribute("user", userID);
   //session.setAttribute("chk_info",session_mode);
         
%>
</body></html>
