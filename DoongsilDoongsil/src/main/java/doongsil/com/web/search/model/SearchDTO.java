package doongsil.com.web.search.model;

import java.sql.Date;

public class SearchDTO {
	private int not_Id;
	private int tho_Id;
	private int pab_Id;
	private int searchId;
	
	private String not_Title;
	private String tho_Title;
	private String pab_Title;
	private String searchTitle;
	
	private String sta_UserName;
	private String paa_UserName;
	private String searchUserName;
	
	private Date not_WriteDate;
	private Date tho_WriteDate;
	private Date pab_Date;
	private Date searchDate;
	
	private int not_Count;
	private int tho_Count;
	private int pab_Count;
	private int searchCount;
	
	
	
	
	public int getNot_Id() {
		return not_Id;
	}
	public void setNot_Id(int not_Id) {
		this.not_Id = not_Id;
	}
	public int getTho_Id() {
		return tho_Id;
	}
	public void setTho_Id(int tho_Id) {
		this.tho_Id = tho_Id;
	}
	public int getPab_Id() {
		return pab_Id;
	}
	public void setPab_Id(int pab_Id) {
		this.pab_Id = pab_Id;
	}
	public String getNot_Title() {
		return not_Title;
	}
	public void setNot_Title(String not_Title) {
		this.not_Title = not_Title;
	}
	public String getTho_Title() {
		return tho_Title;
	}
	public void setTho_Title(String tho_Title) {
		this.tho_Title = tho_Title;
	}
	public String getPab_Title() {
		return pab_Title;
	}
	public void setPab_Title(String pab_Title) {
		this.pab_Title = pab_Title;
	}
	public String getSta_UserName() {
		return sta_UserName;
	}
	public void setSta_UserName(String sta_UserName) {
		this.sta_UserName = sta_UserName;
	}
	public String getPaa_UserName() {
		return paa_UserName;
	}
	public void setPaa_UserName(String paa_UserName) {
		this.paa_UserName = paa_UserName;
	}
	
	public Date getNot_WriteDate() {
		return not_WriteDate;
	}
	public void setNot_WriteDate(Date not_WriteDate) {
		this.not_WriteDate = not_WriteDate;
	}
	public Date getTho_WriteDate() {
		return tho_WriteDate;
	}
	public void setTho_WriteDate(Date tho_WriteDate) {
		this.tho_WriteDate = tho_WriteDate;
	}
	public Date getPab_Date() {
		return pab_Date;
	}
	public void setPab_Date(Date pab_Date) {
		this.pab_Date = pab_Date;
	}
	public int getNot_Count() {
		return not_Count;
	}
	public void setNot_Count(int not_Count) {
		this.not_Count = not_Count;
	}
	public int getTho_Count() {
		return tho_Count;
	}
	public void setTho_Count(int tho_Count) {
		this.tho_Count = tho_Count;
	}
	public int getPab_Count() {
		return pab_Count;
	}
	public void setPab_Count(int pab_Count) {
		this.pab_Count = pab_Count;
	}
	
	
	public int getSearchId() {
		if(getNot_Id() != 0) {
			this.searchId = getNot_Id();
		}else if(getTho_Id() != 0) {
			this.searchId = getTho_Id();
		}else {
			this.searchId = getPab_Id();
		}
		return searchId;
	}
	public String getSearchTitle() {
		if(getNot_Title() != null) {
			this.searchTitle = getNot_Title();
		}else if(getTho_Title() != null) {
			this.searchTitle = getTho_Title();
		}else {
			this.searchTitle = getPab_Title();
		}
		return searchTitle;
	}

	public String getSearchUserName() {
		if(getSta_UserName() != null) {
			this.searchUserName = getSta_UserName();
		}else {
			this.searchUserName = getPaa_UserName();
		}
		return searchUserName;
	}
	
	
	public Date getSearchDate() {
		if(getNot_WriteDate() != null) {
			this.searchDate = getNot_WriteDate();
		}else if(getTho_WriteDate() != null) {
			this.searchDate = getTho_WriteDate();
		}else {
			this.searchDate = getPab_Date();
		}
		return searchDate;
	}
	
	public int getSearchCount() {
		if(getNot_Count() != 0) {
			this.searchCount = getNot_Count();
		}else if(getTho_Count() != 0) {
			this.searchCount = getTho_Count();
		}else {
			this.searchCount = getPab_Count();
		}
		return searchCount;
	}
	@Override
	public String toString() {
		return "SearchDTO [searchId=" + searchId + ", searchTitle=" + searchTitle + ", searchUserName=" + searchUserName
				+ ", searchDate=" + searchDate + ", searchCount=" + searchCount + "]";
	}
	
	
	
	
	

}
