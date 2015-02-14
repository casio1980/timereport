package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DAO.interfaces.CompanyDAO;
import DAO.transfer.Company;

public class MySqlCompanyDAO implements CompanyDAO {

	private Connection conn = null;

	public MySqlCompanyDAO(Connection conn) {
		this.conn = conn;
	}

	private Company fillCompanyFromResultSet(ResultSet rs) throws SQLException {
		Company cmp = new Company();

		cmp.setId(rs.getInt("id"));
		cmp.setName(rs.getString("name"));

		return cmp;
	}

	@Override
	public Company getCompany(int id) throws SQLException {

		String sql = "SELECT * FROM companies WHERE id = ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, id);

		ResultSet rs = stm.executeQuery();
		if (!rs.next())
			return null;

		return fillCompanyFromResultSet(rs);
	}

	@Override
	public Company createCompany(String name) throws SQLException {

		String sql = "INSERT INTO companies (name) VALUES (?)";
		PreparedStatement stm = conn.prepareStatement(sql,
				Statement.RETURN_GENERATED_KEYS);
		stm.setString(1, name);

		stm.executeUpdate();

		Company com = new Company();
		com.setName(name);

		try (ResultSet generatedKeys = stm.getGeneratedKeys()) {
			if (generatedKeys.next())
				com.setId(generatedKeys.getInt(1));
			else
				throw new SQLException();
		}

		return com;
	}

}
