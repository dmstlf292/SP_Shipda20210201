package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/userLogin")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html;charset=EUC-KR");
		
		String userID= request.getParameter("userID");
		String userPassword= request.getParameter("userPassword");
		if(userID==null || userID.equals("") || userPassword ==null || userPassword.equals("")) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "모든내용을 입력하세요");
			response.sendRedirect("../member/login.jsp");
			return;
		}
		int result = new UserDAO().login(userID, userPassword);
		//DAO 만들었던것 참조하기
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공메시지");
			request.getSession().setAttribute("messageContent", "로그인 성공");
			response.sendRedirect("../index/index.jsp");
		}
		else if(result == 2) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "비밀번호 다시 확인하세요");
			response.sendRedirect("../member/login.jsp");
		}else if(result == 0) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "존재하지 않는 아이디");
			response.sendRedirect("../member/login.jsp");
		}else if(result == -1) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "디비 오류");
			response.sendRedirect("../member/login.jsp");
		}
	}

}
