<%@page import="member.UserDAO"%>
<%@page import="java.net.URLDecoder"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		String toID= null;
		if(request.getParameter("toID")!=null){
			toID = (String) request.getParameter("toID");
		}
		if(userID==null){
			session.setAttribute("messageType", "오류메시지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("../member/login.jsp");
			return;
		}

		if(toID==null){
			session.setAttribute("messageType", "오류메시지");
			session.setAttribute("messageContent", "대화상대가 지정되어있지 않습니다.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		if(userID.equals(URLDecoder.decode(toID,"EUC-KR"))){
			session.setAttribute("messageType", "오류메시지");
			session.setAttribute("messageContent", "자기자신에게는 쪽지를 보낼 수 없습니다.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		String fromProfile = new UserDAO().getProfile(userID);
		String toProfile = new UserDAO().getProfile(toID);//찾앗다 바보짓함
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<title>디지털 수입물류 포워딩 Ship-da</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	<script type="text/javascript">
		function autoClosingAlert(selector, delay){
			var alert =$(selector).alert();
			alert.show();
			//delay 한 시간만큼만 보여줄 수 있도록 하기
			window.setTimeout(function() {alert.hide() }, delay);
		};
		function submitFunction(){
			var fromID ='<%= userID%>';
			var toID ='<%= toID%>';
			var chatContent = $('#chatContent').val();
			$.ajax({
					type:"POST",
					url:"../chatting/chatSubmitt",
					data: {
						fromID: encodeURIComponent(fromID),
						toID: encodeURIComponent(toID),
						chatContent: encodeURIComponent(chatContent),
					},
					success: function(result){
						if(result==1){//성공
							
							autoClosingAlert('#successMessage', 2000);//2초동안
						}else if(result==0){
							autoClosingAlert('#dangerMessage', 2000);//2초동안
						}else{
							autoClosingAlert('#warningMessage', 2000);//2초동안
						}
					},
					error : function(request, status, error) { // 결과 에러 콜백함수
				        console.log(error)
				    }
			});
			$('#chatContent').val('');
		}
		//가장 마지막으로 대화한 CHAT ID
		var lastID = 0;
		function chatListFunction(type){
			var fromID = '<%=userID%>';
			var toID = '<%=toID%>';
			$.ajax({
				type:"POST",
				url:"../chatting/chatListt",
				data : {
					fromID:encodeURIComponent(fromID),
					toID:encodeURIComponent(toID),
					listType:type
				},
				success : function(data){
					if(data=="") return;
					var parsed=JSON.parse(data);
					var result = parsed.result;
					for(var i=0; i<result.length;i++){
						if(result[i][0].value==fromID){
							result[i][0].value='나';	
						}
						addChat(result[i][0].value, 
								result[i][2].value, result[i][3].value);  
					}
					lastID= Number(parsed.last);
				}
			});
		}
		function addChat(chatName,chatContent,chatTime){
			if(chatName=='나'){
				$('#chatList').append('<div class="row">' +
						'<div class="col-lg-12">' +
						'<div class="media">' +
						'<a class ="pull-left" href="#">' +
						'<img class="media-object img-circle" style="width:30px; height:30px;" src="<%=fromProfile%>" alt="">' +
						'</a>' +
						'<div class="media-body">' +
						'<h4 class="media-heading">' + chatName +
						'<span class="small pull-right">' + chatTime + 
						'</span>' +
						'</h4>'+
						'<p>' + chatContent +
						'</p>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'<hr>');
			}else{
				$('#chatList').append('<div class="row">' +
						'<div class="col-lg-12">' +
						'<div class="media">' +
						'<a class ="pull-left" href="#">' +
						'<img class="media-object img-circle" style="width:30px; height:30px;" src="<%=toProfile%>" alt="">' +
						'</a>' +
						'<div class="media-body">' +
						'<h4 class="media-heading">' + chatName +
						'<span class="small pull-right">' + chatTime + 
						'</span>' +
						'</h4>'+
						'<p>' + chatContent +
						'</p>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'<hr>');
			}
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
		}
		//새로운 메시지 가져오는 함수
		function getInfiniteChat() {
			setInterval(function() {
				chatListFunction(lastID);
			},3000);//3초에 한번씩 실행
		}
		 function getUnread(){
			$.ajax({
				type:"POST",
				url:"../chatting/chatUnreadt",
				data:{
					userID:encodeURIComponent('<%=userID%>'),
				},
				success : function(result){
					if(result>=1){
						showUnread(result);
					}else{
						showUnread('');//결과값 출력 안함
					}
				}
			});
			
		} 
		function getInfiniteUnread(){
			setInterval(function(){
				getUnread();
			},4000);//4초마다 한번씩
		}
		 function showUnread(result){
			$('#unread').html(result);
		} 
	</script>
</head>
<body>
	
	<nav class="navbar navbar-default navbar-mobile navbar-fixed light bootsnav">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
						<i class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand" href="../index/index.jsp">
						<img src="assets/img/logo.png" class="logo logo-display" alt="">
						<img src="assets/img/logo.png" class="logo logo-scrolled" alt="">
					</a>
				</div>
				<div class="collapse navbar-collapse" id="navbar-menu">
					<ul class="nav navbar-nav navbar-left" data-in="fadeInDown" data-out="fadeOutUp">
						<li>
							<a href="index.jsp" class="dropdown-toggle">Home</a>
						</li>
						<li class="dropdown megamenu-fw"><a href="#" class="dropdown-toggle" data-toggle="dropdown">실시간 견적 조회</a>
							<ul class="dropdown-menu megamenu-content" role="menu">
								<li>
									<div class="row">
										<div class="col-menu col-md-3">
											<div class="content">
												<ul class="menu-col">
													<li><a href="boardFclWrite.jsp">FCL업무의뢰</a></li>
													<li><a href="boardLclWrite.jsp">LCL업무의뢰</a></li>
												</ul>
											</div>
										</div>
									</div>
								</li>
							</ul>
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
							<a href="../forwarders/pricing.jsp">Pricing</a>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<%
							if(userID==null){
						%>
						<li class="br-right"><a href="../member/join.jsp" ><i class="login-icon ti-user"></i>Join</a></li>
						<%
							}else{
						%>
						<li class="br-right"><a href="../member/logoutAction.jsp" ><i class="login-icon ti-user"></i>Logout</a></li>
						<li class="dropdown megamenu-fw"><a href="#" class="dropdown-toggle" data-toggle="dropdown">MyPage</a>
							<ul class="dropdown-menu megamenu-content" role="menu">
								<li>
									<div class="row">
										<div class="col-menu col-md-3">
											<div class="content">
												<ul class="menu-col">
													<li><a  href="../chat/box.jsp">My ChatBox</a></li>
													<li><a href="../chat/find.jsp">Find Friend</a></li>
												</ul>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</li>
						<li class="br-right"><a href="../member/logoutAction.jsp" ><i class="login-icon ti-user"></i>Logout</a></li>
						<%}%>
					</ul>
				</div>
			</div>  
		</nav>
	
	<div class="container bootstrap snippet">
	   <div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default" style="margin : 120px auto;">
					<div class="portlet-heading">
						<div class="portlet-title" >
							<h4><i class="fa fa-circle text-green"></i>실시간 채팅창</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width:auto; height:600px;" style="margin : 100px 30px 0 0;">
						</div>
						<div class="portlet-footer">
							<div class="row" style="height:90px;">
								<div class="form-group col-xs-10">
									<textarea style="height:80px;" id="chatContent" class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	    </div>
	</div>
	<div class="alert alert-success" id="successMessage" style="display:none;">
		<strong>메시지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display:none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display:none;">
		<strong>디비 오류 발생.</strong>
	</div>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent")!=null){
			messageContent=(String)session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType")!=null){
			messageType=(String)session.getAttribute("messageType");
		}
		if(messageContent !=null){
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
		  <div class="modal-dialog vertical-align-center">
			<div class="modal-content" <%if(messageType.equals("오류메시지")) out.println("panel-warning"); else out.println("panel-success");%>">
				<div class="modal-header panel-heading">
					<button type="button" class="close" data-dismiss="modal">
						<sapn aria-hidden="true">&times</sapn>
						<span class="sr-only">Close</span>	
					</button>
					<h4 class="modal-title">
						<%=messageType%>
					</h4>
					<div class="modal-body">
						<%=messageContent%>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		   </div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%	
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<!-- 특정시간을 주기로 대화 목록을 디비에서 불러올 수 있다. -->
	<script type="text/javascript">
		$(document).ready(function(){
			getUnread();
			chatListFunction('0');
			getInfiniteChat();//3초 간격으로 메시지 가져오기 
			getInfiniteUnread();
		});
	</script>
</body>
</html>