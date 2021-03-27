<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>   
    <title>My JSP 'loginOff.jsp' starting page</title>

  </head>
  
  <body>
      <%
          //从application作用域中读取用户列表
          List<Object> users = (List<Object>)application.getAttribute("users");
          String username = (String) session.getAttribute("user");
          //从该用户列表中移除该用户
          users.remove(username);
          application.setAttribute("users",users);
          //注销该用户的会话
          session.invalidate();
       %>
       <jsp:forward page="login.jsp"/>
  </body>
</html>

