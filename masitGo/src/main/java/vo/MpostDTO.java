package vo;

public class MpostDTO {
	private String title;
	private String content;
	private String userId;
	private String board_name;
	private double latitude;
	private double longitude;
	public MpostDTO() {
		// TODO Auto-generated constructor stub
	}
	public MpostDTO(String title, String content, String userId, String board_name, double latitude, double longitude) {
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.board_name = board_name;
		this.latitude = latitude;
		this.longitude = longitude;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	
}
