package DAO;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import DAO.interfaces.ActivityDAO;
import DAO.interfaces.CompanyDAO;
import DAO.interfaces.DataDAO;
import DAO.interfaces.ProjectDAO;
import DAO.interfaces.UserDAO;

public class MySqlDAOFactory implements AutoCloseable {

	private Connection conn = null;

	public Connection getConnection() {
		//
		if (conn != null)
			return conn;

		try {

			Context context = new InitialContext();
			DataSource ds = (DataSource) context
					.lookup("java:comp/env/jdbc/timereport");
			conn = ds.getConnection();

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	public UserDAO getUserDAO() {
		return new MySqlUserDAO(getConnection());
	}

	public CompanyDAO getCompanyDAO() {
		return new MySqlCompanyDAO(getConnection());
	}

	public ProjectDAO getProjectDAO() {
		return new MySqlProjectDAO(getConnection());
	}

	public ActivityDAO getActivityDAO() {
		return new MySqlActivityDAO(getConnection());
	}

	public DataDAO getDataDAO() {
		return new MySqlDataDAO(getConnection());
	}

	@Override
	public void close() throws Exception {
		conn.close();
	}
}
