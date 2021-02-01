package chatting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import member.DBConnectionMgr;

public class ChatDAO {

	private DBConnectionMgr pool;
	
	public ChatDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public ArrayList<ChatDTO> getChatListByID(String fromID, String toID, String chatID){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChatDTO> chatList= null;
		String SQL = "SELECT * FROM CHAT WHERE ((fromID=? and toID=?) or (fromID= ? and toID =?)) and chatID >  ? order by chatTime";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + chatTime + ":" + rs.getString("chatTime").substring(14,16)+ "");
				chatList.add(chat);
			}
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	
	
	//대화 내역중 최근 몇개만 뽑아서 가져오기
	public ArrayList<ChatDTO> getChatListByRecent(String fromID, String toID, int number){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<ChatDTO> chatList = null;
		try {
			con = pool.getConnection();
			sql = "select * from chat where ((fromID=? AND toID=?) or (fromID=? and toID=?)) and chatID > (select max(chatId) - ? from chat) order by chatTime";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, number);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType="오전";
				if(chatTime >= 12) {
					timeType="오후";
					chatTime-=12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16) + "");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return chatList;//리스트반환
	}
	
	
	public ArrayList<ChatDTO> getBox(String userID){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<ChatDTO> chatList = null;
		try {
			con = pool.getConnection();
			sql = "select*from chat where chatID in (select max(chatID) from chat where toID=? or fromID =? group by fromID, toID)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType="오전";
				if(chatTime >= 12) {
					timeType="오후";
					chatTime-=12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16) + "");
				chatList.add(chat);
			}
			//가장 최신의 메시지 1개 출력하기!!
			for(int i=0 ; i<chatList.size(); i++) {
				ChatDTO x = chatList.get(i);
				for(int j=0; j<chatList.size(); j++) {
					ChatDTO y = chatList.get(j);
					if(x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID())) {
						if(x.getChatID()<y.getChatID()) {
							chatList.remove(x);
							i--;
							break;
						}else {
							chatList.remove(y);
							j--;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return chatList;//리스트반환
	}
	
	
	
	
	//채팅 전송기능, 전송여부 int로
	public int submit(String fromID, String toID, String chatContent){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
	
		try {
			con = pool.getConnection();
			sql = "insert into chat values(null,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, chatContent);
			//실행한 결과를 반환시켜주기, 성공하면 1 반환됨
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;//디비 오류, -1값은 반환될 수 없는 값
	}
	
	public int readChat(String fromID, String toID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update chat set chatRead =1 where (fromID=? and toID=?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
			//실행된 결과를 바로 반환할 수 있도록 만들어주기
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1;//실패시->디비오류
	}	
	
	public int getAllUnreadChat(String userID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select count(chatID) from chat where toID=? AND chatRead=0" ;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				return rs.getInt("count(chatID)");
			}
			//그렇지 않다면 = 받은 메시지가 없다면
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}	
	
	//대화상대별 안 읽은 메시지 출력
	public int getUnreadChat(String fromID, String toID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select count(chatID) from chat where toID = ? and fromID=? and chatRead=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			rs = pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				return rs.getInt("count(chatID)");
			}
			//그렇지 않다면 = 받은 메시지가 없다면
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}	
	
	
	
}
