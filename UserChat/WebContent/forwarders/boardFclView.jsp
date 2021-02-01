<%@page import="member.UserDAO"%>
<%@page import="quote.LclBean"%>
<%@page import="quote.FclBean"%>
<%@page import="java.util.Vector"%>
<%@page import="quote.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fcl" class="quote.FclMgr"/>
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
		
		int totalRecord = 0;
		int numPerPage = 10;
		int pagePerBlock = 5;
		int totalPage = 0;
		int totalBlock =0;
		int nowPage = 1;
		int nowBlock = 1;
		
		if(request.getParameter("numPerPage")!=null){
			numPerPage = UtilMgr.parseInt(request, "numPerPage");
		}
		
		//검색에 필요한 변수
		String keyField = "", keyWord = "";
		if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
		}
		
		//검색 후에 다시 처음 리스트 요청
		if(request.getParameter("reload")!=null&&
				request.getParameter("reload").equals("true")){
			keyField =""; keyWord = ""; 
		}
		
		totalRecord = fcl.getTotalCountFcl(keyField, keyWord);
		
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		//sql문에 들어가는 start, cnt 선언
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage;
		
		//전체페이지 개수
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		//전체블럭 개수
		 totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		//현재블럭
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);

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
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function list() {
		document.listFrm.action = "boardView.jsp";
		document.listFrm.submit();
	}
	
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value=page;
		document.readFrm.submit();
	}
	
	function block(block) {
		document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	
	function read(no) {
		document.readFrm.no.value = no;
		document.readFrm.action = "boardFclRead.jsp";
		document.readFrm.submit();
	}
</script>
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
	<body>
		<section class="page-title-banner" style="background-image:url(assets/img/banner.jpg);">
			<div class="container">
				<div class="row">
					<div class="tr-list-detail">
						
					</div>
				</div>
			</div>
		</section>
		<!-- ======================= End Banner ===================== -->
		
		<section class="profile-header-nav padd-0 bb-1">
			<div class="container">
				<div class="row">
					
					<div class="col-md-8 col-sm-8">
						<div class="tab" role="tabpanel">
							<!-- Nav tabs -->
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#FCL" aria-controls="home" role="tab" data-toggle="tab"><i class="ti-user"></i>FCL</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!-- ============== Tour Detail ====================== -->	
		<section class="tr-single-detail gray-bg">
			<div class="container">
				<div class="row">
					
					
					
					<div class="col-md-8 col-sm-12">
						<div class="tab-content tabs">
							
							<div role="tabpanel" class="tab-pane fade in active" id="FCL">
								<div class="row">
									<%
										Vector<FclBean> vlist=fcl.getBoardListFcl(keyField, keyWord, start, cnt);
										int listSize=vlist.size();
										if(vlist.isEmpty()){
											out.println("존재하지 않음");
										}else{
									%>
									<%
										for(int i=0; i<numPerPage;i++){
											if(i==listSize) break;
											FclBean bean = vlist.get(i);
											int no = bean.getNo();
											String incoterms = bean.getIncoterms();
											String item = bean.getItem();
											//String client = bean.getClient();
											String ctype = bean.getCtype();
											int volume = bean.getVolume();
											String departure = bean.getDeparture();
											String arrive = bean.getArrive();
											String address = bean.getAddress();
											String aAdrress = bean.getaAddress();
											String port = bean.getPort();
											String aport = bean.getAport();
											String regdate = bean.getRegdate();
											String client = bean.getClient();
											int count= bean.getCount();
										
									%>
									<div class="tr-single-box">
										<div class="tr-single-header">
											<h4><i class="ti-user"></i>#<%=totalRecord-start-i%>&nbsp;&nbsp;&nbsp; FCL 업무의뢰 리스트 (view <%=count%>)</h4>
										</div>
										<div class="tr-single-body">
											<div class="guider-box-detail">
												<div class="guider-box-thumb">
													<img src="<%=userProfile%>" class="img-responsive img-circle" alt="" />
												</div>
												<div class="guider-box-detail-content">
													<h4>회사명</h4>
													<p>
														<%=item %><span class="guider-status bg-success"><%=client %></span>
													</p>
													<a href="javascript:read('<%=no%>')"class="btn btn-info">View Detail</a>
												</div>
												<div class="pr-table">
													<ul>
														<li><strong>Volume : </strong><%=ctype%>&nbsp;x&nbsp;<%=volume %></li>
														<li><strong>Incoterms : </strong><%=incoterms %></li>
														<li><strong>Departure : </strong><%=address %>(<%=departure %>) <%=port %></li>
														<li><strong>Destination : </strong><%=aAdrress %>(<%=arrive %>) <%=aport %></li>
														<li><strong>Request Date : </strong><%=regdate %></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<%}//---for%>		
								<%}//-----------if-else%>
								
								
								</div>
							</div>
							
							<form name="listFrm" method="post">
								<input type="hidden" name="reload" value="true">
								<input type="hidden" name="nowPage" value="1">
							</form>
							
							<form name="readFrm">
								<input type="hidden" name="nowPage" value="<%=nowPage%>">
								<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
								<input type="hidden" name="keyField" value="<%=keyField%>">
								<input type="hidden" name="keyWord" value="<%=keyWord%>">
								<input type="hidden" name="no">
							</form>
							<div class="row">
								<ul class="pagination">
									
										<li class="page-item">
										<%if(nowBlock>1){%>
										  <a class="page-link" href="javascript:block('<%=nowBlock-1%>')" aria-label="Previous">
											<span class="ti-arrow-left"></span>
											<span class="sr-only">Previous</span>
										  </a>
										  <%}%>
										</li>
									
									<%
											int pageStart = (nowBlock-1)*pagePerBlock+1;
											int pageEnd = (pageStart+pagePerBlock/*15*/)<=totalPage?
													pageStart+pagePerBlock:totalPage+1;
											for(;pageStart<pageEnd;pageStart++){
									%>
									<li >
										<a  href="javascript:pageing('<%=pageStart%>')">
											<%if(nowPage==pageStart){%><font color="red"><%}%>
												<%=pageStart%>
											<%if(nowPage==pageStart){%></font><%}%>
										</a>
									</li>
									<%}//--for%>
									<%if(totalBlock>nowBlock){%>
										<li class="page-item">
										  <a class="page-link" href="javascript:block('<%=nowBlock+1%>')" aria-label="Next">
											<span class="ti-arrow-right"></span>
											<span class="sr-only">Next</span>
										  </a>
										</li>
									<%}%>
								</ul>
							</div>
							
							
						</div>
					</div>
					
					
				   	<form  name="searchFrm">
						<div class="col-md-4 col-sm-12">
							<div class="tr-single-box">
								<div class="tr-single-body">
									<form class="book-form">
										<div class="row">
											<div class="col-xs-12">
												<div class="form-group">
													<label>Incoterms</label>
													<div class="sl-side">
														<select class="wide form-control">
																<option data-display="CFR">CFR</option>
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
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<div class="form-group">
													<label>Destination</label>
													<input type="text" name="destination" class="form-control">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 mrg-top-15">
												<a href="#" class="btn btn-arrow theme-btn full-width">Search</a>		
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
				  	 </form>
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
		<script src="http://maps.google.com/maps/api/js?key="></script>
		<script src="assets/plugins/js/markerclusterer.js"></script>
		<script src="assets/js/map.js"></script>
		
		<!-- Dashboard Js -->
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>	
 
		<!-- Custom Js -->
		<script src="assets/js/custom.js"></script>

		<script>
			$('#checkin').daterangepicker({
				"singleDatePicker": true,
				"timePicker": true,
				"startDate": "12/12/2018",
				"endDate": "12/14/2018"
			}, function(start, end, label) {
			  console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		</script>
		
		<script>
			$('#checkout').daterangepicker({
				"singleDatePicker": true,
				"timePicker": true,
				"startDate": "12/18/2018",
				"endDate": "12/18/2018"
			}, function(start, end, label) {
			  console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		</script>

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