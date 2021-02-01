package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/member/userUpdate")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글인코딩 테스트 (UTF-8에서 EUC-KR로 변경)
		request.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html; charset=EUC-KR");
		
		//한글인코딩 테스트
		String param = request.getParameter("param");
		request.getParameter("param"); 

		String userID = request.getParameter("userID");
		//한글인코딩 테스트
		System.out.println(userID);
		HttpSession session = request.getSession();
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");

		if( userID==null || userID.equals("") ||
			userPassword1==null ||userPassword1.equals("") ||
			userPassword2==null	|| userPassword2.equals("") ||
			userName==null || userName.equals("") ||
			userAge==null || userAge.equals("") ||
			userGender==null || userGender.equals("")||
			userEmail==null || userEmail.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "모든 내용 입력하세요");
			response.sendRedirect("../member/update.jsp");
		    return;
			}
		if(!userID.equals((String) session.getAttribute("userID"))) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "비밀번호가 맞지 않습니다.");
			response.sendRedirect("../member/update.jsp");
			return;
		}
		int result = new UserDAO().update(userID, userPassword1, userName, userAge, userGender, userEmail);
		if(result==1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공메시지");
			request.getSession().setAttribute("messageContent", "회원수정 성공.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		else {
			
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "디비 오류 발생");
			response.sendRedirect("../member/update.jsp");
			return;
		}
		
	}

}
