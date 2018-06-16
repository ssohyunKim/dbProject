<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" type="text/css" href="style.css">
<title> 수강신청 입력 </title></head>
<body>

<%
   request.setCharacterEncoding("UTF-8");

   String session_mode=(String)session.getAttribute("chk_info");
   String id=(String)session.getAttribute("user");
   boolean isOkay = true;
   
   if(session_mode.equals("professor")== true){

      String c_name = request.getParameter("c_name");
      if(c_name == null || c_name.equals("")){
         isOkay = false;
      %>
         <script>   
            alert("과목명을 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      String c_unit = request.getParameter("c_unit");
      if(c_unit == null || c_unit.equals("")){
         isOkay = false;
      %>
         <script>   
            alert("이수학점을 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      
      int unit = 0;
      if(!c_unit.equals(""))
         unit = Integer.parseInt(c_unit);
      else 
         unit = 0;

      if(unit == 0){
         isOkay = false;
      %>
         <script>   
            alert("이수학점을 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      
     
	  //수강최대인원
      String c_max = request.getParameter("c_max");
      int max = 0;
      if(!c_max.equals(""))
         max = Integer.parseInt(c_max);
      else 
         max = 0;

      if(max == 0){
         isOkay = false;
      %>
         <script>   
            alert("강의 인원을 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      
      
      //String[] c_day = request.getParameterValues("lec_day");
      String c_time = request.getParameter("c_time");
     
      
      if(c_time == null || c_time.equals("")){
          isOkay = false;
      %>
         <script>   
            alert("시간을 다시 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      int time = 0;
      if(!c_time.equals(""))
         time = Integer.parseInt(c_time);
      else 
         time = 0;


      if(time == 0){
         isOkay = false;
      %>
         <script>   
            alert("시간을 확인해주세요.");
            location.href="insert.jsp";
         </script>
      <%
      }
      
      if (isOkay) {
         Connection myConn = null;    String   result = null;   
         String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
         String user="c##db";   String passwd="db";
         String dbdriver = "oracle.jdbc.driver.OracleDriver";    
         Statement stmt = null, stmt1 = null; ResultSet rs = null, rs1 = null;
         CallableStatement cstmt = null, cstmt1 = null;
   
         PreparedStatement pstmt = null, pstmt1 = null;
         String sql = null;
         Boolean check = false;
   
         int c_id_no = 0;
   
         try{
            Class.forName(dbdriver);
               myConn =  DriverManager.getConnection (dburl, user, passwd);
               stmt = myConn.createStatement();
   
               sql = "select c_id, c_id_no from teach where c_name = '" + c_name+"'";
               rs = stmt.executeQuery(sql);
   
               if(rs != null) {
                  String c_id = null;
                  while(rs.next()){
                     c_id = rs.getString("c_id");
                     check = true;
                     c_id_no = Integer.parseInt(rs.getString("c_id_no"));
                  }
   
                  if(check == false){
                     String cc_id = null; int n_id;
                     stmt1 = myConn.createStatement();
                     sql = "select c_id from teach";
                     rs1 = stmt1.executeQuery(sql);
                     while(rs1.next())
                        c_id = rs1.getString("c_id");
                     cc_id = c_id.substring(1); n_id = Integer.parseInt(cc_id) + 1; out.print(n_id);
                     c_id_no = 0; c_id = "C" + n_id;
                     out.print(c_name + " " +unit + " " +id +" "+ time+" "+max+" " +c_id + " " + c_id_no);
                  }
                  
                  
                 cstmt = myConn.prepareCall("{call InsertLecture(?,?,?,?,?,?,?,?)}");   
                 cstmt.setString(1, c_name);
                 cstmt.setInt(2, unit);
                 cstmt.setString(3, id);
                 cstmt.setString(4, c_id);
               	 cstmt.setInt(5,c_id_no+1);
               	 cstmt.setInt(6, time);
               	 cstmt.setInt(7,max);

               
               try{
                 cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
                 cstmt.execute();
               }catch(SQLException ex){
            	   System.err.println("SQLException:"+ex.getMessage());
               }
                 result = cstmt.getString(8);
                 out.print("\n"+result+"....");
                 %>
                 <script>   
                    alert("<%=result%>");
                    location.href="insert.jsp";
                 </script>
                 <%      
               
               }

         } catch(SQLException ex) {
             System.err.println("SQLException: " + ex.getMessage());
          }finally {
             if (pstmt != null) 
                  try { 
                     pstmt.close();
                     pstmt1.close();
                     cstmt.close();
                     
                  }catch(SQLException ex) { 
                     out.print("error");
                  }
              if(stmt != null){
                 try{
                    stmt.close();
                 }catch(SQLException ex) { 
                     out.print("error");
                  }
              }
              myConn.close();
          }
      }
   }
   else{
      String s_id = (String)session.getAttribute("user");
      String c_id = request.getParameter("c_id");
      int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));

      Connection myConn = null;    String   result = null;   
      String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
      String user="c##db";   String passwd="db";
      String dbdriver = "oracle.jdbc.driver.OracleDriver";    

      try {
         Class.forName(dbdriver);
                myConn =  DriverManager.getConnection (dburl, user, passwd);
       } catch(SQLException ex) {
           System.err.println("SQLException: " + ex.getMessage());
       }
      
      CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}");   
      cstmt.setString(1, s_id);
      cstmt.setString(2, c_id);
      cstmt.setInt(3,c_id_no);
      cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);   
      
      try {
         cstmt.execute();
         result = cstmt.getString(4);
      %>
         <script>
            alert("<%=result%>");
            location.href="insert.jsp";
         </script>
      <%      
      } catch(SQLException ex) {      
          System.err.println("SQLException: " + ex.getMessage());
      }
      finally {
          if (cstmt != null) 
               try { myConn.commit(); cstmt.close();  myConn.close(); }
             catch(SQLException ex) { }
       }
}
%>

</form></body></html>
