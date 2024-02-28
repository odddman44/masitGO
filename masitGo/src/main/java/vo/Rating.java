package vo;

public class Rating {
	private int post_id;
	private String id;
	private int score;
	public Rating() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Rating(int post_id, String id, int score) {
		super();
		this.post_id = post_id;
		this.id = id;
		this.score = score;
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
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	

}
