package doongsil.com.web.notice.model;

public class NotFileVO {
	private int seq;
	private int f_seq;
	private String original_file_name;
	private String file_path;
	private long file_size;
	
	public int getSeq() {
		return seq;
	}
	
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public int getF_seq() {
		return f_seq;
	}
	
	public void setF_seq(int f_seq) {
		this.f_seq = f_seq;
	}
	
	public String getOriginal_file_name() {
		return original_file_name;
	}
	
	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}
	
	public String getFile_path() {
		return file_path;
	}
	
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	
	public long getFile_size() {
		return file_size;
	}
	
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	@Override
	public String toString() {
		return "NotFileVO [seq=" + seq + ", f_seq=" + f_seq + ", original_file_name=" + original_file_name
				+ ", file_path=" + file_path + ", file_size=" + file_size + "]";
	}
	
	

}
