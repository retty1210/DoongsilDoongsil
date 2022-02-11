package doongsil.com.web.account.model;

// 학부모 회원가입
public class PAJoinVO extends STAccountVO {
	private String paa_username;
	private String paa_password;
	private String paa_password_chk;
	private String paa_phonenumber;
	private int paa_child_id;
	
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
	
	public String getPaa_password_chk() {
		return paa_password_chk;
	}
	
	public void setPaa_password_chk(String paa_password_chk) {
		this.paa_password_chk = paa_password_chk;
	}
	
	public String getPaa_phonenumber() {
		return paa_phonenumber;
	}
	
	public void setPaa_phonenumber(String paa_phonenumber) {
		this.paa_phonenumber = paa_phonenumber;
	}

	public int getPaa_child_id() {
		return paa_child_id;
	}

	public void setPaa_child_id(int paa_child_id) {
		this.paa_child_id = paa_child_id;
	}

	@Override
	public String toString() {
		return "PAJoinVO [paa_username=" + paa_username + ", paa_password=" + paa_password + ", paa_password_chk="
				+ paa_password_chk + ", paa_phonenumber=" + paa_phonenumber + ", paa_child_id=" + paa_child_id + "]";
	}

}
