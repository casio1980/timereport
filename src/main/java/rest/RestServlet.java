package rest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class RestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected String getRequestPayload(HttpServletRequest request) throws IOException {
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while ((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		return buffer.toString();
	}

	protected void createEmptyResponse(HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.write("{}");
		out.flush();
	}
}
