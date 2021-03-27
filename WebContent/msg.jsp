<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  
  <body style="opacity:0.85;  ">
      <%     
          String user = (String)session.getAttribute("user");   
       %>
  </body>
  <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
  <script>
  var t1;
  var msgs;
  var to_sb;
  var from_sb;
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
        	  msgs= data.msgs;
        	  to_sb= data.to_sb;
        	  from_sb= data.from_sb;
        	  document.body.innerHTML="";
              for (var i=0;i< msgs.length;i++){
            	  var t1 = msgs[i];
                  var t2 = to_sb[i];
                  var t3 = from_sb[i];
                  if(t2=="ALL"&&t3=="DreamPsalmChatRoomSystem"){
                	  var oLi = document.createElement("span");                	  
                  	  oLi.innerText="系统消息："+t1;
                  	  oLi.style="display:block;text-align:center;background-color:LightGray";
                      document.body.appendChild(oLi);
                      var br = document.createElement("br");
                      document.body.appendChild(br);
                  }
                  if(t2=="ALL"&&t3!="<%=user%>"&&t3!="DreamPsalmChatRoomSystem"){
                	  var oLi = document.createElement("span");                	  
                  	  oLi.innerText=t3+"："+t1;
                  	  oLi.style="word-wrap:break-word;word-break:break-all;background-color:Azure";
                      document.body.appendChild(oLi);
                      var br = document.createElement("br");
                      document.body.appendChild(br);
                  }
                  if(t2=="<%=user%>"){
                	 var oLi = document.createElement("span");
                	 oLi.innerText=t3+"私聊你："+t1;
                	 oLi.style="word-wrap:break-word;word-break:break-all;background-color:yellow";
                  	 document.body.appendChild(oLi);
                  	var br = document.createElement("br");
                    document.body.appendChild(br);
                  }
                  if(t3=="<%=user%>"){
                	  if(t2=="ALL"){
                		var oLi = document.createElement("span");
                  		oLi.innerText=t3+"："+t1;
                  		oLi.style="word-wrap:break-word;word-break:break-all;float:right;background-color:HoneyDew";
                    	document.body.appendChild(oLi); 
                    	var br = document.createElement("br");
                        document.body.appendChild(br);
                	  }else{
                		  var oLi = document.createElement("span");
                    	  oLi.innerText="你私聊"+t2+"："+t1;
                    	  oLi.style="word-wrap:break-word;word-break:break-all;float:right;background-color:yellow";
                      	  document.body.appendChild(oLi);  
                      	var br = document.createElement("br");
                        document.body.appendChild(br);
                	  }
                  }
              }  
              var h = document.documentElement.scrollHeight || document.body.scrollHeight;
              if (getCookie("auto")=="true")
              {           	  
                  window.scrollTo(h,h);
              }
              
          }
        });
      t1=setInterval("getUserListOnline()",1000);
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

