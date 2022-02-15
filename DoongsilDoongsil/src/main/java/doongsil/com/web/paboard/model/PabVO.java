package doongsil.com.web.paboard.model;

import java.sql.Date;

public class PabVO {
	private int pab_id;
	private int pab_writer;
	private String pab_title;
	private String pab_contents;
	private int pab_category;
	private String pab_grade;
	private String pab_class;
	private Date pab_date;
	private int pab_Count;
	private String paa_UserName;
	
	private int pac_id;
	private String pac_category;
	
	
	
	
	public int getPab_Count() {
		return pab_Count;
	}
	public void setPab_Count(int pab_Count) {
		this.pab_Count = pab_Count + 1;
	}
	public String getPaa_UserName() {
		return paa_UserName;
	}
	public void setPaa_UserName(String paa_UserName) {
		this.paa_UserName = paa_UserName;
	}
	public int getPab_id() {
		return pab_id;
	}
	public void setPab_id(int pab_id) {
		this.pab_id = pab_id;
	}
	public int getPab_writer() {
		return pab_writer;
	}
	public void setPab_writer(int pab_writer) {
		this.pab_writer = pab_writer;
	}
	public String getPab_title() {
		return pab_title;
	}
	public void setPab_title(String pab_title) {
		this.pab_title = pab_title;
	}
	public String getPab_contents() {
		return pab_contents;
	}
	public void setPab_contents(String pab_contents) {
		this.pab_contents = pab_contents;
	}
	public int getPab_category() {
		return pab_category;
	}
	public void setPab_category(int pab_category) {
		this.pab_category = pab_category;
	}
	public String getPab_grade() {
		return pab_grade;
	}
	public void setPab_grade(String pab_grade) {
		this.pab_grade = pab_grade;
	}
	public String getPab_class() {
		return pab_class;
	}
	public void setPab_class(String pab_class) {
		this.pab_class = pab_class;
	}
	public Date getPab_date() {
		return pab_date;
	}
	public void setPab_date(Date pab_date) {
		this.pab_date = pab_date;
	}
	
	public int getPac_id() {
		return pac_id;
	}
	public void setPac_id(int pac_id) {
		this.pac_id = pac_id;
	}
	public String getPac_category() {
		return pac_category;
	}
	public void setPac_category(String pac_category) {
		this.pac_category = pac_category;
	}
	@Override
	public String toString() {
		return "PabVO [pab_id=" + pab_id + ", pab_writer=" + pab_writer + ", pab_title=" + pab_title + ", pab_contents="
				+ pab_contents + ", pab_category=" + pab_category + ", pab_grade=" + pab_grade + ", pab_class="
				+ pab_class + ", pab_date=" + pab_date + ", pab_Count=" + pab_Count + ", paa_UserName=" + paa_UserName
				+ "]";
	}
	
	
}

