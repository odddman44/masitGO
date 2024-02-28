package vo;

import java.util.Date;
// 게시글 vo
public class Post {
	private int post_id;
	private String title;
	private String content;
	private Date post_date;
	private Date upt_date;
	private int like_cnt;
	private int views;
	private String id;
	private String board;
	public Post() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Post(int post_id, String title, String content, Date post_date, Date upt_date, int like_cnt, int views,
			String id, String board) {
		this.post_id = post_id;
		this.title = title;
		this.content = content;
		this.post_date = post_date;
		this.upt_date = upt_date;
		this.like_cnt = like_cnt;
		this.views = views;
		this.id = id;
		this.board = board;
	}
	public Post(String title, String content, String id, String board) {
		this.title = title;
		this.content = content;
		this.id = id;
		this.board = board;
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
	public Date getUpt_date() {
		return upt_date;
	}
	public void setUpt_date(Date upt_date) {
		this.upt_date = upt_date;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBoard() {
		return board;
	}
	public void setBoard(String board) {
		this.board = board;
	}
	
	
	
	
}
