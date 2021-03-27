<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title>用户列表</title>
  </head>
  <body id="userList" style="opacity:0.8">
  </body>
  <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
  <script>
  var t1;
  var userList;
  $(document).ready(function(){
       t1=setInterval("getUserListOnline()",1000); //每隔5秒判断一次
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
        	  userList= data.userName;
        	  document.body.innerHTML="";
        	  var top = document.createElement("span");
        	  top.innerText="当前在线用户："+userList.length+"位";
        	  top.style="font-size:20px;background-color:Cyan ;display:block";
        	  document.body.appendChild(top);
              for (var i in userList){
            	var oLi = document.createElement("li");
            	oLi.innerText=userList[i];
            	oLi.style="background-color:AliceBlue";
              	document.body.appendChild(oLi);
              }    	
          }
        });
      t1=setInterval("getUserListOnline()",1000);
     }
  </script>
</html>

