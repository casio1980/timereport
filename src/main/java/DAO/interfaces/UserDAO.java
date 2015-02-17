package DAO.interfaces;

import java.sql.SQLException;
import java.util.List;

import DAO.transfer.User;

public interface UserDAO {
	public User getUser(int userId) throws SQLException;

	public User getUser(String userName) throws SQLException;

	public void addUser(User user) throws SQLException;

	public void updateUser(User user) throws SQLException;

	public User registerUser(int companyId, String firstName, String lastName,
			String email, String password, boolean isAdmin, boolean isDemo)
			throws SQLException;

	public User activateUser(String activationHash) throws SQLException;

	public void setUserLastLogin(String userName) throws SQLException;

	public List<User> getUsersByCompany(int companyId) throws SQLException;

	public List<User> getUsersByProject(int projectId) throws SQLException;

	public List<User> getUsersByActivity(int activityId) throws SQLException;

}
