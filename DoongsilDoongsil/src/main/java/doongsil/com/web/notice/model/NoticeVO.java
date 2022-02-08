package doongsil.com.web.notice.model;

import java.sql.Date;

public class NoticeVO {
	private int not_id;
	private int not_writer;
	private int not_grade;
	private int not_class;
	private String not_permit; //학생만(s), 학부모만(p), 학생&학부모(A)
	private String not_title;
	private String not_contents;
	private Date not_writedate;
	private Date not_eventdate;
	private int not_count;
	private int reply_count;
	
	public NoticeVO() {
		
	}
	
	public NoticeVO(String not_permit) {
		this.not_permit = not_permit;
	}
	
	public int getNot_id() {
		return not_id;
	}
	
	public void setNot_id(int not_id) {
		this.not_id = not_id;
	}
	
	public int getNot_writer() {
		return not_writer;
	}
	
	public void setNot_writer(int not_writer) {
		this.not_writer = not_writer;
	}
	
	public int getNot_grade() {
		return not_grade;
	}
	
	public void setNot_grade(int not_grade) {
		this.not_grade = not_grade;
	}
	
	public int getNot_class() {
		return not_class;
	}
	
	public void setNot_class(int not_class) {
		this.not_class = not_class;
	}
	
	public String getNot_permit() {
		return not_permit;
	}
	
	public void setNot_permit(String not_permit) {
		this.not_permit = not_permit;
	}
	
	public String getNot_title() {
		return not_title;
	}
	
	public void setNot_title(String not_title) {
		this.not_title = not_title;
	}
	
	public String getNot_contents() {
		return not_contents;
	}
	
	public void setNot_contents(String not_contents) {
		this.not_contents = not_contents;
	}
	
	public Date getNot_writedate() {
		return not_writedate;
	}
	
	public void setNot_writedate(Date not_writedate) {
		this.not_writedate = not_writedate;
	}
	
	public Date getNot_eventdate() {
		return not_eventdate;
	}
	
	public void setNot_eventdate(Date not_eventdate) {
		this.not_eventdate = not_eventdate;
	}
	
	public int getNot_count() {
		return not_count;
	}
	
	public void setNot_count(int not_count) {
		this.not_count = not_count;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
	
	
}
