package quote;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LclMgr {
	
	private DBConnectionMgr pool;
	
	public LclMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public boolean insertLcl(LclBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			int ref = getMaxNoLcl() + 1;
			con = pool.getConnection();
			sql = "insert lcl(departure,port,address,transit,arrive,aport,aAddress,aTransit,incoterms,packingType,item,danger,stackable,lss,surcharge,extra,client,volumeUnit,weightUnit,regdate,         ref,pos,depth,count,width,llength,height,volume,packageCount) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),    ?,0,0,0,?,?,?,?,?)";
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
			pstmt.setString(10, bean.getPackingType());
			pstmt.setString(11, bean.getItem());
			pstmt.setString(12, bean.getDanger());
			pstmt.setString(13, bean.getStackable());
			pstmt.setString(14, bean.getLss());
			pstmt.setString(15, bean.getSurcharge());
			pstmt.setString(16, bean.getExtra());
			pstmt.setString(17, bean.getClient());
			pstmt.setString(18, bean.getVolumeUnit());
			pstmt.setString(19, bean.getWeightUnit());
			
			
			
			pstmt.setInt(20, ref);
			pstmt.setInt(21, bean.getWidth());
			pstmt.setInt(22, bean.getLlength());
			pstmt.setInt(23, bean.getHeight());
			pstmt.setInt(24, bean.getVolume());
			pstmt.setInt(25, bean.getPackageCount());
			
			if(pstmt.executeUpdate()==1) flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public int getMaxNoLcl() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNo = 0;
		try {
			con = pool.getConnection();
			sql = "select max(no) from lcl";
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
	public int getTotalCountLcl(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select count(*) from lcl";
				pstmt = con.prepareStatement(sql);
			}else {
				//검색인 경우
				sql = "select count(*) from lcl where " 
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
	public Vector<LclBean> getBoardListLcl(String keyField, String keyWord, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LclBean> vlist = new Vector<LclBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닐때
				sql = "select * from lcl order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//검색일때
				sql = "select * from lcl where " + keyField 
						+ " like ? order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				LclBean bean = new LclBean();
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
				bean.setPackingType(rs.getString("packingType"));
				bean.setItem(rs.getString("item"));
				bean.setDanger(rs.getString("danger"));
				bean.setStackable(rs.getString("stackable"));
				bean.setLss(rs.getString("lss"));
				bean.setSurcharge(rs.getString("surcharge"));
				bean.setExtra(rs.getString("extra"));
				bean.setClient(rs.getString("client"));
				bean.setVolumeUnit(rs.getString("volumeUnit"));
				bean.setWeightUnit(rs.getString("weightUnit"));
				bean.setRegdate(rs.getString("regdate"));
				
				
				bean.setRef(rs.getInt("ref"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setCount(rs.getInt("count"));
				bean.setWidth(rs.getInt("width"));
				bean.setLlength(rs.getInt("llength"));
				bean.setHeight(rs.getInt("height"));
				bean.setVolume(rs.getInt("volume"));
				bean.setPackageCount(rs.getInt("packageCount"));
				
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
	public LclBean getLcl(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LclBean bean = new LclBean();
		try {
			con = pool.getConnection();
			sql = "select * from lcl where no = ?";
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
				bean.setPackingType(rs.getString("packingType"));
				bean.setItem(rs.getString("item"));
				bean.setDanger(rs.getString("danger"));
				bean.setStackable(rs.getString("stackable"));
				bean.setLss(rs.getString("lss"));
				bean.setSurcharge(rs.getString("surcharge"));
				bean.setExtra(rs.getString("extra"));
				bean.setClient(rs.getString("client"));
				bean.setVolumeUnit(rs.getString("volumeUnit"));
				bean.setWeightUnit(rs.getString("weightUnit"));
				bean.setRegdate(rs.getString("regdate"));
				
				
				bean.setRef(rs.getInt("ref"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setCount(rs.getInt("count"));
				bean.setWidth(rs.getInt("width"));
				bean.setLlength(rs.getInt("llength"));
				bean.setHeight(rs.getInt("height"));
				bean.setVolume(rs.getInt("volume"));
				bean.setPackageCount(rs.getInt("packageCount"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	
	
	public void upCountLcl(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update lcl set count = count +1 where no = ?";
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
