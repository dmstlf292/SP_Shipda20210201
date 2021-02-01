<%@page import="member.UserDAO"%>
<%@page import="fmember.ForwardersMemberMgr"%>
<%@page import="quote.FclBean"%>
<%@page import="quote.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fcl" class="quote.FclMgr"/>
<jsp:useBean id="fclbean" class="forwarders.FclQuotationBean"/>
<jsp:useBean id="mMgr" class="fmember.ForwardersMemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		int no = UtilMgr.parseInt(request, "no");	
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("../user/login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		//여길 손봤음!!!!중요!!!!!
		if(request.getParameter("quotation.getNo()")!=null){
			no = Integer.parseInt(request.getParameter("quotation.getNo()"));
		}
		
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		
		String userProfile = new UserDAO().getProfile(userID);
		String nowPage = request.getParameter("nowPage");	
		String noPerPage = request.getParameter("noPerPage");	
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		
		FclBean fbean = fcl.getFcl(no);
		String departure = fbean.getDeparture();
		String port = fbean.getPort();
		String address = fbean.getAddress();
		String transit = fbean.getTransit();
		String arrive = fbean.getArrive();
		String aport = fbean.getAport();
		String aAddress = fbean.getaAddress();
		String aTransit = fbean.getaTransit();
		String incoterms = fbean.getIncoterms();
		String item = fbean.getItem();
		String ctype = fbean.getCtype();
		String csize = fbean.getCsize();
		String danger = fbean.getDanger();
		String lss = fbean.getLss();
		String surcharge = fbean.getSurcharge();
		String extra = fbean.getExtra();
		String regdate = fbean.getRegdate();
		int count = fbean.getCount();
		String client = fbean.getClient();
		int volume = fbean.getVolume();
		
		int fclno = fclbean.getFclno();
		int pickupRate = fclbean.getPickupRate();
		int stuffingRate = fclbean.getStuffingRate();
		int lashingRate = fclbean.getLashingRate();
		int ofRate = fclbean.getOfRate();
		//int lssebs = fclbean.getl
		int thcRate = fclbean.getThcRate();
		int otherRate = fclbean.getOtherRate();
		int amsRate = fclbean.getAmsRate();
		int vgmRate = fclbean.getVgmRate();
		int handlingRate = fclbean.getHandlingRate();
		
		String oftype = fclbean.getOftype();
		String carrier = fclbean.getCarrier();
		String tt = fclbean.getTt();
		String validity = fclbean.getValidity();
		String date = fclbean.getDate();
		String state = fclbean.getState();
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

	</head>
	<body>
	
	<nav class="navbar navbar-default navbar-mobile navbar-fixed light bootsnav">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
						<i class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand" href="index.jsp">
						<img src="assets/img/logo.png" class="logo logo-display" alt="">
						<img src="assets/img/logo.png" class="logo logo-scrolled" alt="">
					</a>
				</div>
				<div class="collapse navbar-collapse" id="navbar-menu">
					<ul class="nav navbar-nav navbar-left" data-in="fadeInDown" data-out="fadeOutUp">
						<li>
							<a href="index.jsp" class="dropdown-toggle">Home</a>
						</li>
						<li class="dropdown megamenu-fw"><a href="#" class="dropdown-toggle" data-toggle="dropdown">업무의뢰 리스트</a>
							<ul class="dropdown-menu megamenu-content" role="menu">
								<li>
									<div class="row">
										<div class="col-menu col-md-3">
											<div class="content">
												<ul class="menu-col">
													<li><a href="boardFclView.jsp">FCL업무의뢰 리스트</a></li>
													<li><a href="boardLclView.jsp">LCL업무의뢰 리스트</a></li>
												</ul>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</li>
						<li>
							<a href="pricing.jsp">Pricing</a>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<%
							if(id!=null){
						%>
						<li class="br-right"><a href="../user/userLogout.jsp" ><i class="login-icon ti-user"></i>Logout</a></li>
						<%}%>
					</ul>
				</div>
			</div>  
		</nav>
		<div class="page-title image-title" style="background-image:url(assets/img/banner.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>FCL 인코텀즈&nbsp;&nbsp;&nbsp;<%=fbean.getIncoterms()%>(<%=fbean.getPort()%>-<%=fbean.getAport()%>)</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>FCL 견적의뢰 디테일</span></p>
				</div>
			</div>
		</div>
		
		
		
		<form method="post" action="fclReplyProc.jsp">
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="simple-tab-style">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#User" aria-controls="home" role="tab" data-toggle="tab"><%=fbean.getIncoterms()%></a></li>
						</ul>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="User">
								<div class="simple-accordion">
									<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
										
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title1">
												<h4 class="panel-title">
													<a role="button" data-toggle="collapse" data-parent="#accordion" href="#col1" aria-expanded="true" aria-controls="col1">
														IMPORT SHIPMENT DETAILS INFORMATION
													</a>
												</h4>
											</div>
											<div id="col1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="title1">
												<div class="panel-body">
													<div class="col-md-6">
														<p><label>PICK UP : <%=fbean.getAddress()%></label></p>
														<p><label>POL : <%=fbean.getPort()%>&nbsp;&nbsp;&nbsp;(<%=fbean.getDeparture() %>)</label></p>
														<p><label>POD : <%=fbean.getAport()%>&nbsp;&nbsp;&nbsp;(<%=fbean.getArrive()%>)</label></p>
														<p><label>CARGO : <%=fbean.getCtype()%><%=fbean.getCsize() %></label></p>
														<p><label>ITEM : <%=fbean.getItem()%></label></p>
													</div>	
													<div class="col-md-6">
														<p><label>VOLUME : <%=fbean.getVolume()%></label></p>
														<p><label>DANGER : <%=fbean.getDanger()%></label></p>
														<p><label>INSURANCE : <%=fbean.getClient()%></label></p>
														<p><label>LSS : <%=fbean.getLss()%></label></p>
														<p><label>OCEAN SURCHARGE : <%=fbean.getSurcharge()%></label></p>
														<p><label>extra : <%=fbean.getExtra()%></label></p>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title2">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col2" aria-expanded="false" aria-controls="col2">
														<%=fbean.getIncoterms()%> 
													</a>
												</h4>
											</div>
											
											
											
											<div id="col2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title2">
												<div class="panel-body">
													<div class="col-md-4">
														<p>
															<label><%=fbean.getIncoterms()%> COST</label>
														</p>
														<div class="col-md-6">
															<p>PICK UP : </p>
															<p>STUFFING : </p>
															<p>LASHING : </p>
															<p>OCEAN FREIGHT</p>
															<p>
																<select class="wide form-control" name="oftype" required>
																	<option value="DOOR/CY">DOOR/CY</option>
																	<option value="CY/CY">CY/CY</option>
																	<option value="CY/DOOR">CY/DOOR</option>
																	<option value="DOOR/DOOR">DOOR/DOOR</option>
																</select>
															</p>
															<p>CUSTOMS</p>
															<p>LOCAL CHARGE</p>
															<p>HANDLING</p>
														</div>	
														<div class="col-md-6">
															<p><%=fbean.getAddress()%>&nbsp;&nbsp;&nbsp;(<%=fbean.getDeparture()%>)</p>
															<p>CARGO STUFF ON TO FR CNTR</p>
															<p>LASHING COST (IF REQUIRED)</p>
															<p>OCEAN FREIGHT (<%=fbean.getAddress()%>-<%=fbean.getPort()%>-<%=fbean.getAport()%>)</p>
															<p>LSS + EMERGENCY BUNKER SURCHARGE</p>
															<p>CUSTOMS CLEARANCE</p>
															<p>TERMINAL HANDLING CHARGE</p>
															<p>BL FEE + DOC FEE</p>
															<p>AMS+ADMIN.</p>
															<p>VGM COST</p>
															<p><%=fbean.getIncoterms()%> HANDLING FEE </p>
														</div>
													</div>
													<div class="col-md-4">
														<p>
															<label>RATE</label>
														</p>
														<p><input type="text" class="form-control"  name="pickupRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="stuffingRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="lashingRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="ofRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="lssebs" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="thcRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="otherRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="amsRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="vgmRate" placeholder="USD" required></p>
														<p><input type="text" class="form-control"  name="handlingRate" placeholder="USD" required></p>
													</div>
													<div class="col-md-4">
														<p><label>Unit / Remarks</label></p>
														<p><input type="text" class="form-control"  placeholder="enter" required></p>
														<p><input type="text" class="form-control"  value="PER CNTR" readonly></p>
														<p><input type="text" class="form-control"  value="PER <%=fbean.getCsize()%>" readonly></p>
														<p><input type="text" class="form-control"  value="PER <%=fbean.getCsize()%>" readonly></p>
														<p><input type="text" class="form-control"  value="BY SHIPPER" readonly></p>
														<p><input type="text" class="form-control"  value="PER CNTR" readonly></p>
														<p><input type="text" class="form-control"  value="PER BL" readonly></p>
														<p><input type="text" class="form-control"  value="PER BL" readonly></p>
														<p><input type="text" class="form-control"  value="PER CNTR" readonly></p>
														<p><input type="text" class="form-control"  value="PER CNTR" readonly></p>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title3">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col3" aria-expanded="false" aria-controls="col3">
														CARRIER
													</a>
												</h4>
											</div>
											<div id="col3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title3">
												<div class="panel-body">
													 <div class="col-md-6">
															<p><label>CARRIER : </label></p>
															<p><label>FREQUENCY/TRANSIT TIME : </label></p>
															<p><label>SUBJECT TO DESTINATION CHARGE</label></p>
															<p><label>VALIDITY : </label></p>
													 </div>	
													 <div class="col-md-6">
															<p><input type="text" class="form-control"  name ="carrier" placeholder="Enter..." required></p>
															<p><input type="text" class="form-control" name ="tt"  placeholder="Enter..." required></p>
															<p><input type="text" class="form-control" name ="validity"  placeholder="Enter..." required></p>
													 </div>	
												</div>
											</div>
											<p>
												<select class="wide form-control" name="state" required>
													<option value="Estimating in progress">Estimating in progress</option>
													<option value="Quotation calculation completed">Quotation calculation completed</option>
												</select>
											</p>
										</div>
									</div>
									 <button type="submit" class="btn theme-btn">견적 제출하기</button>
									 <button type="button" class="btn theme-btn" onClick="history.back()">돌아가기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		</form>
		
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