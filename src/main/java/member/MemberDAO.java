package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "insert into member(id,pass,name,birth,gender,email,postcode,road_address,detail_address,phone,date) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getBirth());
			pstmt.setString(5, mb.getGender());
			pstmt.setString(6, mb.getEmail());
			pstmt.setString(7, mb.getPostcode());
			pstmt.setString(8, mb.getRoad_address());
			pstmt.setString(9, mb.getDetail_address());
			pstmt.setString(10, mb.getPhone());
			pstmt.setTimestamp(11, mb.getDate());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public MemberBean userCheck(String id, String pass) {
		MemberBean mb = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from member where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mb = new MemberBean();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return mb;
	}
	
	public MemberBean dupCheck(String column, String value) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean mb = null;
		try {
			con = getConnection();
			String sql = "";
			if(column.equals("id")) {
				sql = "select * from member where id=?";
			} else if(column.equals("name")) {
				sql = "select * from member where name=?";
			} else if(column.equals("email")) {
				sql = "select * from member where email=?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, value);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mb = new MemberBean();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return mb;
	}
	
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean mb = null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setBirth(rs.getString("birth"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setPostcode(rs.getString("postcode"));
				mb.setRoad_address(rs.getString("road_address"));
				mb.setDetail_address(rs.getString("detail_address"));
				mb.setPhone(rs.getString("phone"));
				mb.setDate(rs.getTimestamp("date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
		return mb;
	}
	
	public void updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update member set name=?, postcode=?, road_address=?, detail_address=?, phone=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,mb.getName());
			pstmt.setString(2,mb.getPostcode());
			pstmt.setString(3,mb.getRoad_address());
			pstmt.setString(4,mb.getDetail_address());
			pstmt.setString(5,mb.getPhone());
			pstmt.setString(6,mb.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	public void deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "delete from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
			if(con != null) {try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }}
		}
	}
	
	
	
	
	
}
