package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.interfaces.DataDAO;
import DAO.transfer.Data;

public class MySqlDataDAO implements DataDAO {

	private Connection conn = null;

	public MySqlDataDAO(Connection conn) {
		this.conn = conn;
	}

	private Data fillFromResultSet(ResultSet rs) throws SQLException {
		Data obj = new Data();

		obj.setId(rs.getInt("id"));
		obj.setUserId(rs.getInt("userId"));
		obj.setProjectId(rs.getInt("projectId"));
		obj.setActivityId(rs.getInt("activityId"));
		obj.setDate(rs.getString("dt"));
		obj.setHours(rs.getDouble("hours"));

		return obj;
	}

	@Override
	public List<Data> getUserData(int userId, String dtFrom, String dtTo)
			throws SQLException {

		String sql = "SELECT * FROM data WHERE deleted = 0 AND userId=? AND dt BETWEEN ? AND ? ORDER BY dt";

		List<Data> list = new ArrayList<Data>();
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, userId);
		stm.setString(2, dtFrom);
		stm.setString(3, dtTo);

		ResultSet rs = stm.executeQuery();
		while (rs.next())
			list.add(fillFromResultSet(rs));

		return list;
	}

	@Override
	public void addUserData(int userId, Data data) throws SQLException {
		if (data.getHours() == 0)
			return; // consider empty

		String sql = "INSERT INTO data (projectId, activityId, dt, hours, userId) VALUES (?, ?, ?, ?, ?)";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, data.getProjectId());
		stm.setInt(2, data.getActivityId());
		stm.setString(3, data.getDate());
		stm.setDouble(4, data.getHours());
		stm.setInt(5, userId);

		stm.executeUpdate();
	}

	@Override
	public void updateUserData(int userId, Data data) throws SQLException {

		String sql = "UPDATE data SET projectId = ?, activityId = ?, dt = ?, hours = ?, deleted = ? WHERE id = ? AND userId = ?";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, data.getProjectId());
		stm.setInt(2, data.getActivityId());
		stm.setString(3, data.getDate());
		stm.setDouble(4, data.getHours());
		stm.setBoolean(5, data.getHours() == 0); // consider deleted
		stm.setInt(6, data.getId());
		stm.setInt(7, userId);

		stm.executeUpdate();
	}

	@Override
	public void deleteUserData(int userId, int id) throws SQLException {

		String sql = "UPDATE data SET deleted = 1 WHERE userId = ? AND id = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, userId);
		stm.setInt(2, id);

		stm.executeUpdate();
	}

	@Override
	public void resetDemoData(int companyId) throws SQLException {

		String sql = "CALL createDemoUser(%d)";
		PreparedStatement stm = conn.prepareStatement(String.format(sql,
				companyId));
		stm.executeUpdate();

	}

}
