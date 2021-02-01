package quote;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class FclMgr {
	
	private DBConnectionMgr pool;
	
	public FclMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public boolean insertFcl(FclBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			int ref = getMaxNoFcl() + 1;
			con = pool.getConnection();
			sql = "insert fcl(departure,port,address,transit,arrive,aport,aAddress,aTransit,incoterms,item,ctype,csize,danger,lss,surcharge,extra,      regdate,ref,pos,depth,count, client,volume) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,     now(),?,0,0,0,?,?)";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getDeparture());
			pstmt.setString(2, bean.getPort());
			pstmt.setString(3, bean.getAddress());
			pstmt.setString(4, bean.getTransit());
			pstmt.setString(5, bean.getArrive());
			pstmt.setString(6, bean.getAport());
			pstmt.setString(7, bean.getaAddress());
			pstmt.setString(8, bean.getaTransit());
			pstmt.setString(9, bean.getIncoterms());
			pstmt.setString(10, bean.getItem());
			pstmt.setString(11, bean.getCtype());
			pstmt.setString(12, bean.getCsize());
			pstmt.setString(13, bean.getDanger());
			pstmt.setString(14, bean.getLss());
			pstmt.setString(15, bean.getSurcharge());
			pstmt.setString(16, bean.getExtra());
			pstmt.setInt(17, ref);//답변 설정때문에 int형이라도 ?작성후 string처럼 여기 적어줘야함
			//pstmt.setInt(19, bean.getPos());//int형 =0, 여기 안적음
			//pstmt.setInt(20, bean.getDepth());//int형 =0, 여기 안적음
			//pstmt.setInt(19, bean.getCount());//int형 =0, 여기 안적음
			pstmt.setString(18,  bean.getClient());
			pstmt.setInt(19,bean.getVolume());
			
			if(pstmt.executeUpdate()==1) flag = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public int getMaxNoFcl() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNo = 0; 
		try {
			con = pool.getConnection();
			sql = "select max(no) from fcl";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNo = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNo;
	}
	
	//총 게시물 수
	public int getTotalCountFcl(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select count(*) from fcl";
				pstmt = con.prepareStatement(sql);
			}else {
				//검색인 경우
				sql = "select count(*) from fcl where " 
				+ keyField +" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	
	//검색기능
	public Vector<FclBean> getBoardListFcl(String keyField, String keyWord, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FclBean> vlist = new Vector<FclBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닐때
				sql = "select * from fcl order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//검색일때
				sql = "select * from fcl where " + keyField 
						+ " like ? order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FclBean bean = new FclBean();
				bean.setNo(rs.getInt("no"));
				bean.setDeparture(rs.getString("departure"));
				bean.setPort(rs.getString("port"));
				bean.setAddress(rs.getString("address"));
				bean.setTransit(rs.getString("transit"));
				bean.setArrive(rs.getString("arrive"));
				bean.setAport(rs.getString("aport"));
				bean.setaAddress(rs.getString("aAddress"));
				bean.setaTransit(rs.getString("aTransit"));
				bean.setIncoterms(rs.getString("incoterms"));
				bean.setItem(rs.getString("item"));
				bean.setCtype(rs.getString("ctype"));
				bean.setCsize(rs.getString("csize"));
				bean.setDanger(rs.getString("danger"));
				bean.setLss(rs.getString("lss"));
				bean.setSurcharge(rs.getString("surcharge"));
				bean.setExtra(rs.getString("extra"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setRef(rs.getInt("ref"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setCount(rs.getInt("count"));
				bean.setClient(rs.getString("client"));
				bean.setVolume(rs.getInt("volume"));
				
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	
	
	
	
	
	
	///fcl게시글 읽기--> 배열////
	public FclBean getFcl(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		FclBean bean = new FclBean();
		try {
			con = pool.getConnection();
			sql = "select * from fcl where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNo(rs.getInt("no"));
				bean.setDeparture(rs.getString("departure"));
				bean.setPort(rs.getString("port"));
				bean.setAddress(rs.getString("address"));
				bean.setTransit(rs.getString("transit"));
				bean.setArrive(rs.getString("arrive"));
				bean.setAport(rs.getString("aport"));
				bean.setaAddress(rs.getString("aAddress"));
				bean.setaTransit(rs.getString("aTransit"));
				bean.setIncoterms(rs.getString("incoterms"));
				bean.setItem(rs.getString("item"));
				bean.setCtype(rs.getString("ctype"));
				bean.setCsize(rs.getString("csize"));
				bean.setDanger(rs.getString("danger"));
				bean.setLss(rs.getString("lss"));
				bean.setSurcharge(rs.getString("surcharge"));
				bean.setExtra(rs.getString("extra"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setRef(rs.getInt("ref"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setCount(rs.getInt("count"));
				bean.setClient(rs.getString("client"));
				bean.setVolume(rs.getInt("volume"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	
	
	public void upCountFcl(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update fcl set count = count +1 where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
}
