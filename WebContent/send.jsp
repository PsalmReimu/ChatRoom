<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  <style>
  input:focus{
    border-color: #66afe9;
    outline: 0;
    -webkit-box-shadow: inset 0 3px 3px rgba(0,0,0,.075),0 0 10px rgba(102,175,233,.6);
    box-shadow: inset 0 3px 3px rgba(0,0,0,.075),0 0 10px rgba(102,175,233,.6)
}
  </style>
  <body style="background-color:AliceBlue ">
      <form action="" method="post">
          <p align="right">
          <%=session.getAttribute("user") %>：
                  发送消息给：
          <select id="Select" name="select" >
              <option value="0">所有人</option>
              
          </select>         
          <input type="text" name="message" size="60" maxlength="100" placeholder="请输入..."/>
          <input type="submit" value="发送"/>
          <br><br>
          <label> <span>自动滚动</span> <input type="checkbox"
					id="auto" value="auto" style="height: 15px" onclick="check(this)"></label>         
          <input type="button" value="退出登录" onClick="parent.location.href='loginOff.jsp'">         
      </form>
      
      <%
          String user = (String) session.getAttribute("user");
          request.setCharacterEncoding("utf-8");
          String message = request.getParameter("message");          
          String to="";
          try{
              //被发送信息方
              List<Object> tmp = (List<Object>) application.getAttribute("users");
              String SS = request.getParameter("select");
              int a = Integer.parseInt(SS);
              if(a==0){
                  to="ALL";                 
              }
              else{
                  to=(String)tmp.get(a-1);                  
              }              
          }catch(Exception e){}
          
          List<Object> msgs = (List<Object>) application.getAttribute("msgs");
          if(msgs == null){
              msgs = new ArrayList<Object>();
          }
          List<Object> to_sb = (List<Object>) application.getAttribute("to_sb");
          if(to_sb == null){
              to_sb = new ArrayList<Object>();
          }
          List<Object> from_sb = (List<Object>) application.getAttribute("from_sb");
          if(from_sb == null){
              from_sb = new ArrayList<Object>();
          }
          
          if(message != null && !message.equals("")){
              msgs.add(message);
              to_sb.add(to);
              from_sb.add(user);              
              application.setAttribute("msgs", msgs);
              application.setAttribute("to_sb", to_sb);
              application.setAttribute("from_sb", from_sb);
          }
       %>
  </body>
  <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
  <script>
  var t1;
  var userList;
  $(document).ready(function(){
       t1=setInterval("getUserListOnline()",1000); //每隔5秒判断一次
       if(getCookie("auto")=="true"){
     	  document.getElementById("auto").checked=true;
       }
     }
  );   
  function getUserListOnline(){
      clearInterval(t1);
        $.ajax({
          type : "GET",
          url : "getUserList",
          cache: false,
          dataType: 'json',
         async: true,
         timeout:1000,
          success : function(data){
        	  var obj=document.getElementById('Select');
        	  var selectedName = $("#Select").find("option:selected").text();
        	  obj.options.length=0;
        	  userList= data.userName; 
        	  obj.options.add(new Option("所有人",0));
              for (var i=0;i< userList.length;i++){
            	  if("<%=user%>"!=userList[i]){
            		 obj.options.add(new Option(userList[i],i+1));  
            	  }         	         	           	  
              }  
              for(i=0;i<obj.length;i++){
            	  if(obj.options[i].text==selectedName){
            		  obj.options[i].selected = true;
            	  } 
              }             
          }
        });
      t1=setInterval("getUserListOnline()",1000);
     }
  function check(checkbox)
  {
	  if(checkbox.checked==true)
	  {
		  document.cookie="auto=true";
	  }
	  else
	  {
		  document.cookie="auto=false";
	  }
  }
  function getCookie(cname)
  {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) 
    {
      var c = ca[i].trim();
      if (c.indexOf(name)==0) return c.substring(name.length,c.length);
    }
    return "";
  }
  </script>
</html>

