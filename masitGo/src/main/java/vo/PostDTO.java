package vo;

import java.util.Date;

public class PostDTO {
	private int post_id;
	private String id;
	private String title;
	private String content;
	private Date post_date;
	private int views;
	private String board_name;
	public PostDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public PostDTO(int post_id, String title, String content, Date post_date, int views, String board_name) {
		this.post_id = post_id;
		this.title = title;
		this.content = content;
		this.post_date = post_date;
		this.views = views;
		this.board_name = board_name;
	}

	public PostDTO(int post_id, String id, String title, String content, Date post_date, int views, String board_name) {
		this.post_id = post_id;
		this.id = id;
		this.title = title;
		this.content = content;
		this.post_date = post_date;
		this.views = views;
		this.board_name = board_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	
	
	

}
