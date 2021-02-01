<%@ page  contentType="text/html; charset=EUC-KR"%>
<%@page import="member.UserDTO" %>
<%@page import="member.UserDAO" %>
<!DOCTYPE html>
<html>
	<%
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID==null){
			session.setAttribute("messageType", "오류메시지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("../index/index.jsp");
			return;
		}
		UserDTO user = new UserDAO().getUser(userID);
	%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<title>디지털 수입물류 포워딩 Ship-da</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		function passwordCheckFunction(){
			var userPassword1=$('#userPassword1').val();
			var userPassword2=$('#userPassword2').val();
			if(userPassword1!=userPassword2){
				$('#passwordCheckMessage').html('비밀번호가 맞지 않습니다.');
			}else{
				$('#passwordCheckMessage').html('');
			}
		}
	</script>
</head>
<body>
	<div class="container">
		<form method="post" action="../member/userProfile" enctype="multipart/form-data">
			<table class="table table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd; margin : 150px 30px 0 0;">
				<thead>
					<tr>
						<th colspan="2"><h4>프로필 사진 수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:110px;"><h5>아이디</h5></td>
						<td><h5><%=user.getUserID() %></h5>
							<input type="hidden" name="userID" value="<%=user.getUserID()%>">
						</td>
					</tr>
					 <tr>
						<td style="width:110px;"><h5>사진 업로드</h5></td>
						<td colspan="2">
							<div data-role="content">
							    <div class="preview">
									<div class="upload">
										<div class="post_btn">
											<div class="plus_icon"></div>
											<p>포스트 이미지 추가</p>
											<canvas id="imageCanvas"></canvas>
										</div>
									</div>
								</div>
								<p>
									<span class="btn btn-default btn-file">
								   	이미지를 업로드 하세요 <input id="userProfile" type="file" name="userProfile">
									</span>
								</p>
							</div>
							
							
							
							<form method="post" name="frm1"></form>
							<script>
							var fileInput = document.querySelector("#userProfile"), button = document
									.querySelector(".input-file-trigger"), the_return = document
									.querySelector(".file-return");
							// Show image
							fileInput.addEventListener('change', handleImage, false);
							var canvas = document.getElementById('imageCanvas');
							var ctx = canvas.getContext('2d');
					
							function handleImage(e) {
								var reader = new FileReader();
								reader.onload = function(event) {
									var img = new Image();
									img.onload = function() {
										canvas.width = 300;
										canvas.height = 300;
										ctx.drawImage(img, 0, 0, 300, 300);
									};
									img.src = event.target.result;
								};
								reader.readAsDataURL(e.target.files[0]);
							}
						</script>
						</td>
					</tr> 
					<tr>
						<td style="text-align:left;" colspan="3"><h5 style="color:red";></h5>
							<input class="btn btn-primary pull-right" type="submit" value="돌아가기">
							<input class="btn btn-primary pull-right" type="submit" value="등록">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
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
	<%
		if(userID!=null){
	%>
		<script type="text/javascript">
			$(document).ready(function(){
				getInfiniteUnread();
			});
		</script>
	<%
		}
	%>
</body>
</html>