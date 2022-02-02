package doongsil.com.web.reply.model;

import java.sql.Date;

public class ReplyVO {
	private int reply_id;  //PK
	private int n_id;   //not_id와 FK
	private String reply_contents; //NN
	private String reply_writer;   //NN
	private Date reply_date;	//기본값: SYSDATE
	
	public int getReply_id() {
		return reply_id;
	}
	
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	
	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
	}
	
	public String getReply_contents() {
		return reply_contents;
	}
	
	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}
	
	public String getReply_writer() {
		return reply_writer;
	}
	
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	
	public Date getReply_date() {
		return reply_date;
	}
	
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	
}
