import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.transfer.Company;
import DAO.transfer.User;

public abstract class SessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void initSession(HttpServletRequest request, User user,
			Company company) {
		
		HttpSession session = request.getSession(true);
		session.setAttribute("userid", user.getId());
		session.setAttribute("username", user.getName());
		session.setAttribute("companyid", company.getId());
		session.setAttribute("companyname", company.getName());
	}
}
