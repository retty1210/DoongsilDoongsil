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
	</form>
</body>
</html>