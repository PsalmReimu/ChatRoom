package dwz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/**
 * Application Lifecycle Listener implementation class OnlineUserBindingListener
 *
 */
@WebListener
public class OnlineUserBindingListener implements HttpSessionBindingListener {
	String username;
	/**
	 * Default constructor.
	 */
	public OnlineUserBindingListener() {

	}

	public OnlineUserBindingListener(String username) {
		this.username = username;
	}

	/**
	 * @see HttpSessionBindingListener#valueBound(HttpSessionBindingEvent)
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		Map<String, HttpSession> onlineUserMap = (Map) application.getAttribute("onlineUserMap");
		List<Object> users = (List<Object>) application.getAttribute("users");
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
		synchronized(this){
		if (onlineUserMap == null) {
			onlineUserMap = new HashMap<String, HttpSession>();
			application.setAttribute("onlineUserMap", onlineUserMap);
		}
		for (Map.Entry<String, HttpSession> entry : onlineUserMap.entrySet()) {
			if (entry.getKey().equals(username)) {
				System.out.println("重复登录！："+username);
				try {
				entry.getValue().removeAttribute("uname");				
				entry.getValue().invalidate();
				}catch(Exception e) {
					System.out.println("数据清除失败！");
				}
			}			
		}
		onlineUserMap.put(username, session);		     
        if(users == null){
            users = new ArrayList<Object>();         
        	}
		}
		users.add(username);
        application.setAttribute("users", users);
        msgs.add(username+"已登录！");
        to_sb.add("ALL");
        from_sb.add("DreamPsalmChatRoomSystem");              
        application.setAttribute("msgs", msgs);
        application.setAttribute("to_sb", to_sb);
        application.setAttribute("from_sb", from_sb);
	}

	/**
	 * @see HttpSessionBindingListener#valueUnbound(HttpSessionBindingEvent)
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		synchronized(this){
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		Map<String, HttpSession> onlineUserMap = (Map) application.getAttribute("onlineUserMap");
		onlineUserMap.remove(username);
		List<Object> users = (List<Object>)application.getAttribute("users");
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
        //从该用户列表中移除该用户
        users.remove(username);
        application.setAttribute("users",users);
        msgs.add(username+"已下线！");
        to_sb.add("ALL");
        from_sb.add("DreamPsalmChatRoomSystem"); 
        application.setAttribute("msgs", msgs);
        application.setAttribute("to_sb", to_sb);
        application.setAttribute("from_sb", from_sb);
		}		
	}

}
