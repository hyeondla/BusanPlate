package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
	public void insertBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmtnum = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			int num=0;
			String sqlnum = "select max(num) from board";
			pstmtnum = con.prepareStatement(sqlnum);
			rs = pstmtnum.executeQuery();
			if(rs.next()){
				num=rs.getInt("max(num)")+1;
				bb.setNum(num);
			}
			String sql = "insert into board(num,name,subject,content,readcount,date,id) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getSubject());
			pstmt.setString(4, bb.getContent());
			pstmt.setInt(5, bb.getReadcount());
			pstmt.setTimestamp(6, bb.getDate());
			pstmt.setString(7, bb.getId());
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
	
	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from board order by num desc limit ?, ?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setId(rs.getString("id"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return boardList;
	}
	
	public int getBoardCount() {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select count(*) from board"; 
			pstmt = con.prepareStatement(sql);
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
	
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update board set readcount=readcount+1 where num=?";
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
	
	public BoardBean getBoard(int num) {
		BoardBean bb = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setId(rs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return bb;
	}
	
	public void updateBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			String sql = "update board set subject=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "delete from board where num=?";
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
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from board where subject like ? order by num desc limit ?, ?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setId(rs.getString("id"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return boardList;
	}
	
	public int getBoardCount(String search) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select count(*) from board where subject like ?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
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
	
	public List<BoardBean> getMyBoardList(int startRow, int pageSize, String id) {
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select * from board where id=?order by num desc limit ?, ?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setId(rs.getString("id"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return boardList;
	}
	
	public int getMyBoardCount(String id) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs  = null;
		try {
			con = getConnection();
			String sql = "select count(*) from board where id=?"; 
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
