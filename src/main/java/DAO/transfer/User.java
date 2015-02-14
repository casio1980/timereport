package DAO.transfer;

import java.util.Date;

public class User extends TransferObject {

	private int id;
	private int companyId;
	private String firstName;
	private String lastName;
	private String name;
	private String email;
	private String password;
	private Date lastLogin;
	private String activationHash;
	private boolean isDemo;
	private boolean isAdmin;
	private double hours;

	public User() {
		//
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int compamnyId) {
		this.companyId = compamnyId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
		this.name = name();
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
		this.name = name();
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	public String getActivationHash() {
		return activationHash;
	}

	public void setActivationHash(String activationHash) {
		this.activationHash = activationHash;
	}

	public boolean isDemo() {
		return isDemo;
	}

	public void setDemo(boolean isDemo) {
		this.isDemo = isDemo;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public double getHours() {
		return hours;
	}

	public void setHours(double hours) {
		this.hours = hours;
	}

	private String name() {
		return String.format("%s %s", this.firstName, this.lastName);
	}

}
