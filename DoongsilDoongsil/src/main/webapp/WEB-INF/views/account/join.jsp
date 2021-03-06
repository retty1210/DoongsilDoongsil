<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="doongsil.com.web.account.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교사와 학생 회원가입</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard-dynamic-subset.css" />
<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<link href="/stc/css/join.css" rel="stylesheet" type="text/css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
</head>
<body class="bg-color">
	<div class="box">
		<div class="login-div">
			<div class="logo" onclick="location.href='/'">
				<svg xmlns="http://www.w3.org/2000/svg" class="bi bi-clouds" viewBox="0 0 16 16">
				  <path d="M16 7.5a2.5 2.5 0 0 1-1.456 2.272 3.513 3.513 0 0 0-.65-.824 1.5 1.5 0 0 0-.789-2.896.5.5 0 0 1-.627-.421 3 3 0 0 0-5.22-1.625 5.587 5.587 0 0 0-1.276.088 4.002 4.002 0 0 1 7.392.91A2.5 2.5 0 0 1 16 7.5z" />
				  <path d="M7 5a4.5 4.5 0 0 1 4.473 4h.027a2.5 2.5 0 0 1 0 5H3a3 3 0 0 1-.247-5.99A4.502 4.502 0 0 1 7 5zm3.5 4.5a3.5 3.5 0 0 0-6.89-.873.5.5 0 0 1-.51.375A2 2 0 1 0 3 13h8.5a1.5 1.5 0 1 0-.376-2.953.5.5 0 0 1-.624-.492V9.5z" />
				</svg>
				<h2 class="text-center">둥실둥실</h2>
			</div>
		</div>
		<div class="nav-div">
			<nav class="black">
				<div class="navigation">
					<div class="a-left">
						<a href="/join">학생 및 교사 회원</a>
					</div>
					<div class="a-right">
						<a href="/paaJoin" onClick ="ul(0)" class="a-right">학부모 회원</a>
					</div>
				</div>
			</nav>
		</div>
		
		<div class="form-group">
			<form action="./join" method="post">
				<div class="username_wrap">
					<label>아이디</label>
					<input class="id" type="text" name="sta_username" id="sta_username" class="id" required>
					<button type="button" class="checkId" id="checkId" onclick="id_check();">중복체크</button> 
					<span id="must-id" class="hid_span_area"> 
						<!--필수 입력입니다.-->
					</span>
				</div>
				<div class="name_wrap">
					<label>이름</label>
					<input type="text" name="sta_name" id="name" class="name" required>
					<span id="must-name" class="hid_span_area">
						<!--필수 입력입니다.-->
					</span>
				</div>
				<div class="password_wrap">
					<label>비밀번호</label>
					<input type="password" name="sta_password" class="pass" required> 
					<span id="must-pw" class="hid_span_area"> 
						<!-- 필수 입력입니다.--> 
					</span>
				</div>
				<div class="password_chk_wrap">
					<label>비밀번호 확인</label>
					<input type="password" name="password_chk" class="pass-ck" required> 
					<span id="must-pw-ck" class="hid_span_area"> 
						<!-- 필수 입력입니다.-->
					</span>
				</div>
				<div class="email_wrap">
					<label>이메일</label>
					<input type="email" name="sta_email" class="email" required>
					<span id="must-email" class="hid_span_area">
						<!--필수 입력입니다.-->
		            </span>
				</div>
				<div class="multi-select">
					<label>주소</label>
					<div>
						<input type="text" id="sample6_postcode" name="sta_postcode" class="post" placeholder="우편번호">
						<input type="button" class="inner" onclick="sample6_execDaumPostcode();" value="우편번호 찾기" style="font-size:12px;"><br>
						<input type="text" id="sample6_address" name="sta_address" class="add" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" class="add" placeholder="상세주소">
						<input type="text" id="sample6_extraAddress" class="add" placeholder="참고항목">
					</div>
				</div>
				<div class="phonenumber_wrap">
					<label>전화번호</label>
					<input type="text" name="sta_phonenumber" id="phonenumber" class="phone" required>
				</div>
				<div class="multi-input">
		               <label>생년월일</label>
		               <div class="input-form">
		                   <input type="date" id="birthday" name="sta_birthday" class="birth"/>
		               </div>
		           </div>
		        <div class="checked">
		        	<input type="checkbox" id="student" name="sta_usertype" value="S"><label for="student">학생입니다</label>
		        	<input type="checkbox" id="teacher" name="sta_usertype" value="T"><label for="teacher">선생님입니다</label>
		        </div>
				<div class="btn_area">
					<button type="submit" id="sign-btn" class="sign-btn">가입하기</button>
				</div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
	function id_check() {
		var sta_username = $("#sta_username").val();
		if(!sta_username == ""){
			$.ajax({
			url : "/dupcheck",
			type : "post",
			data : {"sta_username" : sta_username},
			dataType : "json",
			success : function(data) {
				if(data.state === "fail") {
					alert("중복된 아이디 입니다.");
				} else {
					alert("사용 가능한 아이디 입니다.");
				}
			}
		})
		} else if(sta_username == "") {
			alert('아이디를 입력해주세요.');
		}
		
		
	}
	</script> 
<script type="text/javascript" src="stc/js/addHypen.js"></script>
<script type="text/javascript" src="stc/js/join.js"></script>
<script type="text/javascript" src="stc/js/address.js"></script>
<script type="text/javascript" src="stc/js/birthday.js"></script>
<script type="text/javascript" src="stc/js/checkOne.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>