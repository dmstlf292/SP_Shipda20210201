<%@page import="quote.SUtilMgr"%>
<%@page import="quote.LclBean"%>
<%@page import="forwarders.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="lcl" class="quote.LclMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String nowPage = request.getParameter("nowPage");	
		String noPerPage = request.getParameter("noPerPage");	
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		int no = UtilMgr.parseInt(request, "no");	
		lcl.upCountLcl(no);
		LclBean lbean = lcl.getLcl(no);
		
		String departure = lbean.getDeparture();
		String port = lbean.getPort();
		String address = lbean.getAddress();
		String transit = lbean.getTransit();
		String arrive = lbean.getArrive();
		String aport = lbean.getAport();
		String aAddress = lbean.getaAddress();
		String aTransit = lbean.getaTransit();
		String incoterms = lbean.getIncoterms();
		String packingType = lbean.getPackingType();
		String item = lbean.getItem();
		String danger = lbean.getDanger();
		String stackable = lbean.getStackable();
		String lss = lbean.getLss();
		String surcharge = lbean.getSurcharge();
		String extra = lbean.getExtra();
		String client = lbean.getClient();
		String volumeUnit = lbean.getVolumeUnit();
		String weightUnit = lbean.getWeightUnit();
		String regdate = lbean.getRegdate();
		
		int count = lbean.getCount();
		int width = lbean.getWidth();//가로
		int llength = lbean.getLlength();//세로
		int height = lbean.getHeight();//높이
		int volume = lbean.getVolume();
		int packageCount = lbean.getPackageCount();
		int totalCBM=0;
		totalCBM=(width*llength*height)*packageCount;
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디지털 수입물류 포워딩 Ship-da</title>
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	<script type="text/javascript">
		function list() {
			document.listFrm.action = "boardLclView.jsp";
			document.listFrm.submit();
		}
	</script>
	</head>
	<body>
	<%@ include file="../index/top.jsp" %>
		<div class="page-title image-title" style="background-image:url(assets/img/banner.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>LCL업무의뢰</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>LCL</span></p>
				</div>
			</div>
		</div>
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="simple-tab-style">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#User" aria-controls="home" role="tab" data-toggle="tab"><i class="ti-user"></i>실시간 견적조회 디테일</a></li>
						</ul>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="User">
								
								
								
								
							  <form name="regFrm" method="post" action="boardLclProc.jsp">
								<div class="simple-accordion">
									<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
										
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title1">
												<h4 class="panel-title">
													<a role="button" data-toggle="collapse" data-parent="#accordion" href="#col1" aria-expanded="true" aria-controls="col1">
														인코텀즈&nbsp;&nbsp;&nbsp;<%=lbean.getIncoterms()%>
													</a>
												</h4>
											</div>
											<div id="col1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="title1">
												<div class="panel-body">
													<div class="col-md-6">
														<p>
															<label>출발지 국가</label>
															<input type="text" class="form-control"  name="departure" value="<%=lbean.getDeparture()%>" readonly>
														</p>
														<p>
															<label>출발 port</label>
															<input type="text"  class="form-control" name="port" value="<%=lbean.getPort()%>" readonly>
														</p>
														<p>
															<label>출발지 내륙 상세주소 입력</label>
															<input type="text"  class="form-control"   name="address" value="<%=lbean.getAddress()%>" readonly>
														</p>
														<p>
															<label>출발지 경유지 항구</label>
															<input type="text"class="form-control"  name="transit" value="<%=lbean.getTransit()%>" readonly>
														</p>
													</div>	
													<div class="col-md-6">
														<p>
															<label>도착지 국가</label>
															<input type="text" class="form-control"  name="arrive" value="<%=lbean.getArrive()%>" readonly>
														</p>
														<p>
															<label>도착 port</label>
															<input type="text"  class="form-control" name="aport" value="<%=lbean.getAport()%>" readonly>
														</p>
														<p>
															<label>도착지 내륙 상세주소 입력</label>
															<input type="text"  class="form-control"  name="aAddress" value="<%=lbean.getaAddress()%>" readonly>
														</p>
														<p>
															<label>도착지 경유지 항구</label>
															<input type="text"class="form-control"  name="aTransit" value="<%=lbean.getaTransit()%>" readonly>
														</p>
													</div>
												</div>
											</div>
										</div>
										
										
										
										
										
										
										
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title2">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col2" aria-expanded="false" aria-controls="col2">
														화물 주요 정보 & 포장별 상세 정보
													</a>
												</h4>
											</div>
											<div id="col2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title2">
												<div class="panel-body">
													<div class="col-md-3">
														
														<p>
															<label>포장 TYPE</label>
															<input type="text" class="form-control"  name="packingType" value="<%=lbean.getPackingType()%>" readonly>
														</p>
														<p>
															<label>가로</label>
															<input type="number" maxlength="255" class="form-control"   name="width" value="<%=lbean.getWidth()%>" readonly>
														</p>
														<p>
															<label>세로</label>
															<input type="number" maxlength="255" class="form-control"  name="llength" value="<%=lbean.getLlength()%>" readonly>
														</p>
														<p>
															<label>높이</label>
															<input type="number" maxlength="255" class="form-control"   name="height" value="<%=lbean.getHeight()%>" readonly>
														</p>
													</div>
													<div class="col-md-3">
														<p>
															<label>품목</label>
															<input type="text" class="form-control" name="item" value="<%=lbean.getItem()%>" readonly>
														</p>
														<p>
															<label>부피단위</label>
															<input type="text" class="form-control"  name="volumeUnit" value="<%=lbean.getVolumeUnit()%>" readonly>
														</p>
														
													</div>
													<div class="col-md-3">
														<p>
															<label>위험물</label>
															<input type="text" class="form-control"  name="danger" value="<%=lbean.getDanger()%>" readonly>
														</p>
														<p>
															<label>중량</label>
															<input type="number" maxlength="255" class="form-control"   name="volume" value="<%=lbean.getVolume()%>" readonly>
														</p>
														<p>
															<label>중량단위</label>
															<input type="text" class="form-control"  name="weightUnit" value="<%=lbean.getWeightUnit()%>" readonly>
														</p>
														
													</div>
													<div class="col-md-3">
														<p>
															<label>2단 적재</label>
															<input type="text" class="form-control"  name="stackable" value="<%=lbean.getStackable()%>" readonly>
														</p>
														<p>
															<label>포장수량</label>
															<input type="number" maxlength="255" class="form-control" name="packageCount" value="<%=lbean.getPackageCount()%>" readonly>
														</p>
													</div>
												</div>
											</div>
										</div>
										
										
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title3">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col3" aria-expanded="false" aria-controls="col3">
														체크포인트
													</a>
												</h4>
											</div>
											<div id="col3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title3">
												<div class="panel-body">
													<div class="col-md-4">
														<p>
															<label>LSS</label>
															<input type="text"  class="form-control"name="lss" value="<%=lbean.getLss()%>">
														</p>
													</div>
													<div class="col-md-4">
														<p>
															<label>Ocean Surcharge</label>
															<input type="text"  class="form-control"name="surcharge" value="<%=lbean.getSurcharge()%>">
														</p>
													</div>
													<div class="col-md-4">
														<p>
															<label>국내 부대비용</label>
															<input type="text"  class="form-control"name="extra" value="<%=lbean.getExtra()%>">
														</p>
													</div>
												</div>
												
											</div>
										</div>
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title4">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col4" aria-expanded="false" aria-controls="col4">
														산출된 CBM
													</a>
												</h4>
											</div>
											<div id="col4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title4">
												<div class="panel-body">
													<div class="col-md-4">
														<p>
															<label>산출된 총 CBM</label>
															<input type="number" maxlength="255" class="form-control" name="cbm" value="<%=SUtilMgr.monFormat(totalCBM)%>" >
														</p>
													</div>	
												</div>
											</div>
										</div>
									</div>
									 <a href="javascript:list()" class="btn theme-btn">목록으로 돌아가기</a>
								</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<form name="listFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="noPerPage" value="<%=noPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
		<%@ include file="../index/footer.jsp" %>
		<button class="w3-button w3-teal w3-xlarge w3-right" onclick="openRightMenu()"><i class="spin theme-cl fa fa-cog" aria-hidden="true"></i></button>
		<div class="w3-sidebar w3-bar-block w3-card-2 w3-animate-right" style="display:none;right:0;" id="rightMenu">
		  <button onclick="closeRightMenu()" class="w3-bar-item w3-button w3-large theme-bg">Close &times;</button>
		   <ul id="styleOptions" title="switch styling">
				<li>
					<a href="javascript: void(0)" class="cl-box cl-default" data-theme="skins/default"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-red" data-theme="skins/red"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-green" data-theme="skins/green"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-blue" data-theme="skins/blue"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-pink" data-theme="skins/pink"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-purple" data-theme="skins/purple"></a>
				</li>
			</ul>
		</div>
		<!-- /Switcher -->
		 
		<!-- =================== START JAVASCRIPT ================== -->
		<script src="assets/plugins/js/jquery.min.js"></script>
		<script src="assets/plugins/js/bootstrap.min.js"></script>
		<script src="assets/plugins/js/viewportchecker.js"></script>
		<script src="assets/plugins/js/bootsnav.js"></script>
		<script src="assets/plugins/js/slick.min.js"></script>
		<script src="assets/plugins/js/jquery.nice-select.min.js"></script>
		<script src="assets/plugins/js/jquery.fancybox.min.js"></script>
		<script src="assets/plugins/js/jquery.downCount.js"></script>
		<script src="assets/plugins/js/freshslider.1.0.0.js"></script>
		<script src="assets/plugins/js/moment.min.js"></script>
		<script src="assets/plugins/js/daterangepicker.js"></script>
		<script src="assets/plugins/js/wysihtml5-0.3.0.js"></script>
		<script src="assets/plugins/js/bootstrap-wysihtml5.js"></script>
		
		<!-- Dashboard Js -->
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>
 
		<!-- Custom Js -->
		<script src="assets/js/custom.js"></script>
		
		<script src="assets/js/jQuery.style.switcher.js"></script>
		<script>
			function openRightMenu() {
				document.getElementById("rightMenu").style.display = "block";
			}
			function closeRightMenu() {
				document.getElementById("rightMenu").style.display = "none";
			}
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#styleOptions').styleSwitcher();
			});
		</script>
	
    </body>

</html>