package member;

import java.io.Console;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/member/userRegister")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글인코딩 테스트 (UTF-8에서 EUC-KR로 변경)
		request.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html; charset=EUC-KR");
		
		//한글인코딩 테스트
		//String param = request.getParameter("param");
		//request.getParameter("param"); 
		
		String userID = request.getParameter("userID");
		//한글인코딩 테스트
		//System.out.println(userID);
		
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userProfile = request.getParameter("userProfile");

		if( userID==null || userID.equals("") || userPassword1==null ||userPassword1.equals("") ||
			userPassword2==null	|| userPassword2.equals("") ||userName==null || userName.equals("") ||
			userAge==null || userAge.equals("") ||userGender==null || userGender.equals("") ||
			userEmail==null || userEmail.equals("")) {
				
				request.getSession().setAttribute("messageType", "오류 메시지");
				request.getSession().setAttribute("messageContent", "모든 내용 입력하세요");
				response.sendRedirect("../member/join.jsp");
				return;
			}
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "비밀번호가 맞지 않습니다.");
			response.sendRedirect("../member/join.jsp");
			return;
		}
		int result = new UserDAO().register(userID, userPassword1, userName, userAge, userGender, userEmail,"");
		if(result==1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공메시지");
			request.getSession().setAttribute("messageContent", "회원가입 성공.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		else {
			
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "이미 존재하는 회원.");
			response.sendRedirect("../member/join.jsp");
			return;
		}
		
	}

}
