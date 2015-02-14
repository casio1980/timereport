package rest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MySqlDAOFactory;
import DAO.transfer.TransferObject;
import DAO.transfer.User;

@WebServlet(urlPatterns = { "/rest/activities.do" })
public class RestActivityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * GET
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			id = 0;
		}

		int userId;
		try {
			userId = (int) request.getSession().getAttribute("userid");
		} catch (Exception e) {
			throw new ServletException(e);
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			if (id == 0) { // return a filtered list

				User me = factory.getUserDAO().getUser(userId);
				out.write(TransferObject.listToJson(factory.getActivityDAO()
						.getActivitiesByCompany(me.getCompanyId())));

			} else { // return by the given id

				final String fmt = "{\"item\": %s, "
						+ "\"lColName\": \"Пользователи\", \"lColUrl\": \"users.do\", \"lCol\": %s, "
						+ "\"rColName\": \"Проекты\", \"rColUrl\": \"projects.do\", \"rCol\": %s}";

				out.write(String.format(fmt, factory.getActivityDAO()
						.getActivity(id).toJson(),
						TransferObject.listToJson(factory.getUserDAO()
								.getUsersByActivity(id)), TransferObject
								.listToJson(factory.getProjectDAO()
										.getProjectsByActivity(id))));
			}

		} catch (Exception e) {
			throw new IOException(e);
		}

		out.flush();

	}

	/**
	 * POST
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// TODO

	}

	/**
	 * DELETE
	 */
	protected void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// TODO

	}

}
