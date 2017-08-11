package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection conn= null;
	private PreparedStatement pstmt = null;
	private ResultSet rs= null;
	
	public MemberDAO() {
		try {
			String jdbcDriver	= "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbUser		= "scott";
			String dbPass		= "tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		
		String query = "SELECT userPassword FROM MEMBER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치				
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(Member member) {
		String query = "INSERT INTO MEMBER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getUserID());
			pstmt.setString(2, member.getUserPassword());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getUserGender());
			pstmt.setString(5, member.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
}
