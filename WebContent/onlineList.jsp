<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@page import="java.util.List,java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/ListEdit.js"></script>
<link rel="stylesheet" type="text/css" href="css/ListEdit.css" />
<br>
<br>
<h2>当前在线用户：</h2>
<br>
<table>
<%
	Map<String, HttpSession> onlineUserMap = (Map) application.getAttribute("onlineUserMap"); 
    if(onlineUserMap!=null){
    for (Map.Entry<String, HttpSession> entry : onlineUserMap.entrySet()) {   
%>
    <tr>
        <td>用户名：<%=entry.getKey()%>，SessionId：<%= entry.getValue().getId()%></td>
    </tr>
<%
}}%>
</table>
</body>
</html>
