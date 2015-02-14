package DAO.interfaces;

import java.sql.SQLException;
import java.util.List;

import DAO.transfer.Data;

public interface DataDAO {
	public List<Data> getUserData(int userId, String dtFrom, String dtTo)
			throws SQLException;

	public void addUserData(int userId, Data data) throws SQLException;

	public void updateUserData(int userId, Data data) throws SQLException;

	public void deleteUserData(int userId, int id) throws SQLException;

	public void resetDemoData(int companyId) throws SQLException;
}
