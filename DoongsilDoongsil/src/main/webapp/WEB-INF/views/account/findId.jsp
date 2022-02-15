<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link href="/stc/css/findId.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="box">
	<form action="./findId" method="post" name="findform">
		<div class="search-title">
			<h3>휴대폰 본인확인</h3>
		</div>
		<section class="form-search">
			<div class="find-name">
				<label>이름</label> 
				<input type="text" name="sta_name" class="btn-name" placeholder="등록한 이름"> <br>
			</div>
			<div class="find-phone">
				<label>번호</label> 
				<input type="text" name="sta_phonenumber" class="btn-phone" placeholder="휴대폰 번호 '-' 포함하여 입력">
			</div>
			<div class="btnSearch">
				<button class="enter" name="enter" value="check" type="submit">찾기</button>
				<input type="button" class="cancle" name="cancle" value="취소" onClick="history.back()">
			</div>
		
			<div class="check">
				<!-- 이름과 전화번호가 일치하지 않을 때-->
				<c:if test ="${check == 1}">
					<script>
						opener.document.findform.sta_name.value = "";
						opener.document.findform.sta_phonenumber.value = "";
					</script>
					<label>일치하는 정보가 존재하지 않습니다.</label>
				</c:if>
				
				<!-- 이름과 전화번호가 일치할 때 -->
				<c:if test ="${check == 0}">
					<label>찾으시는 아이디는 "${id}" 입니다.</label>
				</c:if>
			</div>
		</section>
	</form>
	<div class="form-label-group">
		<input class="btn-return"
			type="button" value="돌아가기" onclick="history.back()">
	</div>
	</div>
</body>
</html>