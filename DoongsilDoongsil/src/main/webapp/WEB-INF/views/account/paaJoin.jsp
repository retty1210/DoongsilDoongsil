<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학부모 회원가입</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
</head>
<body>
<form action="./paaJoin" method="post">
	<div>
		<label>아이디</label>
		<input type="text" name="id" required>
		<button type="button" onclick="fn_nameCheck();">중복체크</button> 
		<span id="must-id" class="hid_span_area"> 
			<!--필수 입력입니다.-->
		</span>
	</div>
	<div>
		<label>이름</label>
		<input type="text" name="username" required>
		<span id="must-name" class="hid_span_area">
			<!--필수 입력입니다.-->
		</span>
	</div>
	<div>
		<label>비밀번호</label>
		<input type="password" name="password" required> 
		<span id="must-pw" class="hid_span_area"> 
			<!-- 필수 입력입니다.--> 
		</span>
	</div>
	<div>
		<label>비밀번호 확인</label>
		<input type="password" name="password_chk" required> 
		<span id="must-pw-ck" class="hid_span_area"> 
			<!-- 필수 입력입니다.-->
		</span>
	</div>
	<div>
		<label>전화번호</label>
		<input type="text" name="phonenumber">
	</div>
	<div>
		<label>학생찾기</label>
		<input type="text" name="findChild">
		<button type="button" onclick="">검색하기</button>
	<div>
		<button type="submit">가입하기</button>
	</div>
</form>
</body>
</html>