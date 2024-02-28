package vo;

import java.sql.Date;

// 신고 vo
public class Report {
	public Report(int post_id, String id, String reason) {
		this.post_id = post_id;
		this.id = id;
		this.reason = reason;
	}
	private int post_id;
	private String id;
	private String reason;
	private Date reg_date;
	private String isProcess;
	
	public Report() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Report(int post_id, String id, String reason, Date reg_date, String isProcess) {
		this.post_id = post_id;
		this.id = id;
		this.reason = reason;
		this.reg_date = reg_date;
		this.isProcess = isProcess;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getIsProcess() {
		return isProcess;
	}
	public void setIsProcess(String isProcess) {
		this.isProcess = isProcess;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	
	
}
