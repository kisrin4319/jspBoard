package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {

	private Connection conn= null;
	private ResultSet rs= null;
	
	public BbsDAO() {
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
	
	public String getDate() {
		String query = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	public int getNext() {
		String query = "SELECT numb from bbs order by num desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시글인 경우에만
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int write(String title, String userID, String Content) {
		String query = "INSERT INTO BBS VALUE (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setInt(6, 1);
					
			rs = pstmt.executeQuery();
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
