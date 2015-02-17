package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.interfaces.ProjectDAO;
import DAO.transfer.Project;

public class MySqlProjectDAO implements ProjectDAO {

	private Connection conn = null;

	public MySqlProjectDAO(Connection conn) {
		this.conn = conn;
	}

	private Project fillFromResultSet(ResultSet rs) throws SQLException {
		Project obj = new Project();

		obj.setId(rs.getInt("id"));
		obj.setCompanyId(rs.getInt("companyId"));
		obj.setName(rs.getString("name"));
		obj.setDescription(rs.getString("description"));

		try {
			obj.setHours(rs.getDouble("hours"));
		} catch (SQLException e) {
			// proceed
		}

		return obj;
	}

	@Override
	public Project getProject(int projectId) throws SQLException {

		String sql = "SELECT * FROM v_projects WHERE id = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, projectId);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		return fillFromResultSet(rs);
	}

	@Override
	public void addProject(Project project) throws SQLException {

		String sql = "INSERT INTO projects (companyId, name, description) VALUES (?, ?, ?)";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, project.getCompanyId());
		stm.setString(2, project.getName());
		stm.setString(3, project.getDescription());

		stm.executeUpdate();
	}

	@Override
	public void updateProject(Project project) throws SQLException {

		String sql = "UPDATE projects SET companyId = ?, name = ?, description = ? WHERE id = ?";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, project.getCompanyId());
		stm.setString(2, project.getName());
		stm.setString(3, project.getDescription());
		stm.setInt(4, project.getId());

		stm.executeUpdate();
	}

	@Override
	public List<Project> getProjectsByCompany(int companyId)
			throws SQLException {

		String sql = "SELECT * FROM v_projects WHERE companyId=? ORDER BY name";

		List<Project> list = new ArrayList<Project>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, companyId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<Project> getProjectsByUser(int userId) throws SQLException {

		String sql = "SELECT * FROM v_project_users_p WHERE userId = ? ORDER BY name";

		List<Project> list = new ArrayList<Project>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, userId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<Project> getProjectsByActivity(int activityId)
			throws SQLException {

		String sql = "SELECT * FROM v_project_activities_p WHERE activityId = ? ORDER BY name";

		List<Project> list = new ArrayList<Project>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, activityId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

}
