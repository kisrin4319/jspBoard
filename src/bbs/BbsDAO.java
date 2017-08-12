package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

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
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT sysdate FROM bbs");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getString(1));
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	public int getNext() {
		String query = "SELECT numb from bbs order by numb desc";
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
	
	public int write(Bbs bbs) {
		String query = "INSERT INTO bbs(numb,title,userid,datetime,content,available) VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbs.getTitle());
			pstmt.setString(3, bbs.getUserid());
			pstmt.setTimestamp(4, bbs.getDatetime());
			pstmt.setString(5, bbs.getContent());
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			String query = "select * from bbs where (numb < ? and available = 1) and rownum <=10 order by numb desc";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNumb(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserid(rs.getString(3));
				bbs.setDatetime(rs.getTimestamp(4));
				bbs.setContent(rs.getString(5));
				bbs.setAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber) {
		String query = "select * from bbs where numb < ? and available =1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int numb) {
		String query = "select * from bbs where numb =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNumb(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserid(rs.getString(3));
				bbs.setDatetime(rs.getTimestamp(4));
				bbs.setContent(rs.getString(5));
				bbs.setAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(Bbs bbs) {
		String query = "update bbs set title =?, content=? where numb =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, bbs.getTitle());
			pstmt.setString(2, bbs.getContent());
			pstmt.setInt(3, bbs.getNumb());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int numb) {
		String query = "update bbs set available =0 where numb =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, numb);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
