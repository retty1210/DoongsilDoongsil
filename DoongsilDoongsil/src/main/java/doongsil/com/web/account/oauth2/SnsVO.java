package doongsil.com.web.account.oauth2;

public class SnsVO {
	private int social_id;
	private String social_email;
	private String social_type;
	
	public int getSocial_id() {
		return social_id;
	}
	
	public void setSocial_id(int social_id) {
		this.social_id = social_id;
	}
	
	public String getSocial_email() {
		return social_email;
	}
	
	public void setSocial_email(String social_email) {
		this.social_email = social_email;
	}
	
	public String getSocial_type() {
		return social_type;
	}
	
	public void setSocial_type(String social_type) {
		this.social_type = social_type;
	}
	
	@Override
	public String toString() {
		return "SnsVO [social_id=" + social_id + ", social_email=" + social_email + ", social_type=" + social_type
				+ "]";
	}
	
}
