<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교사와 학생 회원가입</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link href="/stc/css/join.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="box">
		<h2 class="text-center">둥실둥실</h2>
		<form action="./join" method="post">
		<div class="form-group">
			<div class="username_wrap">
				<label>아이디</label>
				<input type="text" name="username" required>
				<button type="button" class="id_overlap_button" onclick="id_overlap_check();">중복체크</button> 
				<span id="must-id" class="hid_span_area"> 
					<!--필수 입력입니다.-->
				</span>
			</div>
			<div class="name_wrap">
				<label>이름</label>
				<input type="text" name="name" required>
				<span id="must-name" class="hid_span_area">
					<!--필수 입력입니다.-->
				</span>
			</div>
			<div class="password_wrap">
				<label>비밀번호</label>
				<input type="password" name="password" required> 
				<span id="must-pw" class="hid_span_area"> 
					<!-- 필수 입력입니다.--> 
				</span>
			</div>
			<div class="password_chk_wrap">
				<label>비밀번호 확인</label>
				<input type="password" name="password_chk" required> 
				<span id="must-pw-ck" class="hid_span_area"> 
					<!-- 필수 입력입니다.-->
				</span>
			</div>
			<div>
				<label>이메일</label>
				<input type="email" name="email" required>
				<span id="must-email" class="hid_span_area">
					<!--필수 입력입니다.-->
	            </span>
			</div>
			<div class="multi-select">
				<label>주소</label>
				<div>
					<input type="text" id="sample6_postcode" name="address" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode();" value="우편번호 찾기"><br>
					<input type="text" id="sample6_address" placeholder="주소"><br>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				</div>
			</div>
			<div>
				<label>전화번호</label>
				<input type="text" name="phonenumber">
			</div>
			<div class="multi-input">
	               <label>생년월일</label>
	               <div class="input-form">
	                   <select id="year" name="year" title="년도" class="custom-select"></select>
	                   <select id="month" name="month" title="월" class="custom-select"></select>
	                   <select id="day" name="day" title="일" class="custom-select"></select>
	               </div>
	           </div>
	        <div>
	        	<input type="checkbox" id="student" name="check1"><label for="student">학생입니다</label>
	        	<input type="checkbox" id="teacher" name="check1"><label for="teacher">선생님입니다</label>
	        </div>
			<div>
				<button type="submit">가입하기</button>
			</div>
		</div>
		</form>
	</div>
<script type="text/javascript" src="stc/js/join.js"></script>
<script type="text/javascript" src="stc/js/address.js"></script>
<script type="text/javascript" src="stc/js/birthday.js"></script>
<script type="text/javascript" src="stc/js/checkOne.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>