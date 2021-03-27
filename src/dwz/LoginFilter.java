package dwz;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

	private String excepUrl;
    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse resp = (HttpServletResponse) response;
			String name = (String) req.getSession().getAttribute("user");
			resp.setContentType("text/html;");
			resp.setCharacterEncoding("utf-8");
			String request_uri = req.getRequestURI();
			String ctxPath = req.getContextPath();
			String uri = request_uri.substring(ctxPath.length());
			if (uri.contains("log") ||uri.contains("image.jsp")||(uri.contains("doReg"))||uri.contains(excepUrl)){
				chain.doFilter(request, response);
			} else {
				if (name != null) {
					chain.doFilter(request, response);
				} else {
					resp.sendRedirect("login.jsp");
					return;
				}
			}
		}


	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig cfg) throws ServletException {
		excepUrl = cfg.getInitParameter("excepUrl");
	}

}
