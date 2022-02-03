<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form action="./findPss" method="post">
		<div class="search-title">
			<h3>등록한 정보로 인증</h3>
		</div>
		<section class="form-search">
			<div class="find-id">
				<label>아이디</label> <input type="text" name="member_mid"
					class="btn-name" placeholder="FineApple ID"> <br>
			</div>

			<div class="find-phone">
				<label>번호</label> <input type="text" onKeyup="addHypen(this);"
					name="member_phone" class="btn-phone" placeholder="휴대폰번호를 '-'없이 입력">
			</div>
			<br>
		</section>
		<div class="btnSearch">
			<input type="button" name="enter" value="찾기" onClick="pw_search()">
			<input type="button" name="cancle" value="취소"
				onClick="history.back()">
		</div>
	</form>
</body>
</html>