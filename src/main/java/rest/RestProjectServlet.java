package rest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MySqlDAOFactory;
import DAO.transfer.Project;
import DAO.transfer.TransferObject;
import DAO.transfer.User;

import com.google.gson.Gson;

@WebServlet(urlPatterns = { "/rest/projects.do" })
public class RestProjectServlet extends RestServlet {
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
				out.write(TransferObject.listToJson(factory.getProjectDAO()
						.getProjectsByCompany(me.getCompanyId())));

			} else { // return by the given id

				final String fmt = "{\"item\": %s, "
						+ "\"lColName\": \"Участники\", \"lColUrl\": \"users.do\", \"lCol\": %s, "
						+ "\"rColName\": \"Задачи\", \"rColUrl\": \"activities.do\", \"rCol\": %s}";

				out.write(String.format(fmt, factory.getProjectDAO()
						.getProject(id).toJson(),
						TransferObject.listToJson(factory.getUserDAO()
								.getUsersByProject(id)), TransferObject
								.listToJson(factory.getActivityDAO()
										.getActivitiesByProject(id))));
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

		String payload = getRequestPayload(request);
		
		Project project = new Gson().fromJson(payload, Project.class);
		project.setCompanyId((int) request.getSession().getAttribute(
				"companyid"));

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			if (project.getId() == 0)
				factory.getProjectDAO().addProject(project);
			else
				factory.getProjectDAO().updateProject(project);

		} catch (Exception e) {
			throw new IOException(e);
		}
		
		createEmptyResponse(response);
	}

	/**
	 * DELETE
	 */
	protected void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// TODO
		
		createEmptyResponse(response);
	}

}
