package dwz;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dwz.OnlineUserBindingListener;

/**
 * Servlet implementation class Dolog
 */
@WebServlet("/Dolog")
public class Dolog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dolog() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		ServletContext application=(ServletContext)request.getSession().getServletContext();				
		String name = request.getParameter("username");
		synchronized (this) {
			Map<String, HttpSession> onlineUserMap = (Map) application.getAttribute("onlineUserMap"); 
		    if(onlineUserMap!=null){
		    for (Map.Entry<String, HttpSession> entry : onlineUserMap.entrySet()) {
		    	if(entry.getKey().equals(name)||name==null||name.equals("")) {
		    		request.setAttribute("msg", "该昵称非法或已被占用，请重新登入");
		    		request.getRequestDispatcher("login.jsp").forward(request,response);
		    		return;
		    		}
		    	}		    
		    }
			request.getSession().setAttribute("user", name);
			request.getSession().setMaxInactiveInterval(600);
			request.getSession().setAttribute("onlineUserBindingListener", new OnlineUserBindingListener(name));
			response.sendRedirect("main.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
