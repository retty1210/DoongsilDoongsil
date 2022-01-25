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
				<tr >
					<th><label>이름</label></th>
					<td><input type="text" placeholder="이름" name="userName"/></td>
				</tr>
				<tr>
					<th><label>학급</label></td>
					<td><input type="text" placeholder="학년" name="userGrade"/>
					<input type="text" placeholder="반" name="userClass"/></td>
				</tr>
				<tr>
					<th><label>주소</label></th>
					<td><input type="text" placeholder="주소" name="userAdress"/></td>
				</tr>
				<tr>
					<th><label>이메일</label></th>
					<td><input type="text" placeholder="이메일" name="userEmail"/></td>
				</tr>
				<tr>
					<th><label>생일</label></th>	
					<td><input type="date" placeholder="생일" name="userBirthday"/></td>
				</tr>
				<tr>
					<th><label>프로필<br>사진</label></th>
					<td><input type="file" placeholder="프로필사진" name="userPhoto"></td>
				</tr>
				<tr>
					<th><label for="accountType">회원타입</label></th>
					<td>
					<select name="userType" id="accountType">
						<option value="S">학생</option>
						<option value="T">교사</option>
						<option value="P">학부모</option>
					</select>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>