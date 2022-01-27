package doongsil.com.web.account.model;

// 공통 로그인
public class LoginVO {
	private String username;
	private String password;
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public String toString() {
		return "LoginVO [username=" + username + ", password=" + password + "]";
	}
	
}
