package dwz;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


/**
 * Servlet implementation class getUserList
 */
@WebServlet("/getUserList")
public class getUserList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getUserList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		ServletContext application=(ServletContext)request.getSession().getServletContext();
		List<Object> users = (List<Object>) application.getAttribute("users");
		List<Object> msgs = (List<Object>) application.getAttribute("msgs");
        List<Object> to_sb = (List<Object>) application.getAttribute("to_sb");
        List<Object> from_sb = (List<Object>) application.getAttribute("from_sb");
		JSONObject userList = new JSONObject();
	      userList.put("userName", users);
	      userList.put("msgs", msgs);
	      userList.put("to_sb", to_sb);
	      userList.put("from_sb", from_sb);
	      response.getWriter().print(userList);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
