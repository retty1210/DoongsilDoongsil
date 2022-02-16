<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard-dynamic-subset.css" />
<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<link href="/stc/css/login.css" rel="stylesheet" type="text/css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
</head>
<body>
	<div class="login-div">
		<div class="logo" onclick="location.href='/'">
			<svg xmlns="http://www.w3.org/2000/svg" class="bi bi-clouds" viewBox="0 0 16 16">
			  <path d="M16 7.5a2.5 2.5 0 0 1-1.456 2.272 3.513 3.513 0 0 0-.65-.824 1.5 1.5 0 0 0-.789-2.896.5.5 0 0 1-.627-.421 3 3 0 0 0-5.22-1.625 5.587 5.587 0 0 0-1.276.088 4.002 4.002 0 0 1 7.392.91A2.5 2.5 0 0 1 16 7.5z"/>
			  <path d="M7 5a4.5 4.5 0 0 1 4.473 4h.027a2.5 2.5 0 0 1 0 5H3a3 3 0 0 1-.247-5.99A4.502 4.502 0 0 1 7 5zm3.5 4.5a3.5 3.5 0 0 0-6.89-.873.5.5 0 0 1-.51.375A2 2 0 1 0 3 13h8.5a1.5 1.5 0 1 0-.376-2.953.5.5 0 0 1-.624-.492V9.5z"/>
			</svg>
		</div>
		
		<div class="title" style="font-family: 'Hi Melody', cursive;" onclick="location.href='/'">둥실둥실</div>
		
		<div class="form-box">
		<form action="./login" method="post">
			<select name="userType" aria-invalid="false">
				<option selected>가입한 유형을 선택해주세요.</option>
				<option value="S">학생</option>
				<option value="T">교사</option>
				<option value="P">학부모</option>
			</select>
			
			<div class="username">
				<!-- <label>아이디</label> -->
				<svg class="svg-icon" viewBox="0 0 20 20">
					<path d="M12.075,10.812c1.358-0.853,2.242-2.507,2.242-4.037c0-2.181-1.795-4.618-4.198-4.618S5.921,4.594,5.921,6.775c0,1.53,0.884,3.185,2.242,4.037c-3.222,0.865-5.6,3.807-5.6,7.298c0,0.23,0.189,0.42,0.42,0.42h14.273c0.23,0,0.42-0.189,0.42-0.42C17.676,14.619,15.297,11.677,12.075,10.812 M6.761,6.775c0-2.162,1.773-3.778,3.358-3.778s3.359,1.616,3.359,3.778c0,2.162-1.774,3.778-3.359,3.778S6.761,8.937,6.761,6.775 M3.415,17.69c0.218-3.51,3.142-6.297,6.704-6.297c3.562,0,6.486,2.787,6.705,6.297H3.415z"></path>
				</svg>
				<input type="text" name="username" value="${LoginVO.username}" placeholder="username">
			</div>
			<div class="password">
				<!-- <label>패스워드</label> -->
				<svg class="svg-icon" viewBox="0 0 20 20">
					<path d="M17.308,7.564h-1.993c0-2.929-2.385-5.314-5.314-5.314S4.686,4.635,4.686,7.564H2.693c-0.244,0-0.443,0.2-0.443,0.443v9.3c0,0.243,0.199,0.442,0.443,0.442h14.615c0.243,0,0.442-0.199,0.442-0.442v-9.3C17.75,7.764,17.551,7.564,17.308,7.564 M10,3.136c2.442,0,4.43,1.986,4.43,4.428H5.571C5.571,5.122,7.558,3.136,10,3.136 M16.865,16.864H3.136V8.45h13.729V16.864z M10,10.664c-0.854,0-1.55,0.696-1.55,1.551c0,0.699,0.467,1.292,1.107,1.485v0.95c0,0.243,0.2,0.442,0.443,0.442s0.443-0.199,0.443-0.442V13.7c0.64-0.193,1.106-0.786,1.106-1.485C11.55,11.36,10.854,10.664,10,10.664 M10,12.878c-0.366,0-0.664-0.298-0.664-0.663c0-0.366,0.298-0.665,0.664-0.665c0.365,0,0.664,0.299,0.664,0.665C10.664,12.58,10.365,12.878,10,12.878"></path>
				</svg>
				<input type="password" name="password" placeholder="password">
			</div>
			<div class="error-msg">
				<c:if test="${isError}">
					<div class="error">${error_msg}</div>
				</c:if>
			</div>
			<div class="sign">
				<button type="submit" class="signin-btn">로그인</button>
			</div>
			<div class="options">
				<div class="text-center">
					<a href="${naver_url}"><img alt="Naver Login" src="/stc/img/naver-login.png"></a>
				</div>
				<div class="text-center">
					<a href="${kakao_url}"><img alt="Kakao Login" src="/stc/img/kakao-login.png"></a>
				</div>
				<div class="text-center">
					<a href="${google_url}"><img alt="Google Login" src="/stc/img/google-login.png"></a>
				</div>
			</div>
			<div class="a-div">
				<div class="find-form">
					<span><a href="./findId">아이디 찾기 |</a></span>
					<span><a href="./findPss"> 비밀번호 찾기</a></span>
				</div>
				<div class="join-page">
					<span>회원가입하기</span>
					<span><a href="./join"> (학생 & 교사 </a></span>
					<span><a href="./paaJoin"> | 학부모)</a></span>
				</div>
			</div>
		</form>
		</div>
	</div>
</body>
</html>