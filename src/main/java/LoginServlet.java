
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utilities.PasswordHash;
import DAO.MySqlDAOFactory;
import DAO.transfer.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet
public class LoginServlet extends SessionServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher(getServletConfig()
				.getInitParameter("init"));
		rd.include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String un = request.getParameter("inputEmail");
		String pwd = request.getParameter("inputPassword");

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			User user = factory.getUserDAO().getUser(un);
			if (user == null) { // user does not exist
				response.sendRedirect(getServletConfig().getInitParameter(
						"fail"));
				return;
			}

			boolean isPwdValid;
			try {
				isPwdValid = PasswordHash.validatePassword(pwd,
						user.getPassword());
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				throw new ServletException(e);
			}

			if (isPwdValid && user.getActivationHash() == null
					&& !user.isDemo()) {

				initSession(request, user,
						factory.getCompanyDAO().getCompany(user.getCompanyId()));
				factory.getUserDAO().setUserLastLogin(un);

				response.sendRedirect(getServletConfig().getInitParameter(
						"success"));
			}

		} catch (Exception e) {
			throw new IOException(e);
		}

	}

}
