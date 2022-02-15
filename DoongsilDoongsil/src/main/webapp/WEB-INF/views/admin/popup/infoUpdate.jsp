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
	function passwordCheck() {
		let password = document.getElementsByName("newPassword")[0];
		let pwCheck = document.getElementsByName("newPasswordCheck")[0];
		let newTxt = document.createElement("span");
		let passwordTd = document.getElementsByTagName("tr")[3].children[1];
		
		newTxt.setAttribute("class","noPassword");
		newTxt.style.fontSize = '12px';
		newTxt.style.display = 'none';
		
		passwordTd.append(newTxt);
		
		let selector = document.querySelector(".noPassword");
		
		if(password.value == pwCheck.value){
			password.style.borderColor = "green";
			pwCheck.style.borderColor = "green";
			selector.innerText = ' * 비밀번호가 일치 합니다.';
			selector.style.color = 'green';
			selector.style.display = '';
			
		} else{
			password.style.borderColor = "red";
			pwCheck.style.borderColor = "red";
			selector.innerText = ' * 비밀번호가 일치하지 않습니다.';
			selector.style.color = 'red';
			selector.style.display = '';
			
		}
		
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
	<form action="/admin/infoUpdate" method="post" encType="multipart/form-data">
		<div class="btnBox">
			<button type="button" class="updateBtn" onclick="infoUpdate();">수정</button>
			<button type="button" class="updateCancel" onclick="updateCancel();">취소</button>		
		</div>
		<div class="inputBox">
			<table border="1" class="infoUpdate_tb">
				<tr >
					<th><label>이름</label></th>
					<td><input type="text" value="${studentUpdate.sta_name }" name="userName"/></td>
				</tr>
				<tr>
					<th><label>학급</label></th>
					<td><input type="text" value="${studentUpdate.sta_grade}" name="userGrade"/>
					<input type="text" value="${studentUpdate.sta_class }" name="userClass"/></td>
				</tr>
				<tr>
					<th><label>비밀번호</label></th>
					<td><input type="password" name="newPassword"/></td>
				</tr>
				<tr>
					<th><label>비밀번호 확인</label></th>
					<td><input type="password" name="newPasswordCheck" onblur="passwordCheck();"/></td>
				</tr>
				<tr>
					<th><label>연락처</label></th>
					<td><input type="text" value="${studentUpdate.sta_phonenumber }" name="userPhone"/></td>
				</tr>
				<tr>
					<th><label>주소</label></th>
					<td><input type="text" value="${studentUpdate.sta_address }" name="userAdress"/></td>
				</tr>
				<tr>
					<th><label>이메일</label></th>
					<td><input type="text" value="${studentUpdate.sta_email }" name="userEmail"/></td>
				</tr>
				<tr>
					<th><label>생일</label></th>	
					<td><input type="date" value="${studentUpdate.sta_birthday }" name="userBirthday"/></td>
				</tr>
				<tr>
					<th><label>프로필<br>사진</label></th>
					<td><input type="file" name="userPhoto" accept="image/*"></td>
				</tr>
				<tr>
					<th><label for="accountType">회원타입</label></th>
					<td>
					<select name="userType" id="accountType" >
						<option value="T">교사</option>
						<option value="S">학생</option>
						<option value="P">학부모</option>
					</select>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" value="${studentUpdate.sta_id }" name="userId"/>	
	</form>
</body>
</html>