package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBCon {
	// 데이터베이스 서버 연동 처리..
	// 1. 연동 기능 메서드..
	//		1) 기본 접속정보
	private static final String 
		URL ="jdbc:oracle:thin:@211.63.89.67:1521:xe";
	//			드라이버정보:@ip:port:DB명		
	private static final String USERNAME ="group4";
	private static final String PASSWORD ="0530";
	public static Connection con() throws SQLException, ClassNotFoundException{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection(URL,USERNAME,PASSWORD);
	}
	// 2. DB 처리한 후, 자원을 해제하는 공통 기능 메서드
	//	  AutoCloseable... resources : 여러개의 객체를 매개변수로
	//	  받아서 처리할 때, 사용하는 형태로 배열로 받는다.
	public static void close(AutoCloseable... resources) {
		for(AutoCloseable resource:resources) {
			if(resources!=null) {
				
				try {
					resource.close();
				} catch (Exception e) {
					// 해당 클래스의 예외가 나올 때 처리
					System.out.println(resource.getClass().getSimpleName());
					System.out.println("닫기 실패");
				}
			}
		}
		System.out.println("자원해제처리!");
	}
	
    // 롤백 기능 추가
    public static void rollback(Connection con) {
        if (con != null) {
            try {
                con.rollback();
                System.out.println("롤백 성공");
            } catch (SQLException e) {
                System.out.println("롤백 실패: " + e.getMessage());
            }
        }
    }
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
//		try {
//			close( con() );
//			System.out.println("접속 성공!");
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			System.out.println("에러발생:"+e.getMessage());
//		}
	}

}
