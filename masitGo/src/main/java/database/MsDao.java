package database;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.*;

public class MsDao {
	public Object templateRead(String dname) {
		Object ob = new Object();
		String sql = "select deptno,dname,loc from dept where dname like ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			// 처리코드1
			pstmt.setString(1, "%" + dname + "%");
			try (ResultSet rs = pstmt.executeQuery();) {
				// 처리코드2
				rs.next();
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		return ob;
	}

	public int templateCUD(String ename) { // delete, update는 처리코드 1번만 사용!
		int cudCnt = 0;
		String sql = "INSERT INTO emp01(ename) values(?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setString(1, ename);

			cudCnt = pstmt.executeUpdate();
			if (cudCnt == 0) {
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
		return cudCnt;
	}

	// 게시글 등록 DAO
	public int writePost(Post ins) {
		int isIns = 0;
		String sql = "INSERT INTO post VALUES\r\n" + "(post_seq.nextval, ?, ?, \r\n" + "sysdate, NULL, 0, 0, ?, ?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setString(1, ins.getTitle());
			pstmt.setString(2, ins.getContent());
			pstmt.setString(3, ins.getId());
			pstmt.setString(4, ins.getBoard());

			isIns = pstmt.executeUpdate();
			if (isIns == 0) {
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
		return isIns;
	}
	// 게시글 삭제
	public int deletePost(int post_id) {
		int delCnt = 0;
		String sql = "delete from post where post_id= ? ";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);

		) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, post_id);
			delCnt = pstmt.executeUpdate();

			if (delCnt == 0) {
				System.out.println("삭제 실패");
				con.rollback();
			} else {
				con.commit();
				System.out.println("삭제 성공");
			}

		

		} catch (SQLException e) {
			System.out.println("DB 에러 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러 : " + e.getMessage());
		}

		return delCnt;
	}

	// 게시글 전체글 조회 dao
	public List<PostDTO> getPost(String board_name, String value) {
	    List<PostDTO> plist = new ArrayList<PostDTO>();
	    String sql = "SELECT POST_ID, ID, TITLE, CONTENT, POST_DATE, VIEWS, BOARD_NAME "
	            + "FROM post ";

	    if (board_name != null && !board_name.isEmpty()) {
	        sql += "WHERE BOARD_NAME = ?";
	    }

	    if (value.equals("2")) {
	        // 과거순으로 정렬하면 DESC 빼기
	        sql += " ORDER BY POST_DATE ASC"; // ASC는 오름차순, DESC는 내림차순
	    } else {
	        // 기본적으로 최신순으로 정렬
	        sql += " ORDER BY POST_DATE DESC";
	    }

	    try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql)) {
	        // 처리코드1
	        if (board_name != null && !board_name.isEmpty()) {
	            pstmt.setString(1, board_name);
	        }

	        try (ResultSet rs = pstmt.executeQuery()) {
	            // 처리코드2
	            while (rs.next()) {
	                plist.add(new PostDTO(rs.getInt("post_id"), rs.getString("id"), rs.getString("title"),
	                        rs.getString("content"), rs.getDate("post_date"), rs.getInt("views"),
	                        rs.getString("board_name")));
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러:" + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러:" + e.getMessage());
	    }

	    return plist;
	}

	// post_id 받아서 게시글 조회
	public PostDTO getPostByPost_id(int post_id) {

		String sql = "select * from post where post_id = ?";

		PostDTO post = null;
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			// 처리코드1
			pstmt.setInt(1, post_id);

			try (ResultSet rs = pstmt.executeQuery()) {
				// 처리코드2
				if (rs.next()) {
					post = new PostDTO(rs.getInt("post_id"), rs.getString("id"), rs.getString("title"),
							rs.getString("content"), rs.getDate("post_date"), rs.getInt("views"),
							rs.getString("board_name"));
					//increaseViews(post_id);
				}
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}

		return post;
	}

	// 신고하기
	public int writeReport(Report ins) {
		int isIns = 0;
		String sql = "INSERT INTO REPORT values(?, ?, ?, sysdate, 'N')";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, ins.getPost_id());
			pstmt.setString(2, ins.getId());
			pstmt.setString(3, ins.getReason());
			
	
			isIns = pstmt.executeUpdate();
			if (isIns == 0) {
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
		return isIns;
	}
	// post_id값을 받아서 조회수 올리기
	public int increaseViews(int post_id) {
		int isUpt = 0;
		String sql = "UPDATE post SET views = views + 1 WHERE POST_ID = ?";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);

				) {
					con.setAutoCommit(false);
					// 처리코드1
					pstmt.setInt(1, post_id);
					isUpt = pstmt.executeUpdate();
					
					if (isUpt == 0) {
						System.out.println("조회수 상승 이벤트 실패");
						con.rollback();
					} else {
						con.commit();
						System.out.println("조회수 상승 이벤트 성공:"+isUpt);
					}
					/*
					try (ResultSet rs = pstmt.executeQuery();) {
						// 처리코드2
						rs.next();

					}
					*/

				} catch (SQLException e) {
					System.out.println("DB 에러 : " + e.getMessage());
				} catch (Exception e) {
					System.out.println("일반 에러 : " + e.getMessage());
				}
		return isUpt;
	}

	// 별점 주기
	public int writeRating(Rating ins) {
		int isIns = 0;
		String sql = "INSERT INTO RATING values(?, ?, ?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, ins.getPost_id());
			pstmt.setString(2, ins.getId());
			pstmt.setInt(3, ins.getScore());
			
	
			isIns = pstmt.executeUpdate();
			if (isIns == 0) {
				System.out.println("CUD 실패");
				con.rollback();
			} else {
				con.commit(); // Commit the transaction
				System.out.println("리뷰 등록 성공");
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		return isIns;
	}

	public static void main(String[] args) {
		MsDao dao = new MsDao();
//		Post ins = new Post("잡답입니다.", "내용없음", "audtlsdl12", 4);
//		dao.writePost(ins);
//		dao.deletePost(23);
		List<PostDTO> plist = dao.getPost("잡답", "0");
		if (plist != null) {
			for (PostDTO post : plist) {
				System.out.print(post.getPost_id() + "\t");
				System.out.print(post.getTitle() + "\t");
				System.out.print(post.getBoard_name() + "\n");
			}
		}
//		Report ins = new Report(3, "audtlsdl12", 3);
//		System.out.println(dao.writeReport(ins));
		//System.out.println("조회수 상승 여부:" +dao.updateViews(62));
//		Rating ins = new Rating(53,"audtlsdl12", 4);
//		System.out.println(dao.writeRating(ins));
//	
	}
}
