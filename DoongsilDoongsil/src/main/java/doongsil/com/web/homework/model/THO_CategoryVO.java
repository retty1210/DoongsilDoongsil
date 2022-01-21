package doongsil.com.web.homework.model;

public class THO_CategoryVO {

	private int tca_id;
	private String tca_category;
	private String tca_contents;
	public int getTca_id() {
		return tca_id;
	}
	public void setTca_id(int tca_id) {
		this.tca_id = tca_id;
	}
	public String getTca_category() {
		return tca_category;
	}
	public void setTca_category(String tca_category) {
		this.tca_category = tca_category;
	}
	public String getTca_contents() {
		return tca_contents;
	}
	public void setTca_contents(String tca_contents) {
		this.tca_contents = tca_contents;
	}
	@Override
	public String toString() {
		return "THO_Category [tca_id=" + tca_id + ", tca_category=" + tca_category + ", tca_contents=" + tca_contents
				+ "]";
	}
	
	
}
