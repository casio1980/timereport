package DAO.interfaces;

import java.sql.SQLException;
import java.util.List;

import DAO.transfer.Activity;

public interface ActivityDAO {
	public Activity getActivity(int activityId) throws SQLException;

	public void addActivity(Activity activity) throws SQLException;

	public void updateActivity(Activity activity) throws SQLException;

	public List<Activity> getActivitiesByCompany(int companyId)
			throws SQLException;

	public List<Activity> getActivitiesByProject(int projectId)
			throws SQLException;

	public List<Activity> getActivitiesByUser(int userId) throws SQLException;

}
