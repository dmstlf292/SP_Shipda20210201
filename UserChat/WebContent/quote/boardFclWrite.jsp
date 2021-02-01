<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
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
	<%@ include file="../index/top.jsp" %>
		<div class="page-title image-title" style="background-image:url(assets/img/banner.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>FCL업무의뢰</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>FCL</span></p>
				</div>
			</div>
		</div>
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="simple-tab-style">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#User" aria-controls="home" role="tab" data-toggle="tab"><i class="ti-user"></i>실시간 견적조회</a></li>
						</ul>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="User">
								
								
								
								
							  <form name="regFrm" method="post" action="boardFclProc.jsp">
								<div class="simple-accordion">
									<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
										
										
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title1">
												<h4 class="panel-title">
													<a role="button" data-toggle="collapse" data-parent="#accordion" href="#col1" aria-expanded="true" aria-controls="col1">
														운송수단 및 지역결정
													</a>
												</h4>
											</div>
											<div id="col1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="title1">
												<div class="panel-body">
													</br>
													<div align="center">
														<h5>FCL : Full container loaded의 약자로, 수입기업이 하나의 컨테이너를 단독으로 사용하는 것을 의미합니다. 
														화물 디테일에 따라 DRY/RF/OT/FR 컨테이너를 선택하여 사용합니다.</h5>
													</div>
													</br>
													<div class="col-md-12">
														<p>
															<label>인코텀즈</label>
															<select class="wide form-control" name="incoterms" required>
																<option value="CFR">CFR</option>
																<option value="CIF">CIF</option>
																<option value="CIP">CIP</option>
																<option value="CPT">CPT</option>
																<option value="DAP">DAP</option>
																<option value="DDP">DDP</option>
																<option value="EXW">EXW</option>
																<option value="FCA">FCA</option>
																<option value="FOB">FOB</option>
															</select>
														</p>
													</div>
													<div class="col-md-6">
														<p>
															<label>출발지 국가</label>
															<input type="text" class="form-control" name="departure" required>
														</p>
														<p>
															<label>출발 port</label>
															<input type="text"  class="form-control"  name="port" required>
														</p>
														<p>
															<label>출발지 내륙 상세주소 입력</label>
															<input type="text"  class="form-control"   name="address" >
														</p>
														<p>
															<label>출발지 경유지 항구</label>
															<input type="text"class="form-control"  name="transit" >
														</p>
													</div>	
													<div class="col-md-6">
														<p>
															<label>도착지 국가</label>
															<input type="text" class="form-control" name="arrive" required>
														</p>
														<p>
															<label>도착 port</label>
															<input type="text"  class="form-control" name="aport" required>
														</p>
														<p>
															<label>도착지 내륙 상세주소 입력</label>
															<input type="text"  class="form-control"  name="aAddress" >
														</p>
														<p>
															<label>도착지 경유지 항구</label>
															<input type="text"class="form-control"  name="aTransit" >
														</p>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading" role="tab" id="title2">
												<h4 class="panel-title">
													<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#col2" aria-expanded="false" aria-controls="col2">
														화물정보 입력
													</a>
												</h4>
											</div>
											<div id="col2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="title2">
												<div class="panel-body">
													<div class="col-md-6">
														<p>
															<label>품목</label>
															<input type="text" class="form-control"  name="item" required>
														</p>
														<p>
															<label>컨테이너 TYPE</label>
															<select class="wide form-control" name="ctype" required>
																<option value="DRY">DRY</option>
																<option value="REEFER">REEFER</option>
																<option value="OPEN TOP">OPEN TOP</option>
																<option value="FLAT RACK">FLAT RACK</option>
															</select>
														</p>
														<p>
															<label>컨테이너 사이즈</label>
															<select class="wide form-control" name="csize" required>
																<option value="20 DRY">20 DRY</option>
																<option value="40 DRY">40 DRY</option>
																<option value="40 HQ">40 HQ</option>
															</select>
														</p>
													</div>
													<div class="col-md-6">
														<p>
															<label>컨테이너 수량</label>
															<input type="number" maxlength="255" class="form-control" placeholder="숫자만 입력하세요"  name="volume" maxlength="20" required>
														</p>
														<p>
															<label>위험물</label>
															<select class="wide form-control" name="danger" required>
																<option value="NO">NO</option>
																<option value="YES">YES</option>
															</select>
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
													</br>
													<div>
														<h5> * LSS : 저유황유할증료로 수출지에서 발생하는 비용입니다. 통상적으로 수입자가 지불합니다.</h5>
														<h5> * Ocean Surcharge : 해상수입 시, 수입지에서 발생하는 해상운임 추가비용(BAF,CAF,CRS)를 의미합니다.</h5>
														<h5> * 국내 부대비용 : 수입 시, 국내 항구/공항에서 발생하는 비용(THC, WFG 등)을 의미합니다.</h5>
													</div>
													</br>
													
													<div class="col-md-4">
														<p>
															<label>LSS</label>
															<select class="wide form-control" name="lss" required> 
																<option value="Not Included">Not Included</option>
																<option value="Include">Include</option>
															</select>
														</p>
													</div>
													<div class="col-md-4">
														<p>
															<label>Ocean Surcharge</label>
															<select class="wide form-control" name="surcharge" required>
																<option value="Not Included">Not Included</option>
																<option value="Include">Include</option>
															</select>
														</p>
													</div>
													<div class="col-md-4">
														<p>
															<label>국내 부대비용</label>
															<select class="wide form-control" name="extra" required>
																<option value="Not Included">Not Included</option>
																<option value="Include">Include</option>
															</select>
														</p>
													</div>
													</br>
													<div class="col-md-12">
														<h4>필요한 내용을 선택해주세요.</h4>
													</div>
													
													</br>
													<div class="col-md-12">
														<p>
															<input type="radio" name="client" value="Customs Broker" autocomplete="off" checked>Customs Broker&nbsp;&nbsp;&nbsp;
															<input type="radio" name="client" value="Insurance" autocomplete="off">Insurance
														</p>
													</div>
													
													</br>
													<div class="col-md-12">
														<h5> * 통관대행수수료의 경우 화물 종류 및 금액에 상관없이 1회 30,000원(VAT 별도)이 청구됩니다.</h5>
														<h5> * 해상/항공 사고 발생 시를 대비하여 가입하는 보험입니다. 통상적으로 ‘물품가격 * 110% * 0.03%’가 적용됩니다.</h5>
													</div>
												</div>
												
											</div>
										</div>
									</div>
									 <input type="submit" value="등록" class="btn theme-btn"> 
								</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
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