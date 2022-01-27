package doongsil.com.web.homework.model;

import java.sql.Date;

public class T_HomeworkVO {

	private int tho_id;//SEQ
	private int tho_writer;//ST_Account FK
	private int tho_grade;
	private int tho_class;
	private String tho_title;
	private String tho_contents;
	private int tho_homeworktype;
	private Date tho_writedate;//dao.getToday()
	private Date tho_deadline;
	private String tho_filelink;
	private int tho_count;
	
	public T_HomeworkVO() {}
	
	public T_HomeworkVO(int tho_id) {
		this.tho_id = tho_id;
	}
	
	public int getTho_id() {
		return tho_id;
	}
	public void setTho_id(int tho_id) {
		this.tho_id = tho_id;
	}
	public int getTho_writer() {
		return tho_writer;
	}
	public void setTho_writer(int tho_writer) {
		this.tho_writer = tho_writer;
	}
	public int getTho_grade() {
		return tho_grade;
	}
	public void setTho_grade(int tho_grade) {
		this.tho_grade = tho_grade;
	}
	public int getTho_class() {
		return tho_class;
	}
	public void setTho_class(int tho_class) {
		this.tho_class = tho_class;
	}
	public String getTho_title() {
		return tho_title;
	}
	public void setTho_title(String tho_title) {
		this.tho_title = tho_title;
	}
	public String getTho_contents() {
		return tho_contents;
	}
	public void setTho_contents(String tho_contents) {
		this.tho_contents = tho_contents;
	}
	public int getTho_homeworktype() {
		return tho_homeworktype;
	}
	public void setTho_homeworktype(int tho_homeworktype) {
		this.tho_homeworktype = tho_homeworktype;
	}
	public Date getTho_writedate() {
		return tho_writedate;
	}
	public void setTho_writedate(Date tho_writedate) {
		this.tho_writedate = tho_writedate;
	}
	public Date getTho_deadline() {
		return tho_deadline;
	}
	public void setTho_deadline(Date tho_deadline) {
		this.tho_deadline = tho_deadline;
	}
	public String getTho_filelink() {
		return tho_filelink;
	}
	public void setTho_filelink(String tho_filelink) {
		this.tho_filelink = tho_filelink;
	}
	public int getTho_count() {
		return tho_count;
	}
	public void setTho_count(int tho_count) {
		this.tho_count = tho_count;
	}
	@Override
	public String toString() {
		return "T_HomeworkVO [tho_id=" + tho_id + ", tho_writer=" + tho_writer + ", tho_grade=" + tho_grade
				+ ", tho_class=" + tho_class + ", tho_title=" + tho_title + ", tho_contents=" + tho_contents
				+ ", tho_homeworktype=" + tho_homeworktype + ", tho_writedate=" + tho_writedate + ", tho_deadline="
				+ tho_deadline + ", tho_filelink=" + tho_filelink + ", tho_count=" + tho_count + "]";
	}
	
	
}
