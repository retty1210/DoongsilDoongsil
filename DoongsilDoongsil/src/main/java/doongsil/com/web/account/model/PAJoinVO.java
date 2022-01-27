package doongsil.com.web.account.model;

// 학부모 회원가입
public class PAJoinVO extends STAccountVO {
	private String paa_username;
	private String paa_name;
	private String paa_password;
	private String paa_password_chk;
	private String paa_phonenumber;
	private String sta_name;
	
	public String getPaa_username() {
		return paa_username;
	}
	
	public void setPaa_username(String paa_username) {
		this.paa_username = paa_username;
	}
	
	public String getPaa_name() {
		return paa_name;
	}
	
	public void setPaa_name(String paa_name) {
		this.paa_name = paa_name;
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
	
	public String getSta_name() {
		return sta_name;
	}
	
	public void setSta_name(String sta_name) {
		this.sta_name = sta_name;
	}
}
