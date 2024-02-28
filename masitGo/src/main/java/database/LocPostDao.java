package database;

// import="database.LocPostDao"

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Comment;
import vo.Mpost;
import vo.MpostDTO;

public class LocPostDao {

	/**
	 ** 사용할 템플릿 ** 
	 * */
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
	
	/* 메인 홈페이지 맛집 목록 및 위치 정보 조회 메서드 */
	public List<Mpost> getMapInfo() {
	    List<Mpost> mpostList = new ArrayList<>();
	    String sql = "SELECT p.post_id, p.title, p.like_cnt, p.views, l.latitude, l.longitude " +
	                 "FROM post p JOIN location l ON p.post_id = l.post_id " +
	                 "WHERE p.board_name = '맛집정보공유' " +
	                 "ORDER BY p.post_date DESC";

	    try(Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();) {

	        while(rs.next()) {
	            Mpost post = new Mpost();
	            post.setPost_id(rs.getInt("post_id"));
	            post.setTitle(rs.getString("title"));
	            post.setLike_cnt(rs.getInt("like_cnt"));
	            post.setViews(rs.getInt("views"));
	            post.setLatitude(rs.getDouble("latitude"));
	            post.setLongitude(rs.getDouble("longitude"));
	            mpostList.add(post);
	        }
	    } catch(SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch(Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }

	    return mpostList;
	}
    /* 맛집정보공유 게시판 게시글 목록 조회 메소드 */
    public List<Mpost> getMposts(){
        List<Mpost> mpostList = new ArrayList<>();
        String sql = "SELECT p.post_id, p.board_name, p.title, m.name, p.post_date, p.like_cnt, p.views " + 
                "FROM post p " +
                "JOIN member m ON p.id = m.id " +
                "WHERE p.board_name = '맛집정보공유' OR p.board_name = '공지' " + // 게시판 이름 조건 수정
                "ORDER BY p.post_date DESC"; // 날짜 내림차순으로 정렬
        
        try(Connection con = DBCon.con();
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();) {
            
            while(rs.next()){
                Mpost post = new Mpost(
                    rs.getInt("post_id"),
                    rs.getString("board_name"),
                    rs.getString("title"),
                    rs.getString("name"), // 작성자 이름
                    rs.getDate("post_date"),
                    rs.getInt("like_cnt"),
                    rs.getInt("views")
                );
                mpostList.add(post);
            }
            System.out.println("조회된 데이터 수:"+mpostList.size());
        } catch(SQLException e) {
            System.out.println("DB 에러:"+e.getMessage());
        } catch(Exception e) {
            System.out.println("일반 에러:"+e.getMessage());
        }

        return mpostList;
    }
    
    /*게시글 클릭시 내용 상세 보기 메서드*/
    public Mpost getPostDetail(int postId) {
        Mpost mpost = null;
        String sql = "SELECT p.post_id, p.title, m.name, m.id, m.authority, p.post_date, p.like_cnt, p.views, l.latitude, l.longitude, p.content " +
                "FROM post p " +
                "JOIN member m ON p.id = m.id " +
                "LEFT JOIN location l ON p.post_id = l.post_id " +
                "WHERE p.post_id = ?";

        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    mpost = new Mpost();
                    mpost.setPost_id(rs.getInt("post_id"));
                    mpost.setTitle(rs.getString("title"));
                    mpost.setName(rs.getString("name"));
                    mpost.setId(rs.getString("id"));
                    mpost.setAuthority(rs.getString("authority")); // 권한 설정
                    mpost.setPost_date(rs.getDate("post_date"));
                    mpost.setLike_cnt(rs.getInt("like_cnt"));
                    mpost.setViews(rs.getInt("views"));
                    mpost.setLatitude(rs.getDouble("latitude"));
                    mpost.setLongitude(rs.getDouble("longitude"));
                    mpost.setContent(rs.getString("content"));
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
        }

        return mpost;
    }
    
