<%@page import="forwarders.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="quotationMgr" class="forwarders.FclQuotationMgr"/>
<jsp:useBean id="fqbean" class="forwarders.FclQuotationBean"/>
<jsp:setProperty property="*" name="fqbean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String flag = request.getParameter("flag");
		int pickupRate = Integer.parseInt(request.getParameter("pickupRate"));
		
		System.out.println("출력테스트1"+pickupRate);
		
		fqbean.setPickupRate(pickupRate);
		
		System.out.println("bean값 체크"+fqbean.getPickupRate());	
		
		//fclReply 인설트
		boolean result= quotationMgr.insertFclQuotation(fqbean);
		
		String msg="견적 제출 실패";//오류
		String url="fclReply.jsp";
		if(result){
			msg="등록성공";
			url="mypage.jsp";
		}

%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>