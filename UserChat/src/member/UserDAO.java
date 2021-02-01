package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.jdbc.Statement;

public class UserDAO {
	//커넥션 풀 이용 준비
	DataSource dataSource;
	//생성자
	public UserDAO() {
		try {
			//db접속 //이닛컨텍만들고 //컨텍접근 // 데이터소스 초기화 네임으로 접근//
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
		}catch (Exception e) {
		}
	}
	//회원 데이터 베이스 처리용 함수
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE userID = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				//입력 pw와 db pw가 동일하다면
				if(rs.getString("userPassword").equals(userPassword)) {
					return 1; //로그인 성공
				}
					return 2;//비밀번호 오류
			}else {
				return 0; //해당 사용자가 존재하지 않음
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	//아이디 중복 체크
	public int registerCheck(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE userID = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()||userID.equals("")) {
				return 0; //이미 존재하는 회원
				}else {
					return 1; //가입가능 아이디
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public UserDTO getUser(String userID) {
		UserDTO user = new UserDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE userID = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserAge(rs.getInt("userAge"));
				user.setUserGender(rs.getString("userGender"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserProfile(rs.getString("userProfile"));
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return user;
	}
	//회원가입 시도
	public int register(String userID, String userPassword,String userName,String userAge,String userGender,String userEmail,String userProfile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?)";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setInt(4, Integer.parseInt(userAge));
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, userProfile);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public int update(String userID, String userPassword,String userName,String userAge,String userGender,String userEmail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "update user set userPassword = ? , userName = ? ,userAge = ? ,userGender=?, userEmail = ? where userID=?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setInt(3, Integer.parseInt(userAge));
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public int profile(String userID, String userProfile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "update user set userProfile = ? where userID=?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userProfile);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public String getProfile(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userProfile FROM USER WHERE userID = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				if(rs.getString("userProfile").equals("")||rs.getString("userProfile")==null) {
					//기본 아이콘 
					return "/UserChat/member/images/icon.png";
				}
				return "/UserChat/member/images/" + rs.getString("userProfile");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return  "/UserChat/member/images/icon.png";
	}

}
