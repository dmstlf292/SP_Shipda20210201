package fmember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ForwardersMemberMgr {
	
	private DBConnectionMgr pool;
	
	public ForwardersMemberMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public boolean loginMember(String id, String password) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from forwardersMember where id=? and password=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
}
