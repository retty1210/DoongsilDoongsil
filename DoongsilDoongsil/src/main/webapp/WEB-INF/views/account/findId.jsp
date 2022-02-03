<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form action="./findId" method="post">
		<div class="search-title">
			<h3>휴대폰 본인확인</h3>
		</div>
		<section class="form-search">
			<div class="find-name">
				<label>이름</label> <input type="text" name="member_name"
					class="btn-name" placeholder="등록한 이름"> <br>
			</div>
			<div class="find-phone">
				<label>번호</label> <input type="text" onKeyup="addHypen(this);"
					name="member_phone" class="btn-phone" placeholder="휴대폰번호를 '-'없이 입력">
			</div>
			<br>
		</section>
		<div class="btnSearch">
			<input type="button" name="enter" value="찾기" onClick="id_search()">
			<input type="button" name="cancle" value="취소"
				onClick="history.back()">
		</div>
	</form>
</body>
</html>