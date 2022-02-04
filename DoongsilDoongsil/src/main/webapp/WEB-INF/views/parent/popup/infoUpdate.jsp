<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function infoUpdate(){
		var update = document.getElementsByTagName('form')[0];
		update.submit();
	}
	function updateCancel(){
		window.close();
		opener.location.reload("/info");
	}
</script>
<style type="text/css">
	body{
		padding:15px;
	}
	.updateBtn{
		background-color:#0476DE;
		border-color:#0476DE;
		color:white;
		margin-left:5px;
		margin-bottom: 10px;
	}
	.updateBtn,
	.updateCancel{
		float:right;
		border-radius:5px;
		width:50px;
	}
	.btnBox{
		width:100%;
		
	}
	.inputBox{
		width:100%;
		height:100%;
	}
	#accountType{
		float:left;
	}
	.infoUpdate_tb{
		width:100%;
		height:100%;
	}
	.infoUpdate_tb th,
	.infoUpdate_tb td{
		height:50px;
	}
</style>
</head>
<body>
<h4>내 정보 수정</h4>
	<form action="/infoUpdate" method="post">
		<div class="btnBox">
			<button type="button" class="updateBtn" onclick="infoUpdate();">수정</button>
			<button type="button" class="updateCancel" onclick="updateCancel();">취소</button>		
		</div>
		<div class="inputBox">
			<table border="1" class="infoUpdate_tb">
				<tr>
					<th><label>연락처</label></th>
					<td><input type="text" value="${parentUpdate.paa_phonenumber }" name="userPhone"/></td>
				</tr>
				<tr>
					<th><label>비밀번호</label></th>
					<td><input type="text" name="newPassword"/></td>
				</tr>
				<tr>
					<th><label>비밀번호 확인</label></th>
					<td><input type="text" name="newPasswordCheck"/></td>
				</tr>
				
			</table>
		</div>
		<input type="hidden" value="${parentUpdate.paa_id }" name="userId"/>	
	</form>
</body>
</html>