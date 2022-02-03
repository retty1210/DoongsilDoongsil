package doongsil.com.web.account.model;

// 학생과 교사용 로그인
public class STLoginVO {
	private String sta_username;
	private String sta_password;
	
	public String getSta_username() {
		return sta_username;
	}
	
	public void setSta_username(String sta_username) {
		this.sta_username = sta_username;
	}
	
	public String getSta_password() {
		return sta_password;
	}
	
	public void setSta_password(String sta_password) {
		this.sta_password = sta_password;
	}

	@Override
	public String toString() {
		return "STLoginVO [sta_username=" + sta_username + ", sta_password=" + sta_password + "]";
	}
	
}
