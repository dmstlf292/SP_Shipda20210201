<%@page import="forwarders.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="quotationMgr" class="forwarders.FclQuotationMgr"/>
<jsp:useBean id="fqbean" class="forwarders.FclQuotationBean"/>
<jsp:setProperty property="*" name="fqbean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String flag = request.getParameter("flag");
		int pickupRate = Integer.parseInt(request.getParameter("pickupRate"));
		
		System.out.println("����׽�Ʈ1"+pickupRate);
		
		fqbean.setPickupRate(pickupRate);
		
		System.out.println("bean�� üũ"+fqbean.getPickupRate());	
		
		//fclReply �μ�Ʈ
		boolean result= quotationMgr.insertFclQuotation(fqbean);
		
		String msg="���� ���� ����";//����
		String url="fclReply.jsp";
		if(result){
			msg="��ϼ���";
			url="mypage.jsp";
		}

%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>