package DAO.transfer;

public class Company extends TransferObject {

	private int id;
	private String name;

	public Company() {
		//
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