    /* 지도 게시글 쓰기 */
    public int insertPostAndLocation(MpostDTO mpostDTO) {
        int cudCnt = 0;
        Connection con = null;

        String insertPostSQL = "INSERT INTO post (post_id, title, content, post_date, id, board_name, like_cnt, views) " +
        						"VALUES (post_seq.NEXTVAL, ?, ?, SYSDATE, ?, ?, 0, 0)";
        String insertLocationSQL = "INSERT INTO location (location_id, post_id, latitude, longitude) "
        							+ "VALUES (location_seq.NEXTVAL, post_seq.CURRVAL, ?, ?)";
        try {
            con = DBCon.con();
            con.setAutoCommit(false);

            // post 테이블에 데이터 삽입
            try (PreparedStatement pstmtPost = con.prepareStatement(insertPostSQL)) {
                pstmtPost.setString(1, mpostDTO.getTitle());
                pstmtPost.setString(2, mpostDTO.getContent());
                pstmtPost.setString(3, mpostDTO.getUserId());
                pstmtPost.setString(4, mpostDTO.getBoard_name());

                cudCnt += pstmtPost.executeUpdate();
            }

            // location 테이블에 데이터 삽입
            try (PreparedStatement pstmtLocation = con.prepareStatement(insertLocationSQL)) {
                pstmtLocation.setDouble(1, mpostDTO.getLatitude());
                pstmtLocation.setDouble(2, mpostDTO.getLongitude());

                cudCnt += pstmtLocation.executeUpdate();
            }

            // 트랜잭션 커밋 또는 롤백
            if (cudCnt == 2) {
                con.commit();
                System.out.println("CUD 성공");
            } else {
                con.rollback();
                System.out.println("CUD 실패");
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
            try {
                con.rollback();
            } catch (SQLException ex) {
                System.out.println("롤백 에러:" + ex.getMessage());
            }
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
            try {
                con.rollback();
            } catch (SQLException ex) {
                System.out.println("롤백 에러:" + ex.getMessage());
            }
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    System.out.println("Connection 닫기 에러: " + e.getMessage());
                }
            }
        }
        return cudCnt;
    }

    /**
     * 댓글을 데이터베이스에 저장합니다.
     * @param postId  게시글 ID
     * @param userId  사용자 ID
     * @param content 댓글 내용
     * @return 저장 성공 여부
     */
    public boolean addComment(int postId, String userId, String content) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isAdded = false;

        try {
            conn = DBCon.con(); // DBCon 클래스를 이용하여 데이터베이스 연결

            String sql = "INSERT INTO comments (post_id, id, content, reg_date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, userId);
            pstmt.setString(3, content);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            DBCon.close(pstmt, conn); // DBCon 클래스의 close 메서드를 이용하여 자원 해제
        }

        return isAdded;
    }
    /**
     * 특정 게시글의 모든 댓글을 가져옵니다.
     * @param postId 게시글 ID
     * @return 해당 게시글의 모든 댓글 목록
     */
    public List<Comment> getComments(int postId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(*) OVER() AS total_comments FROM comments c WHERE c.post_id = ? ORDER BY c.reg_date DESC";

        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, postId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setUserId(rs.getString("id"));
                    comment.setContent(rs.getString("content"));
                    comment.setRegDate(rs.getTimestamp("reg_date"));
                    comment.setTotalComments(rs.getInt("total_comments"));
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }

        return comments;
    }
    
    
    /*좋아요 버튼 처리*/
    public boolean increaseLikeCount(int postId) {
        String sql = "UPDATE post SET like_cnt = like_cnt + 1 WHERE post_id = ?";
        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            con.setAutoCommit(false); // 트랜잭션 시작
            pstmt.setInt(1, postId);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                con.commit(); // 변경 사항 커밋
                return true;
            } else {
                con.rollback(); // 롤백 처리
                return false;
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
            return false;
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
            return false;
        }
    }

    // 게시글 수정 메서드
    public int updatePost(int postId, String title, String content) {
        int cudCnt = 0;
        String sql = "UPDATE post SET title = ?, content = ? WHERE post_id = ?";

        try (Connection con = DBCon.con(); 
             PreparedStatement pstmt = con.prepareStatement(sql);) {
            con.setAutoCommit(false);

            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, postId);

            cudCnt = pstmt.executeUpdate();
            if (cudCnt > 0) {
                con.commit();
                System.out.println("게시글 수정 성공");
            } else {
                con.rollback();
                System.out.println("게시글 수정 실패");
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
        }
        return cudCnt;
    }

    // 게시글 삭제 메서드
    public int deletePost(int postId) {
        int cudCnt = 0;
        String sql = "DELETE FROM post WHERE post_id = ?";

        try (Connection con = DBCon.con(); 
             PreparedStatement pstmt = con.prepareStatement(sql);) {
            con.setAutoCommit(false);

            pstmt.setInt(1, postId);

            cudCnt = pstmt.executeUpdate();
            if (cudCnt > 0) {
                con.commit();
                System.out.println("게시글 삭제 성공");
            } else {
                con.rollback();
                System.out.println("게시글 삭제 실패");
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
        }
        return cudCnt;
    }

    /* 별점 조회 메서드 */
    public double getPostRatings(int postId) {
        double avgRating = 0.0;
        String sql = "SELECT AVG(score) AS average FROM rating WHERE post_id = ?";

        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    avgRating = rs.getDouble("average");
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러:" + e.getMessage());
        }

        return avgRating;
    }
    
	public static void main(String[] args) {
		LocPostDao dao = new LocPostDao();

	}
}
