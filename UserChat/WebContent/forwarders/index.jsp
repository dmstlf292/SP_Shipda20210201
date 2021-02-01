<%@ page  contentType="text/html; charset=EUC-KR"%>
<%@page import="member.UserDAO"%>
<%@page pageEncoding="EUC-KR"%>
<jsp:useBean id="mMgr" class="fmember.ForwardersMemberMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("../user/login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		
		String userProfile = new UserDAO().getProfile(userID);
		
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
						<li class="dropdown megamenu-fw"><a href="#" class="dropdown-toggle" data-toggle="dropdown">MyPage</a>
							<ul class="dropdown-menu megamenu-content" role="menu">
								<li>
									<div class="row">
										<div class="col-menu col-md-3">
											<div class="content">
												<ul class="menu-col">
													<li><a href="../forwarders/mypage.jsp">My Page</a></li>
												</ul>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</li>
						<li class="br-right"><a href="../user/userLogout.jsp" ><i class="login-icon ti-user"></i>Logout</a></li>
						<%}%>
					</ul>
				</div>
			</div>  
		</nav>
		<div class="main-banner" style="background-image:url(assets/img/banner-7.jpg);">
			<div class="container">
				<div class="col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1">
					<div class="caption text-center cl-white">
						<h2>디지털 수입물류 포워딩 서비스</h2>
						<p>간단한 정보로 물류비 즉시 확인</p>
					</div>
					<form class="wow-form"> 
						<input type="text" placeholder="업무용 이메일을 입력하세요.">
						<button type="submit" class="btn btn-wow theme-btn" name="submit" value="Search">무료 이용하기</button>
					</form>
					<div class="caption text-center cl-white">
						<p>쉽다는 고객님의 화물을 직접 운송하는 디지털 포워딩 서비스입니다.
						</br>이메일 입력 후 무료로 서비스를 이용하세요.</p>
					
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		<section>
			<div class="container">
				
				<div class="row">
					<div class="col-md-12">
						<div class="heading">
							<h1>쉽다만의 첫번째 장점을 소개합니다.</h1>
							</br>
							<h4>컨테이너(FCL) 비용절감</h4>
							<h3>첫째, 대기업 수입물류비, 쉽다에선 중소업체도 동일하게 사용 가능합니다.</h3>
							</br>
							<h4>타 포워더 대비 20%가량 물류비를 절감한 고객사 사례</h4>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6 col-md-6">
						<article class="destination-box style-1">
							<div class="destination-box-image">
								<figure>
									<a href="destination-detail.html">
										<img src="assets/img/strength1.png" class="img-responsive listing-box-img" alt="" />
									</a>
								</figure>
							</div>
						</article>
					</div>
					<div class="col-md-6 col-md-6">
						<article class="destination-box style-1">

							<div class="destination-box-image">
								<figure>
									<a href="destination-detail.html">
										<img src="assets/img/strength1.png" class="img-responsive listing-box-img" alt="" />
									</a>
									
								</figure>
							</div>
							
						</article>
					</div>
					<div class="col-md-12 col-md-12" align="center">
						<h3>연간 240만원 가량의 수입물류비 절감 (*40피트 컨테이너 기준)</h3>
						<p>수입 화물량에 따라 차등 적용되는 물류비, 컨테이너 1대를 수입하시더라도 대량으로 수입하는 대기업과 동일한 운임을 제공합니다.</p>
					</div>
				</div>
		</section>
		
		<div class="clearfix"></div>
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="heading">
							<h1>쉽다만의 두번째 장점을 소개합니다.</h1>
							</br>
							<h3>소량화물 수입과정에서 발생하는 중간유통 단계를 제거합니다.</h3>
							<h4>쉽다는 소량화물을 하나의 컨테이너로 혼재 작업하는 콘솔사 역할을 수행합니다.</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="row">
					<div class="col-md-6 col-md-6">
						<article class="destination-box style-1">
							<div class="destination-box-image">
								<figure>
									<a href="destination-detail.html">
										<img src="assets/img/process1.png" class="img-responsive listing-box-img" alt="" />
									</a>
								</figure>
							</div>
						</article>
					</div>
					<div class="col-md-6 col-md-6">
						<article class="destination-box style-1">

							<div class="destination-box-image">
								<figure>
									<a href="destination-detail.html">
										<img src="assets/img/process2.png" class="img-responsive listing-box-img" alt="" />
									</a>
									
								</figure>
							</div>
							
						</article>
					</div>
					</br>
					<div class="col-md-12 col-md-12" align="center">
						<h4>컨테이너 좌석제 '오션티켓' 서비스를 통해 불필요한 중간 유통단계를 제거하여 소량화물 물류비 체계를 간소화합니다.</h4>
					</div>
				</div>
				</div>
			</div>
		</section>
		
		<div class="clearfix"></div>
		<section>
			<div class="container">
				
				<div class="row">
					<div class="col-md-12">
						<div class="heading">
							<h1>영상으로 쉽다를 쉽게 확인해보세요!</h1>
						</div>
					</div>
				</div>
					<div class="col-md-12 col-md-12" align="center">
						<iframe width="1000" height="400" src="https://www.youtube.com/embed/OlmbJDUFSgA" 
						frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; 
						gyroscope; picture-in-picture" allowfullscreen></iframe>
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