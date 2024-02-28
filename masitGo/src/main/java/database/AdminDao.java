package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Member;


public class AdminDao {
	
	/* 회원정보조회 메서드 */
	public List<Member> schMember(String id, String name){
		List<Member> memList = new ArrayList<Member>();
		String sql = "SELECT * FROM Member \r\n"
				+ "WHERE id LIKE ? OR name LIKE ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setString(1,"%"+id+"%");
			pstmt.setString(2,"%"+name+"%");
			try(ResultSet rs = pstmt.executeQuery();){
				//처리코드2
				while(rs.next()) {
					memList.add(new Member(
							rs.getString("name"),
							rs.getString("id"),
							rs.getString("password"),
							rs.getString("birthday"),
							rs.getString("email"),
							rs.getString("hp"),
							rs.getString("authority")
							));
				}
				System.out.println("조회된 데이터 수:"+memList.size());
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return memList;
	}
}
