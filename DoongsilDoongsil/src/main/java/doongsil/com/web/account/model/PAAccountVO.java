package doongsil.com.web.account.model;

// 학부모 계정
public class PAAccountVO extends STAccountVO {
	private int paa_id;
	private String paa_username;
	private String paa_password;
	private String paa_phonenumber;
	private int paa_child_id; // ST_ACCOUNT FK(sta_name)
	
	public PAAccountVO() {}
	public PAAccountVO(int paa_id,String paa_password, String paa_phonenumber) {
		this.paa_id = paa_id;
		this.paa_password = paa_password;
		this.paa_phonenumber = paa_phonenumber;
	}

	public void setPaa_child_id(int paa_child_id) {
		this.paa_child_id = paa_child_id;
	}
	
	public int getPaa_child_id() {
		return paa_child_id;
	}

	public int getPaa_id() {
		return paa_id;
	}
	
	public void setPaa_id(int paa_id) {
		this.paa_id = paa_id;
	}
	
	public String getPaa_username() {
		return paa_username;
	}
	
	public void setPaa_username(String paa_username) {
		this.paa_username = paa_username;
	}
	
	public String getPaa_password() {
		return paa_password;
	}
	
	public void setPaa_password(String paa_password) {
		this.paa_password = paa_password;
	}
	
	public String getPaa_phonenumber() {
		return paa_phonenumber;
	}
	
	public void setPaa_phonenumber(String paa_phonenumber) {
		this.paa_phonenumber = paa_phonenumber;
	}

	@Override
	public String toString() {
		return "PAAccountVO [paa_id=" + paa_id + ", paa_username=" + paa_username + ", paa_password=" + paa_password
				+ ", paa_phonenumber=" + paa_phonenumber + ", sta_id=" + this.getSta_id() + "]";
	}
	
}
