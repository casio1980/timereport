package DAO.transfer;

import java.util.List;

import com.google.gson.Gson;

public abstract class TransferObject {

	public String toJson() {
		return new Gson().toJson(this);
	}

	public static String listToJson(List<? extends TransferObject> objects) {
		return new Gson().toJson(objects);
	}

}
