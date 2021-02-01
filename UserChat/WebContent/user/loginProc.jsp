<%@page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="fmember.ForwardersMemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String msg = "로그인에 실패 하였습니다.";
		
		boolean result = mMgr.loginMember(id, password);
		if(result){
		  session.setAttribute("idKey",id);
		  msg = "로그인에 성공 하였습니다.";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "../forwarders/index.jsp";
</script>