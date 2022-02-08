package doongsil.com.web.account.model;

import java.sql.Date;

// 학생+교사 회원가입
public class STJoinVO {
	private String sta_username;
	private String sta_name;
	private String sta_password;
	private String sta_password_chk;
	private String sta_email;
	private String sta_address;
	private String sta_postcode;
	private String sta_phonenumber;
	private Date sta_birthday;
	private String sta_usertype;
	
	public STJoinVO() {}
	
	public STJoinVO(String sta_username, String sta_password) {
		this.sta_username = sta_username;
		this.sta_password = sta_password;
	}
	
	public String getSta_username() {
		return sta_username;
	}
	
	public void setSta_username(String sta_username) {
		this.sta_username = sta_username;
	}
	
	public String getSta_name() {
		return sta_name;
	}
	
	public void setSta_name(String sta_name) {
		this.sta_name = sta_name;
	}
	
	public String getSta_password() {
		return sta_password;
	}
	
	public void setSta_password(String sta_password) {
		this.sta_password = sta_password;
	}
	
	public String getSta_password_chk() {
		return sta_password_chk;
	}
	
	public void setSta_password_chk(String sta_password_chk) {
		this.sta_password_chk = sta_password_chk;
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
	
	public Date getSta_birthday() {
		return sta_birthday;
	}
	
	public void setSta_birthday(Date sta_birthday) {
		this.sta_birthday = sta_birthday;
	}
	
	public String getSta_usertype() {
		return sta_usertype;
	}
	
	public void setSta_usertype(String sta_usertype) {
		this.sta_usertype = sta_usertype;
	}
	
}
