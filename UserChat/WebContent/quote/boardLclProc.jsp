<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="lcl" class="quote.LclMgr"/>
<jsp:useBean id="lclbean" class="quote.LclBean"/>
<jsp:setProperty property="*" name="lclbean"/>
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
		
		//아니 여길 이거 4줄 더 추가해야지 화면에 뿌려질때 null이 안뜬다.
		lclbean.setTransit(getTransit);
		lclbean.setAddress(getAddress);
		lclbean.setaAddress(getaAddress);
		lclbean.setaTransit(getaTransit);
		
		boolean result = lcl.insertLcl(lclbean);
		
		
		System.out.println("bean값 체크1"+lclbean.getTransit());	
		System.out.println("bean값 체크2"+lclbean.getaTransit());	
		System.out.println("bean값 체크3"+lclbean.getAddress());	
		System.out.println("bean값 체크4"+lclbean.getaAddress());	
		
	
		
		String msg="등록실패";
		String url = "boardLclWrite.jsp";
		if(result){
			msg="등록성공";
			url="boardLclView.jsp";
		}
		
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>