package forwarders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import fmember.ForwardersMemberBean;

public class FclQuotationMgr {

	private DBConnectionMgr pool;
	
	public FclQuotationMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	

	public boolean insertFclQuotation(FclQuotationBean fclq) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert fclQuotation(fclno,pickupRate,stuffingRate,lashingRate,ofRate,lssebs,thcRate,otherRate,amsRate,vgmRate,handlingRate,oftype,carrier,tt,validity,date,state,userID) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?     ,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fclq.getFclno());
			pstmt.setInt(2, fclq.getPickupRate());
			pstmt.setInt(3, fclq.getStuffingRate());
			pstmt.setInt(4, fclq.getLashingRate());
			pstmt.setInt(5, fclq.getOfRate());
			pstmt.setInt(6, fclq.getLssebs());
			pstmt.setInt(7, fclq.getThcRate());
			pstmt.setInt(8, fclq.getOtherRate());
			pstmt.setInt(9, fclq.getAmsRate());
			pstmt.setInt(10, fclq.getVgmRate());
			pstmt.setInt(11, fclq.getHandlingRate());
			pstmt.setString(12, fclq.getOftype());
			pstmt.setString(13,  fclq.getCarrier());
			pstmt.setString(14, fclq.getTt());
			pstmt.setString(15, fclq.getValidity());
			pstmt.setString(16, UtilMgr.getDay());
			pstmt.setString(17, "1");
			pstmt.setString(18, fclq.getUserID());
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Detail
	public FclQuotationBean getFclQuotationeDetail(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		FclQuotationBean quotation = new FclQuotationBean();
		try {
			con = pool.getConnection();
			sql = "select * from fclQuotation where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				quotation.setNo(rs.getInt("no"));
				quotation.setFclno(rs.getInt("fclno"));
				quotation.setPickupRate(rs.getInt("pickupRate"));
				quotation.setStuffingRate(rs.getInt("stuffingRate"));
				quotation.setLashingRate(rs.getInt("lashingRate"));
				quotation.setPickupRate(rs.getInt("pickupRate"));
				quotation.setOfRate(rs.getInt("thcRate"));
				quotation.setOfRate(rs.getInt("ofRate"));
				quotation.setLssebs(rs.getInt("lssebs"));
				quotation.setOtherRate(rs.getInt("otherRate"));
				quotation.setAmsRate(rs.getInt("amsRate"));
				quotation.setVgmRate(rs.getInt("vgmRate"));
				quotation.setHandlingRate(rs.getInt("handlingRate"));
				
				quotation.setOftype(rs.getString("oftype"));
				quotation.setCarrier(rs.getString("carrier"));
				quotation.setTt(rs.getString("tt"));
				quotation.setValidity(rs.getString("validity"));
				quotation.setDate(rs.getString("date"));
				quotation.setState(rs.getString("state"));
				quotation.setUserID(rs.getString("userID"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return quotation;
	}
	
	//list(사용자용)
	public Vector<FclQuotationBean> getFclQuotationList(String userID){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FclQuotationBean> vlist = new Vector<FclQuotationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from fclQuotation where userID=? order by no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FclQuotationBean quotation = new FclQuotationBean();
				quotation.setNo(rs.getInt("no"));
				quotation.setFclno(rs.getInt("fclno"));
				quotation.setPickupRate(rs.getInt("pickupRate"));
				quotation.setStuffingRate(rs.getInt("stuffingRate"));
				quotation.setLashingRate(rs.getInt("lashingRate"));
				quotation.setPickupRate(rs.getInt("ofRate"));
				quotation.setOfRate(rs.getInt("lssebs"));
				quotation.setLssebs(rs.getInt("thcRate"));
				quotation.setOtherRate(rs.getInt("otherRate"));
				quotation.setAmsRate(rs.getInt("amsRate"));
				quotation.setVgmRate(rs.getInt("vgmRate"));
				quotation.setHandlingRate(rs.getInt("handlingRate"));
				quotation.setOftype(rs.getString("oftype"));
				quotation.setCarrier(rs.getString("carrier"));
				quotation.setTt(rs.getString("tt"));
				quotation.setValidity(rs.getString("validity"));
				quotation.setDate(rs.getString("date"));
				quotation.setState(rs.getString("state"));
				quotation.setUserID(rs.getString("userID"));
				vlist.addElement(quotation);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Order All List(포워딩 회사 용)
	public Vector<FclQuotationBean> getFclQuotationList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FclQuotationBean> vlist = new Vector<FclQuotationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from fclQuotation order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FclQuotationBean quotation = new FclQuotationBean();
				quotation.setNo(rs.getInt("no"));
				quotation.setFclno(rs.getInt("fclno"));
				quotation.setPickupRate(rs.getInt("pickupRate"));
				quotation.setStuffingRate(rs.getInt("stuffingRate"));
				quotation.setLashingRate(rs.getInt("lashingRate"));
				quotation.setPickupRate(rs.getInt("ofRate"));
				quotation.setOfRate(rs.getInt("lssebs"));
				quotation.setLssebs(rs.getInt("thcRate"));
				quotation.setOtherRate(rs.getInt("otherRate"));
				quotation.setAmsRate(rs.getInt("amsRate"));
				quotation.setVgmRate(rs.getInt("vgmRate"));
				quotation.setHandlingRate(rs.getInt("handlingRate"));
				quotation.setOftype(rs.getString("oftype"));
				quotation.setCarrier(rs.getString("carrier"));
				quotation.setTt(rs.getString("tt"));
				quotation.setValidity(rs.getString("validity"));
				quotation.setDate(rs.getString("date"));
				quotation.setState(rs.getString("state"));
				quotation.setUserID(rs.getString("userID"));
				vlist.addElement(quotation);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
}
