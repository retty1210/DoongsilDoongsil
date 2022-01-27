package doongsil.com.web.account.model;

// 공통 로그인
public class LoginVO {
	private String userType;
	private String username;
	private String password;
	
	
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

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
		return "LoginVO [userType=" + userType + ", username=" + username + ", password=" + password + "]";
	}
	
	
	
}
