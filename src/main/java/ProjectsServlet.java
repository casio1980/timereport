
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/secure/projects.do" }, initParams = {
		@WebInitParam(name = "init", value = "projects.jsp"),
		@WebInitParam(name = "rest-url", value = "/web/rest/projects.do") })
public class ProjectsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher(getServletConfig()
				.getInitParameter("init"));
		request.setAttribute("url",
				getServletConfig().getInitParameter("rest-url"));
		rd.include(request, response);
	}

}
