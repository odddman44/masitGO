package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.*;

public class UserDao {

	public Object templateRead(String dname){
		Object ob = new Object();
		String sql = "select deptno,dname,loc from dept where dname like ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setString(1,"%"+dname+"%");
			try( 
				ResultSet rs = pstmt.executeQuery();
				){
				//처리코드2
				rs.next();
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return ob;
	}
	
	public int templateCUD(String ename){
	    int cudCnt = 0;
	    String sql = "INSERT INTO emp01(ename) values(?)";
	    try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
	        con.setAutoCommit(false);
	        // 처리코드1
	        pstmt.setString(1, ename);
	        

	        cudCnt = pstmt.executeUpdate();
	        if(cudCnt == 0) {
	        	System.out.println("CUD 실패");
	        	con.rollback();
	        }else {
	        	con.commit(); // Commit the transaction
	        	System.out.println("CUD 성공");
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러:" + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러:" + e.getMessage());
	    }
		return cudCnt;
	}
	
	public Member login(String id, String password) {
	    Member member = null;
	    String sql = "SELECT * FROM MEMBER WHERE id = ? AND password = ?";

	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, id);
	        pstmt.setString(2, password);

	        try (ResultSet rs = pstmt.executeQuery();) {
	            if (rs.next()) {
	                member = new Member(
	                    rs.getString("name"),
	                    rs.getString("id"),
	                    rs.getString("password"),
	                    rs.getString("birthday"),
	                    rs.getString("email"),
	                    rs.getString("hp"),
	                    rs.getString("authority")
	                );
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }

	    return member;
	}
	
	//SELECT * FROM MEMBER WHERE id='admin';
	public boolean checkId(String id) {
		boolean chId = false;
		String sql = "SELECT * FROM MEMBER WHERE id=  ? ";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);

			try (ResultSet rs = pstmt.executeQuery();) {
				chId = rs.next(); 
				
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		return chId;
	}
	
	//SELECT PASSWORD  FROM MEMBER WHERE id='admin' AND NAME='관리자'
	public String searchPwd(String id,String name){
	    String password = "";
	    String sql = "SELECT PASSWORD FROM MEMBER WHERE id=? AND NAME=?";
	    try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
	        con.setAutoCommit(false);
	        // 처리코드1
	        pstmt.setString(1, id);
	        pstmt.setString(2, name);

	        try (ResultSet rs = pstmt.executeQuery();) {
	        	 if (rs.next()) {
	        		 password=rs.getString("password");
	        	 }
				
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		return password;
	}
	//INSERT INTO member (name, id, password, birthday, email, hp)
	//VALUES ('홍길동', 'aaaa', '1111',
	//TO_DATE('1997-05-30', 'YYYY-MM-DD'), '', '');
	public int insertMember(Member member) {
		int insCnt = 0;
		String sql = "INSERT INTO member (name, id, password, birthday, email, hp)\r\n"
				+ "	VALUES (?, ?, ?,\r\n"
				+ "	TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getPassword());
			pstmt.setString(4, member.getBirthday());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getHp());
			insCnt = pstmt.executeUpdate();
			if (insCnt == 0) {
				System.out.println("등록 실패");
				con.rollback();
			} else {
				con.commit(); // Commit the transaction
				System.out.println("등록 성공");
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}

		return insCnt;
	}
	/*
	 * update MEMBER set name = '홍진경', email = 'shi1234@naver.com', hp= '011-1236-4584' where id ='gggg';
	 */

	public int updateMember(Member member) {
		int uptCnt = 0;
		String sql = "update MEMBER set name = ?, email = ?, hp= ?, password= ? where id =?";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getHp());
			pstmt.setString(4, member.getPassword());
			pstmt.setString(5, member.getId());
			uptCnt = pstmt.executeUpdate();
			if (uptCnt == 0) {
				System.out.println("CUD 실패");
				con.rollback();
			} else {
				con.commit(); // Commit the transaction
				System.out.println("CUD 성공");
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}

		return uptCnt;
	}
	public Member getMemberById(String id) {
	    Member member = null;
	    String sql = "SELECT * FROM MEMBER WHERE id = ?";

	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, id);

	        try (ResultSet rs = pstmt.executeQuery();) {
	            if (rs.next()) {
	                member = new Member(
	                    rs.getString("name"),
	                    rs.getString("id"),
	                    rs.getString("password"),
	                    rs.getString("birthday"),
	                    rs.getString("email"),
	                    rs.getString("hp"),
	                    rs.getString("authority")
	                );
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }

	    return member;
	}
	//SELECT * FROM post WHERE id='audtlsdl12' ;
	public List<PostDTO> getMyPost(String id) {
		List<PostDTO> plist = new ArrayList<PostDTO>();
	    String sql = "SELECT * FROM post WHERE id= ?";

	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, id);

	        try (ResultSet rs = pstmt.executeQuery();) {
	        	while (rs.next()) {
	                plist.add(new PostDTO(
	                        rs.getInt("post_id"),
	                        rs.getString("title"),
	                        rs.getString("content"),
	                        rs.getDate("post_date"),
	                        rs.getInt("views"),
	                        rs.getString("board_name")
	                ));
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }

	    return plist;
	}
	//SELECT * FROM COMMENTS WHERE id='audtlsdl12';
	public List<Comment> getMycomment(String id) {
		List<Comment> clist = new ArrayList<Comment>();
	    String sql = "SELECT id userId, content, reg_date regDate FROM COMMENTS WHERE id= ?";

	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, id);

	        try (ResultSet rs = pstmt.executeQuery();) {
	        	while (rs.next()) {
	        		clist.add(new Comment(
	                        rs.getString("userId"),
	                        rs.getString("content"),
	                        rs.getTimestamp("regDate")
	                ));
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }

	    return clist;
	}
}
