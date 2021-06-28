package reviewcomment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewCommentDAO {
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	public void insertComment(ReviewCommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmtnum = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			int num=0;
			String sqlnum = "select max(num) from reviewcomment";
			pstmtnum = con.prepareStatement(sqlnum);
			rs = pstmtnum.executeQuery();
			if(rs.next()){
				num=rs.getInt("max(num)")+1;
				cb.setNum(num);
			}
			String sql = "insert into reviewcomment(num,id,name,content,boardnum,date) values(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cb.getNum());
			pstmt.setString(2, cb.getId());
			pstmt.setString(3, cb.getName());
			pstmt.setString(4, cb.getContent());
			pstmt.setInt(5, cb.getBoardnum());
			pstmt.setTimestamp(6, cb.getDate());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmtnum != null) {try { pstmtnum.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public List<ReviewCommentBean> getCommentList(int boardnum) {
		List<ReviewCommentBean> CommentList = new ArrayList<ReviewCommentBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from reviewcomment where boardnum=? order by num"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewCommentBean cb = new ReviewCommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setName(rs.getString("name"));
				cb.setContent(rs.getString("content"));
				cb.setBoardnum(rs.getInt("boardnum"));
				cb.setDate(rs.getTimestamp("date"));
				CommentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return CommentList;
	}
	
	public void deleteCommentAll(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "delete from reviewcomment where boardnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public void updateComment(ReviewCommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			String sql = "update reviewcomment set content=?, date=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cb.getContent());
			pstmt.setTimestamp(2, cb.getDate());
			pstmt.setInt(3, cb.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public ReviewCommentBean getComment(int num) {
		ReviewCommentBean cb = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from reviewcomment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cb = new ReviewCommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setBoardnum(rs.getInt("boardnum"));
				cb.setName(rs.getString("name"));
				cb.setContent(rs.getString("content"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setId(rs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return cb;
	}
	
	public void deleteComment(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "delete from reviewcomment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public int getCommentCount(int num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select count(*) from reviewcomment where boardnum=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return count;
	}
	
	public List<ReviewCommentBean> getMyCommentList(int startRow, int pageSize, String id) {
		List<ReviewCommentBean> commentList = new ArrayList<ReviewCommentBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from reviewcomment where id=?order by num desc limit ?, ?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewCommentBean cb = new ReviewCommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setName(rs.getString("name"));
				cb.setContent(rs.getString("content"));
				cb.setBoardnum(rs.getInt("boardnum"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setId(rs.getString("id"));
				commentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return commentList;
	}
	
	public int getMyCommentCount(String id) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select count(*) from reviewcomment where id=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return count;
	}
	
}
