package DAO.interfaces;

import java.sql.SQLException;

import DAO.transfer.Company;

public interface CompanyDAO {
	public Company getCompany(int id) throws SQLException;

	public Company createCompany(String name) throws SQLException;
}
