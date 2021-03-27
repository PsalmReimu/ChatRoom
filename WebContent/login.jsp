<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>幻梦诗篇聊天室登陆</title>
  </head>
  <body>
      <%
          String msg = (String) request.getAttribute("msg");    	
          if(msg == null){
              msg = "";
          }
          String user = (String) session.getAttribute("user");
          if(user!=null){
        	  response.sendRedirect("main.jsp");
          }
       %>
       <p><%=msg %></p>
       <form action="Dolog" method="post" name="login_form">
           <p align="center" >昵称<input type="text" name="username" maxlength="8"/></p>
           <p align="center"><input type="submit" value="登入"/></p>
       </form>
  </body>
</html>

