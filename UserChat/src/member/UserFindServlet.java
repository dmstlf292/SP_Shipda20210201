package member;

import java.io.Console;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/member/userFind")
public class UserFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html; charset=EUC-KR");
		String userID = request.getParameter("userID");
		
		if( userID==null || userID.equals("") ) {
			response.getWriter().write("-1");//오류메시지 출력
		}else if(new UserDAO().registerCheck(userID)==0) {
			try {
				response.getWriter().write(find(userID));
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("-1");//오류발생
			}//정상적으로 회원가입이 된 사용자일때 출력
		}else {
			response.getWriter().write("-1");//회원가입이 안 된 사용자
		}
	}
	public String find(String userID) throws Exception{
		StringBuffer result = new StringBuffer("");
		result.append("{\"userProfile\":\"" + new UserDAO().getProfile(userID)+"\"}");
		return result.toString();
	}

}
