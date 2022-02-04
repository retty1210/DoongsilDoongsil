package doongsil.com.web.account.model;

import java.sql.Date;

import lombok.Data;

@Data
// 학생+교사 계정
public class STAccountVO {
	private int sta_id;
	private String sta_username;
	private String sta_password;
	private String sta_name;
	private String sta_email;
	private String sta_address;
	private String sta_postcode;
	private String sta_phonenumber;
	private int sta_grade;
	private int sta_class;
	private Date sta_birthday;
	private String sta_profile;
	private String sta_usertype;
	
	public STAccountVO() {}
	
	public STAccountVO(int sta_id,String sta_name, String sta_email, String sta_address, String sta_phonenumber, int sta_grade,
			int sta_class, Date sta_birthday, String sta_profile, String sta_usertype) {
		this.sta_id = sta_id;
		this.sta_name = sta_name;
		this.sta_email = sta_email;
		this.sta_address = sta_address;
		this.sta_phonenumber = sta_phonenumber;
		this.sta_grade = sta_grade;
		this.sta_class = sta_class;
		this.sta_birthday = sta_birthday;
		this.sta_profile = sta_profile;
		this.sta_usertype = sta_usertype;
	}

	public int getSta_id() {
		return sta_id;
	}
	
	public void setSta_id(int sta_id) {
		this.sta_id = sta_id;
	}
	
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
	
	public String getSta_name() {
		return sta_name;
	}
	
	public void setSta_name(String sta_name) {
		this.sta_name = sta_name;
	}
	
	public String getSta_email() {
		return sta_email;
	}
	
	public void setSta_email(String sta_email) {
		this.sta_email = sta_email;
	}
	
	public String getSta_address() {
		return sta_address;
	}
	
	public void setSta_address(String sta_address) {
		this.sta_address = sta_address;
	}
	
	public String getSta_postcode() {
		return sta_postcode;
	}
	
	public void setSta_postcode(String sta_postcode) {
		this.sta_postcode = sta_postcode;
	}
	
	public String getSta_phonenumber() {
		return sta_phonenumber;
	}
	
	public void setSta_phonenumber(String sta_phonenumber) {
		this.sta_phonenumber = sta_phonenumber;
	}
	
	public int getSta_grade() {
		return sta_grade;
	}
	
	public void setSta_grade(int sta_grade) {
		this.sta_grade = sta_grade;
	}
	
	public int getSta_class() {
		return sta_class;
	}
	
	public void setSta_class(int sta_class) {
		this.sta_class = sta_class;
	}
	
	public Date getSta_birthday() {
		return sta_birthday;
	}
	
	public void setSta_birthday(Date sta_birthday) {
		this.sta_birthday = sta_birthday;
	}
	
	public String getSta_profile() {
		return sta_profile;
	}
	
	public void setSta_profile(String sta_profile) {
		this.sta_profile = sta_profile;
	}
	
	public String getSta_usertype() {
		return sta_usertype;
	}
	
	public void setSta_usertype(String sta_usertype) {
		this.sta_usertype = sta_usertype;
	}
	
	@Override
	public String toString() {
		return "STAccountVO [sta_id=" + sta_id + ", sta_username=" + sta_username + ", sta_password=" + sta_password
				+ ", sta_name=" + sta_name + ", sta_email=" + sta_email + ", sta_address=" + sta_address
				+ ", sta_postcode=" + sta_postcode + ", sta_phonenumber=" + sta_phonenumber + ", sta_grade=" + sta_grade
				+ ", sta_class=" + sta_class + ", sta_birthday=" + sta_birthday + ", sta_profile=" + sta_profile
				+ ", sta_usertype=" + sta_usertype + "]";
	}

}
