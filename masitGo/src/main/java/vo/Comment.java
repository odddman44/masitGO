package vo;

import java.sql.Timestamp;

public class Comment {
	private String userId;
	private String content;
	private Timestamp regDate;
	private int totalComments;
	
	public int getTotalComments() {
		return totalComments;
	}
	public void setTotalComments(int totalComments) {
		this.totalComments = totalComments;
	}
	public Comment() {
		// TODO Auto-generated constructor stub
	}
	public Comment(String userId, String content, Timestamp regDate) {
		this.userId = userId;
		this.content = content;
		this.regDate = regDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	
}
