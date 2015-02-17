package DAO.interfaces;

import java.sql.SQLException;
import java.util.List;

import DAO.transfer.Project;

public interface ProjectDAO {
	public Project getProject(int projectId) throws SQLException;

	public void addProject(Project project) throws SQLException;

	public void updateProject(Project project) throws SQLException;

	public List<Project> getProjectsByCompany(int companyId)
			throws SQLException;

	public List<Project> getProjectsByUser(int projectId) throws SQLException;

	public List<Project> getProjectsByActivity(int activityId)
			throws SQLException;

}
