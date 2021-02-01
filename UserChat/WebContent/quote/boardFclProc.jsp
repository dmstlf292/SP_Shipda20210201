<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fcl" class="quote.FclMgr"/>
<jsp:useBean id="fclbean" class="quote.FclBean"/>
<jsp:setProperty property="*" name="fclbean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String flag = request.getParameter("flag");
		String getTransit = request.getParameter("transit");
		String getaTransit = request.getParameter("aTransit");
		String getAddress = request.getParameter("address");
		String getaAddress = request.getParameter("aAddress");
		
		System.out.println("출발지 내륙 상세주소 파라미터: "+getAddress);
		System.out.println("출발지 경유지항구파라미터: "+getTransit);
		System.out.println("도착지 내륙 상세주소 파라미터: "+getaAddress);
		System.out.println("도착지 경유 항구 파라미터: "+getaTransit);
		
		//여기 이거 4줄 더 추가해야지 화면에 뿌려질때 null이 안뜬다.
		fclbean.setTransit(getTransit);
		fclbean.setAddress(getAddress);
		fclbean.setaAddress(getaAddress);
		fclbean.setaTransit(getaTransit);
		
		boolean result = fcl.insertFcl(fclbean);
		
		
		System.out.println("bean값 체크1"+fclbean.getTransit());	
		System.out.println("bean값 체크2"+fclbean.getaTransit());	
		System.out.println("bean값 체크3"+fclbean.getAddress());	
		System.out.println("bean값 체크4"+fclbean.getaAddress());	
		
	
		
		String msg="등록실패";
		String url = "boardFclWrite.jsp";
		if(result){
			msg="등록성공";
			url="../member/mypage.jsp";
		}
		
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>