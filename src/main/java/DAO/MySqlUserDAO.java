package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import DAO.interfaces.UserDAO;
import DAO.transfer.User;

public class MySqlUserDAO implements UserDAO {

	private Connection conn = null;

	public MySqlUserDAO(Connection conn) {
		this.conn = conn;
	}

	private User fillFromResultSet(ResultSet rs) throws SQLException {
		User obj = new User();

		obj.setId(rs.getInt("id"));
		obj.setCompanyId(rs.getInt("companyId"));
		obj.setFirstName(rs.getString("firstName"));
		obj.setLastName(rs.getString("lastName"));
		obj.setEmail(rs.getString("email"));
		obj.setPassword(rs.getString("password"));
		obj.setActivationHash(rs.getString("activationHash"));
		obj.setDemo(rs.getBoolean("isDemo"));
		obj.setAdmin(rs.getBoolean("isAdmin"));

		try {
			obj.setHours(rs.getDouble("hours"));
		} catch (SQLException e) {
			// proceed
		}

		return obj;
	}

	@Override
	public User getUser(int userId) throws SQLException {

		String sql = "SELECT * FROM v_users WHERE id = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, userId);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		return fillFromResultSet(rs);
	}

	@Override
	public User getUser(String userName) throws SQLException {

		String sql = "SELECT * FROM v_users WHERE email = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setString(1, userName);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		return fillFromResultSet(rs);
	}

	@Override
	public User createUser(int companyId, String firstName, String lastName,
			String email, String password, boolean isAdmin, boolean isDemo)
			throws SQLException {

		String sql = "INSERT INTO users (companyId, firstName, lastName, email, password, activationHash, isAdmin, isDemo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement stm = conn.prepareStatement(sql);

		User user = new User();
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEmail(email);
		user.setPassword(password);
		user.setActivationHash(isDemo ? null : UUID.randomUUID().toString());
		user.setAdmin(isAdmin);
		user.setDemo(isDemo);

		stm.setInt(1, companyId);
		stm.setString(2, user.getFirstName());
		stm.setString(3, user.getLastName());
		stm.setString(4, user.getEmail());
		stm.setString(5, user.getPassword());
		stm.setString(6, user.getActivationHash());
		stm.setBoolean(7, user.isAdmin());
		stm.setBoolean(8, user.isDemo());

		stm.executeUpdate();

		return user;
	}

	@Override
	public User activateUser(String activationHash) throws SQLException {

		String sql = "SELECT * FROM users WHERE activationHash = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setString(1, activationHash);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		User user = fillFromResultSet(rs);
		sql = "UPDATE users SET activationHash = NULL WHERE id = ?";
		stm = conn.prepareStatement(sql);
		stm.setInt(1, user.getId());
		stm.executeUpdate();

		user.setActivationHash(null);
		return user;
	}

	@Override
	public void setUserLastLogin(String userName) throws SQLException {
		String sql = "UPDATE users SET lastLogin = NOW() WHERE email = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setString(1, userName);

		stm.executeUpdate();
	}

	@Override
	public List<User> getUsersByCompany(int companyId) throws SQLException {

		String sql = "SELECT * FROM v_users WHERE companyId=? ORDER BY lastName, firstName";

		List<User> list = new ArrayList<User>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, companyId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<User> getUsersByProject(int projectId) throws SQLException {

		String sql = "SELECT * FROM v_project_users_u WHERE projectId = ? ORDER BY lastName, firstName";

		List<User> list = new ArrayList<User>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, projectId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<User> getUsersByActivity(int activityId) throws SQLException {

		String sql = "SELECT * FROM v_user_activities_u WHERE activityId = ? ORDER BY lastName, firstName";

		List<User> list = new ArrayList<User>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, activityId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

}
