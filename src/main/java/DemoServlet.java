
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MySqlDAOFactory;
import DAO.transfer.Company;
import DAO.transfer.User;

@WebServlet(urlPatterns = { "/demo.do" }, initParams = {
		@WebInitParam(name = "success", value = "secure/home.do"),
		@WebInitParam(name = "fail", value = "welcome.jsp") })
public class DemoServlet extends SessionServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			Company company = factory.getCompanyDAO().createCompany(
					"ООО \"Ромашка\"");
			factory.getDataDAO().resetDemoData(company.getId());
			String un = String.format("peter@company%d.ru", company.getId());

			User user = factory.getUserDAO().getUser(un);
			if (user == null || !user.isDemo()) {
				response.sendRedirect(getServletConfig().getInitParameter(
						"fail"));
				return;
			}

			initSession(request, user, company);
			factory.getUserDAO().setUserLastLogin(un);

			response.sendRedirect(getServletConfig()
					.getInitParameter("success"));

		} catch (Exception e) {
			throw new IOException(e);
		}

	}

}
