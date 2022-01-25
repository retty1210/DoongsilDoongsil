package doongsil.com.web.homework.model;

import java.sql.Date;

public class S_HomeworkVO {

	private int sho_id; //ID고유값. SEQ
	private int sho_tid; //T_HOMEWORK FK
	private int sho_writer; //STAccount FK
	private int sho_homeworktype; //T_Category FK
	private int sho_grade;
	private int sho_class;
	private String sho_contents;
	private String sho_goodbad;
	private Date sho_date;
	private String sho_fileurl;
	private String sho_comment;
	
	public S_HomeworkVO() {}
	
	public S_HomeworkVO(int id) {
		this.sho_id = id;
	}
	
	public int getSho_id() {
		return sho_id;
	}
	public void setSho_id(int sho_id) {
		this.sho_id = sho_id;
	}
	public int getSho_tid() {
		return sho_tid;
	}
	public void setSho_tid(int sho_tid) {
		this.sho_tid = sho_tid;
	}
	public int getSho_writer() {
		return sho_writer;
	}
	public void setSho_writer(int sho_writer) {
		this.sho_writer = sho_writer;
	}
	public int getSho_homeworktype() {
		return sho_homeworktype;
	}
	public void setSho_homeworktype(int sho_homeworktype) {
		this.sho_homeworktype = sho_homeworktype;
	}
	public int getSho_grade() {
		return sho_grade;
	}
	public void setSho_grade(int sho_grade) {
		this.sho_grade = sho_grade;
	}
	public int getSho_class() {
		return sho_class;
	}
	public void setSho_class(int sho_class) {
		this.sho_class = sho_class;
	}
	public String getSho_contents() {
		return sho_contents;
	}
	public void setSho_contents(String sho_contents) {
		this.sho_contents = sho_contents;
	}
	public String getSho_goodbad() {
		return sho_goodbad;
	}
	public void setSho_goodbad(String sho_goodbad) {
		this.sho_goodbad = sho_goodbad;
	}
	public Date getSho_date() {
		return sho_date;
	}
	public void setSho_date(Date sho_date) {
		this.sho_date = sho_date;
	}
	public String getSho_fileurl() {
		return sho_fileurl;
	}
	public void setSho_fileurl(String sho_fileurl) {
		this.sho_fileurl = sho_fileurl;
	}
	public String getSho_comment() {
		return sho_comment;
	}
	public void setSho_comment(String sho_comment) {
		this.sho_comment = sho_comment;
	}
	@Override
	public String toString() {
		return "S_HomeworkVO [sho_id=" + sho_id + ", sho_tid=" + sho_tid + ", sho_writer=" + sho_writer
				+ ", sho_homeworktype=" + sho_homeworktype + ", sho_grade=" + sho_grade + ", sho_class=" + sho_class
				+ ", sho_contents=" + sho_contents + ", sho_goodbad=" + sho_goodbad + ", sho_date=" + sho_date
				+ ", sho_fileurl=" + sho_fileurl + ", sho_comment=" + sho_comment + "]";
	}
	
	
}
