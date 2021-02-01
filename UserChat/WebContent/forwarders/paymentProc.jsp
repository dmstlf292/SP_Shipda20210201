<%@page import="forwarders.PaidBean"%>
<%@page import="java.util.Hashtable"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" scope="session" class="fmember.ForwardersMemberMgr"/>
<jsp:useBean id="pMgr" class="forwarders.MonthMgr"/>
<jsp:useBean id="paidMgr" class="forwarders.PaidMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		//apply_num & paid_amount값을 DB에 연동
		int apply_num = Integer.parseInt(request.getParameter("apply_num"));
		int paid_amount = Integer.parseInt(request.getParameter("paid_amount"));
		/* String msg = "카드승인번호 및 승인금액 : "+ apply_num + " : "  + paid_amount; */
		
		String msg="카드승인번호 및 승인금액 : "+ apply_num + " : "  + paid_amount;
	
	
%>
<script>
	alert("<%=msg%>");
	location.href="<%=request.getContextPath()%>/forwarders/index.jsp";
</script>

