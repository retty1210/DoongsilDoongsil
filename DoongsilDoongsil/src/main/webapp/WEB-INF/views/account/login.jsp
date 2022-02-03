<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<form action="./login" method="post">
	<select name="userType">
		<option value="S">학생</option>
		<option value="T">교사</option>
		<option value="P">학부모</option>
	</select>
		<div>
			<label>아이디</label>
			<input type="text" name="username" >
		</div>
		<div>
			<label>패스워드</label>
			<input type="password" name="password">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
		<div class="text-center">
			<a href="${naver_url}"><img width="320" height="60" alt="Naver Login" src="/stc/img/naver-login.png"></a>
		</div>
		<div class="text-center">
			<a href="${kakao_url}"><img width="320" height="60" alt="Kakao Login" src="/stc/img/kakao-login.png"></a>
		</div>
		<div class="text-center">
			<a href="${google_url}"><img width="320" height="60" alt="Google Login" src="/stc/img/google-login.png"></a>
		</div>
		<div>
			<span><a href="./findId">아이디 찾기</a></span>
			<span><a href="./findPss">비밀번호 찾기</a></span>
		</div>
		<div>
			<span>회원가입하기</span>
			<span><a href="./join">(학생 & 교사 </a></span>
			<span><a href="./paaJoin"> | 학부모)</a></span>
		</div>
	</form>
</body>
</html>