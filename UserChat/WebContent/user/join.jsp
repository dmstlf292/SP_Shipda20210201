<%@page import="java.net.URLDecoder"%>
<%@ page  contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<title>Ship-Da 포워딩 회사 전용</title>
</head>
<body>
	<div class="container">
		<form method="post" action="userRegisterAction.jsp">
			<table class="table table-bordered table-hover" style="margin : 200px 30px 0 0; text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>포워딩 업체 등록양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" id="id" name="id" maxlength="20" placeholder="입력하세요"></td>
						
					</tr>
					<tr>
						<td style="width:110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" id="userPassword" name="userPassword" type="password" maxlength="20" placeholder="입력하세요"></td>
					</tr>
					<tr>
						<td style="width:110px;"><h5>이메일</h5></td>
						<td colspan="2"><input o class="form-control" id="userEmail" name="userEmail" type="email" maxlength="64" placeholder="입력하세요"></td>
					</tr>
					<tr>
						<td style="text-align:left;" colspan="3">
							<a class="btn btn-primary pull-right" href="../index/index.jsp">돌아가기</a>
							<input class="btn btn-primary pull-right" type="submit" value="등록">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>