<%@page import="quote.FclBean"%>
<%@page import="fmember.ForwardersMemberBean"%>
<%@page import="forwarders.FclQuotationBean"%>
<%@page import="java.util.Vector"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="quotationMgr" class="forwarders.FclQuotationMgr"/>
<jsp:useBean id="fcl" class="quote.FclMgr"/>
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
		function fclDetail(no){
			document.detail.no.value=no;
			document.detail.submit();
		}
	</script>
	</head>
	<body>
	<%@ include file="../index/top.jsp" %>
		<section class="dashboard gray-bg padd-0 mrg-top-50">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-2 col-md-2 col-sm-3 dashboard-bg">
							<nav class="navbar navbar-side">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#dashboard-menu">
									<i class="fa fa-bars"></i>
								</button>
							</div>
							<div class="collapse sidebar-collapse" id="dashboard-menu">
								<div class="profile-wrapper">
									<div class="profile-wrapper-thumb">
										<img src="<%=userProfile%>" class="img-responsive img-circle" alt="" />
										<span class="dashboard-user-status bg-success"></span>
									</div>
									<h4><%=userID%></h4>
								</div>
								<ul class="nav" id="main-menu">
									<li>
										<a href="mypage.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>창고입고 후 수입운송</a>
									</li>
								</ul>
							</div>
						</nav>
					</div>
					<div class="col-lg-10 col-md-10 col-sm-9 col-lg-push-2 col-md-push-2 col-sm-push-3">
						<div class="row mrg-0 mrg-top-20">
							<div class="tr-single-box">
								<div class="tr-single-header">
									<h3 class="dashboard-title">전체 창고입고 후 수입운송 현황입니다.</h3>
								</div>
								<div class="tr-single-body">
										
									<div class="detail-wrapper padd-top-30 padd-bot-30">
										<div class="row  mrg-0 detail-invoice">
											<div class="col-lg-12 col-md-12 col-sm-12">
												<div class="invoice-table">
													<div class="table-responsive">
														<table class="table table-striped table-bordered">
															<thead>
																<tr>
																	<th>#NO</th>
																	<th>ITEM</th>
																	<th>DEPARTURE</th>
																	<th>ARRIVE</th>
																	<th>INCOTERMS</th>
																	<th>DATE</th>
																	<th>STATEMENT</th>
																</tr>
															</thead>
															<%
																Vector<FclQuotationBean> vlist = quotationMgr.getFclQuotationList(userID);
																if(vlist.isEmpty()){
																	out.println(vlist.size());
															%>
															<tr>
																<td colspan="7" align="center">Empty</td>
															</tr>
															<%}else{
																	for(int i=0; i<vlist.size();i++){
																		FclQuotationBean quotation = vlist.get(i);
																		int fclno = quotation.getFclno();
																		FclBean fbean = fcl.getFcl(fclno);
															%>
															<tbody>
																<tr>
																	<td><%=quotation.getNo()%></td>
																	<td>
																		<a href="javascript:fclDetail('<%=fclno%>')">
																			<%=fbean.getItem()%></a>
																	</td>
																	<td><%=fbean.getDeparture()%></td>
																	<td><%=fbean.getArrive() %></td>
																	<td><%=fbean.getIncoterms()%></td>
																	<td><%=quotation.getDate()%></td>
																	<td>
																		<%
																			switch(quotation.getState()){
																				case "1":out.print("Waiting for quotation");break;
																				case "2":out.print("Estimating in progress");break;
																				case "3":out.print("Quotation calculation completed");break;
																			}
																		%>
																	</td>
																</tr>
															</tbody>
															<%						
																		}//---for
																	}//---if-else
															%>
														</table>
														<form name = "detail" method="post" action="../quote/boardFclRead.jsp">
															<input type = "hidden" name="no">
														</form>
													</div>
												</div>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
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
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>
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