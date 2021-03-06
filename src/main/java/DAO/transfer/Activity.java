package DAO.transfer;

public class Activity extends TransferObject {

	private int id;
	private int companyId;
	private String name;
	private String description;
	private double hours;

	public Activity() {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getHours() {
		return hours;
	}

	public void setHours(double hours) {
		this.hours = hours;
	}
}
