<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link href="/stc/css/findPss.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="box">
	<form action="./findPss" method="post" name="findform">
		<div class="search-title">
			<h3>등록한 정보로 인증</h3>
		</div>
		<section class="form-search">
			<div class="find-id">
				<label>아이디</label> 
				<input type="text" name="sta_username" id="id"
					class="btn-name" placeholder="아이디를 입력하세요."> <br>
			</div>
			<div class="find-phone">
				<label>번호</label> 
				<input type="text" onKeyup="addHypen();"
					name="sta_phonenumber" id="phone" class="btn-phone" placeholder="휴대폰번호를 '-'를 포함하여 입력하세요.">
			</div>
		<div class="btnSearch">
			<button type="submit" name="enter" value="찾기" onClick="pw_search()">찾기</button>
			<input type="button" name="cancle" value="취소" onClick="history.back()">
		</div>
		
		<div class="check">
			<!-- 정보가 일치하지 않을 때-->
			<c:if test ="${check == 1}">
			<div class="dis">
				<script>
					opener.document.findform.sta_username.value = "";
					opener.document.findform.sta_phonenumber.value = "";
				</script>
				<br>
				<label class="dislike">일치하는 정보가 존재하지 않습니다.</label>
			</div>
			</c:if>
	
			<!-- 정보가 일치할 때 -->
			<c:if test ="${check == 0}">
				<div class="hidden-ps">
					<label>비밀번호를 변경해주세요.</label>
				</div>
				<input type="hidden" id="id" name="updateid" value="${updateid}">
				<div class="password-ch">
					<label for="password" class="check-ps">비밀번호</label>
					<input type="password" id="password" name="sta_password" class="form-control"/>
				</div>
				<div class="password-chk">
					<label for="confirmpassword" class="check-psck">비밀번호 확인</label>
					<input type="password" id="confirmpassword" name="confirmpwd" class="form-control"/>
				</div>
				<div class="form-label-group">
						<input class="btn-return"
							type="button" value="비밀번호 변경" onclick="updatePassword()">
				</div>
			</c:if>
		</div>
		
		</section>
	</form>
</div>
	
	<script type="text/javascript">
		function updatePassword(){
			if(document.findform.sta_password.value==""){
				alert("비밀번호를 입력해주세요.");
				document.findform.sta_password.focus();
			} else if(document.findform.sta_password.value != document.findform.confirmpwd.value){
				alert("비밀번호가 일치하지 않습니다.");
				document.findform.confirmpwd.focus();
			} else {
				document.findform.action="update_password";
				document.findform.submit();
			}
		}
	</script>
</body>
</html>