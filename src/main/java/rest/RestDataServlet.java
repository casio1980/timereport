package rest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utilities.CalendarUtility;
import DAO.MySqlDAOFactory;
import DAO.transfer.Data;
import DAO.transfer.Project;
import DAO.transfer.TransferObject;

import com.google.gson.Gson;

@WebServlet(urlPatterns = { "/rest/data.do" })
public class RestDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String jsonFmt = "{\"thisWeek\": %s, \"prevWeek\": %s, \"nextWeek\": %s, \"projects\": %s, \"data\": %s}";
	private static final String jsonThisWeekFmt = "{\"weekNum\": %d, \"current\": %s, \"week\": %s}";
	private static final String jsonPagerFmt = "{\"weekNum\": %d, \"disabled\": %s}";

	/**
	 * GET
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		CalendarUtility cu = new CalendarUtility();

		// Params
		int weekNum;
		try {
			weekNum = Integer.parseInt(request.getParameter("week"));
		} catch (Exception e) {
			weekNum = cu.getCurrentWeekNum();
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		// Weeks
		String jsonThisWeek = String.format(jsonThisWeekFmt, weekNum,
				weekNum == cu.getCurrentWeekNum() ? "true" : "false",
				cu.weekToJson(2015, weekNum)); // TODO 2015
		String jsonPrevWeek = String.format(jsonPagerFmt, weekNum == 1 ? 52
				: weekNum - 1, weekNum == 1 ? "true" : "false");
		String jsonNextWeek = String.format(jsonPagerFmt, weekNum + 1,
				weekNum == cu.getCurrentWeekNum() ? "true" : "false");

		// Projects & Data
		String jsonProj = "";
		String jsonData = "";
		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			// Projects
			List<Project> projects = factory.getProjectDAO().getProjectsByUser(
					(int) request.getSession().getAttribute("userid"));
			
			for (Project project : projects) // fill in activities lists
				project.setActivities(factory.getActivityDAO().getActivitiesByProject(project.getId()));				
			
			jsonProj = TransferObject.listToJson(projects);

			// Data
			jsonData = TransferObject.listToJson(factory.getDataDAO()
					.getUserData(
							(int) request.getSession().getAttribute("userid"),
							cu.dateToString(cu.getDate(2015, weekNum, 0)),
							cu.dateToString(cu.getDate(2015, weekNum, 6))));

		} catch (Exception e) {
			throw new IOException(e);
		}

		// Writing the response
		String json = String.format(jsonFmt, jsonThisWeek, jsonPrevWeek,
				jsonNextWeek, jsonProj, jsonData);

		out.write(json);
		out.flush();

	}

	/**
	 * POST
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String payload = getRequestPayload(request);
		Data[] data = new Gson().fromJson(payload, Data[].class);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			for (Data item : data) {
				if (item.getId() == 0)
					factory.getDataDAO().addUserData(
							(int) request.getSession().getAttribute("userid"),
							item);
				else
					factory.getDataDAO().updateUserData(
							(int) request.getSession().getAttribute("userid"),
							item);
			}

		} catch (Exception e) {
			throw new IOException(e);
		}
	}

	private String getRequestPayload(HttpServletRequest request) throws IOException {
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while ((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		return buffer.toString();
	}

	/**
	 * DELETE
	 */
	protected void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			return;
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try (MySqlDAOFactory factory = new MySqlDAOFactory()) {

			factory.getDataDAO().deleteUserData(
					(int) request.getSession().getAttribute("userid"), id);

		} catch (Exception e) {
			throw new IOException(e);
		}

	}

}
