package kr.co.DTO;

public class itemChangeDTO {
	
	String category, data, user_name;
	int item_no, pk_no;
	
	
	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public int getPk_no() {
		return pk_no;
	}
	public void setPk_no(int pk_no) {
		this.pk_no = pk_no;
	}

}
