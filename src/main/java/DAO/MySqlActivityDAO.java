package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import DAO.interfaces.ActivityDAO;
import DAO.transfer.Activity;

public class MySqlActivityDAO implements ActivityDAO {

	private Connection conn = null;

	public MySqlActivityDAO(Connection conn) {
		this.conn = conn;
	}

	private Activity fillFromResultSet(ResultSet rs) throws SQLException {
		Activity obj = new Activity();

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
	public Activity getActivity(int activityId) throws SQLException {

		String sql = "SELECT * FROM v_activities WHERE id = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, activityId);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		return fillFromResultSet(rs);
	}
	
	@Override
	public void addActivity(Activity activity) throws SQLException {
		
		String sql = "INSERT INTO activities (companyId, name, description) VALUES (?, ?, ?)";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, activity.getCompanyId());
		stm.setString(2, activity.getName());
		stm.setString(3, activity.getDescription());
		
		stm.executeUpdate();
	}

	@Override
	public void updateActivity(Activity activity) throws SQLException {

		String sql = "UPDATE activities SET companyId = ?, name = ?, description = ? WHERE id = ?";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, activity.getCompanyId());
		stm.setString(2, activity.getName());
		stm.setString(3, activity.getDescription());		
		stm.setInt(4, activity.getId());

		stm.executeUpdate();
	}	

	@Override
	public List<Activity> getActivitiesByCompany(int companyId)
			throws SQLException {

		String sql = "SELECT * FROM v_activities WHERE companyId=? ORDER BY name";

		List<Activity> list = new ArrayList<Activity>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, companyId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<Activity> getActivitiesByProject(int projectId)
			throws SQLException {

		String sql = "SELECT * FROM v_project_activities_a WHERE projectId = ? ORDER BY name";

		List<Activity> list = new ArrayList<Activity>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, projectId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public List<Activity> getActivitiesByUser(int userId) throws SQLException {

		String sql = "SELECT * FROM v_user_activities_a WHERE userId = ? ORDER BY name";

		List<Activity> list = new ArrayList<Activity>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, userId);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

}
