package doongsil.com.web.calendar.model;

import java.sql.*;

public class CalendarDTO {
	private int cal_id;
	private String cal_title;
	private Date cal_start;
	private Date cal_end;
	private String cal_bgc = "#77b0bf";
	
	public CalendarDTO() {}
	
	public int getCal_id() {
		return cal_id;
	}
	
	public void setCal_id(int cal_id) {
		this.cal_id = cal_id;
	}
	
	public String getCal_title() {
		return cal_title;
	}
	
	public void setCal_title(String cal_title) {
		this.cal_title = cal_title;
	}
	
	public Date getCal_start() {
		return cal_start;
	}
	
	public void setCal_start(String cal_start) {
		
		this.cal_start = Date.valueOf(cal_start);
	}
	public void setCal_start(Date cal_start) {
		
		this.cal_start = cal_start;
	}
	
	public Date getCal_end() {
		return cal_end;
	}
	
	public void setCal_end(String cal_end) {
		this.cal_end = Date.valueOf(cal_end);
	}
	public void setCal_end(Date cal_end) {
		this.cal_end = cal_end;
	}
	
	public String getCal_bgc() {
		return cal_bgc;
	}
	
	public void setCal_bgc(String cal_bgc) {
		this.cal_bgc = cal_bgc;
	}

	@Override
	public String toString() {
		return "CalendarDTO [cal_id=" + cal_id + ", cal_title=" + cal_title + ", cal_start=" + cal_start + ", cal_end="
				+ cal_end + ", cal_bgc=" + cal_bgc + "]";
	}
}
