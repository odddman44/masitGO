package vo;

import java.sql.Date;

public class Mpost {
	private int post_id;
	private String board_name;
	private String title;
	private String name;
	private Date post_date;
	private int like_cnt;
	private int views;
	
	// 필드 추가
	private Double latitude;
	private Double longitude;
	private String content;
	private String authority;
	private String id;
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public Mpost() {
		// TODO Auto-generated constructor stub
	}
	public Mpost(int post_id, String title, String name, Date post_date, int like_cnt, int views) {
		super();
		this.post_id = post_id;
		this.title = title;
		this.name = name;
		this.post_date = post_date;
		this.like_cnt = like_cnt;
		this.views = views;
	}
	public Mpost(int post_id, String board_name, String title, String name, Date post_date, int like_cnt, int views) {
		super();
		this.post_id = post_id;
		this.board_name = board_name;
		this.title = title;
		this.name = name;
		this.post_date = post_date;
		this.like_cnt = like_cnt;
		this.views = views;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	public int getLike_cnt() {
		return like_cnt;
	}
	public void setLike_cnt(int like_cnt) {
		this.like_cnt = like_cnt;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	
}
