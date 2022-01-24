<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="stc/jq/jquery-1.12.4.min.js"></script>
</head>
<body>
	<form action="./join" method="post">
		<div>
			<label>아이디</label>
			<input type="text" name="id" required> 
			<span id="must-id" class="hid_span_area"> 
				<!--필수 입력입니다.-->
			</span>
		</div>
		<div>
			<label>이름</label>
			<input type="text" name="username" required>
			<span id="must-name" class="hid_span_area">
			</span>
		</div>
		<div>
			<label>비밀번호</label>
			<input type="password" name="password" required> 
			<span id="must-pw" class="hid_span_area"> 
				<!-- 필수 입력입니다.--> 
				<!-- 특수문자 포함 관련 내용-->
			</span>
		</div>
		<div>
			<label>비밀번호 확인</label>
			<input type="password" name="password_chk" required> 
			<span id="must-pw-ck" class="hid_span_area"> 
				<!-- 필수 입력입니다.-->
				<!-- 비밀번호가 일치하지 않습니다.-->
			</span>
		</div>
		<div>
			<label>이메일</label>
			<input type="email" name="email" required>
			<span id="must-email" class="hid_span_area">
            </span>
		</div>
		<div class="multi-select">
			<label>주소</label>
			<div>
				<input type="text" id="sample6_postcode" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" placeholder="주소"><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
			</div>
		</div>
		<div class="multi-input">
               <label>생년월일</label>
               <div class="input-form">
                   <select id="year" title="년도"></select>
                   <select id="month" title="월"></select>
                   <select id="day" title="일"></select>
               </div>
           </div>
        <div>
        	<input type="checkbox" name="check 1" value="student">학생입니다
        	<input type="checkbox" name="check 1" value="teacher">선생님입니다
        </div>
		<div>
			<button type="submit">가입하기</button>
		</div>
	</form>
<script type="text/javascript" src="stc/js/join.jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="stc/js/join.js"></script>
<script type="text/javascript" src="stc/js/address.js"></script>
<script type="text/javascript" src="stc/js/birthday.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>