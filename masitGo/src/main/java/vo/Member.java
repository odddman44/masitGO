package vo;

public class Member {

	private String name;
	private String id;
	private String password;
	private String birthday;
	private String email;
	private String hp;
	private String auth;
	
	
	public Member(String name, String email, String hp, String id) {
		this.name = name;
		this.email = email;
		this.hp = hp;
		this.id = id;
	}
	public Member(String name, String id, String password, String birthday, String email, String hp) {
		this.name = name;
		this.id = id;
		this.password = password;
		this.birthday = birthday;
		this.email = email;
		this.hp = hp;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public Member() {
		// TODO Auto-generated constructor stub
	}
	public Member(String name, String id, String password, String birthday, String email, String hp, String auth) {
		this.name = name;
		this.id = id;
		this.password = password;
		this.birthday = birthday;
		this.email = email;
		this.hp = hp;
		this.auth = auth;
	}
	
	
	
}
