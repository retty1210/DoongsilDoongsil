<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생과 교사 비밀번호 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link href="/stc/css/findPss.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="box">
		<form action="./findPss" method="post" name="findform">
			<div class="search-title">
				<h3>학생과 교사</h3>
			</div>
				<div class="find-id">
					<label>아이디</label> 
					<input type="text" name="sta_username" id="id"
						class="form-control is-valid" placeholder="아이디를 입력하세요."> <br>
				</div>
				<div class="find-phone">
					<label>번호</label> 
					<input type="text" onKeyup="addHypen();"
						name="sta_phonenumber" id="phone" class="btn-phone" placeholder="휴대폰번호를 '-'를 포함하여 입력하세요.">
				</div>
			<div class="btnSearch">
				<button type="submit" name="enter" value="찾기" onClick="pw_search()">찾기</button>
				<input type="button" name="cancle" value="취소" onClick="location.href='/login'">
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
						<span id="must-pw" class="hid_span_area"></span>
					</div>
					<div class="password-chk">
						<label for="confirmpassword" class="check-psck">비밀번호 확인</label>
						<input type="password" id="confirmpassword" name="confirmpwd" class="form-control"/>
						<span id="must-pw-ck" class="hid_span_area"></span>
					</div>
					<div class="form-label-group">
							<input class="btn-return"
								type="button" value="비밀번호 변경" onclick="updatePassword()">
					</div>
				</c:if>
			</div>
		</form>
			
       <form action="./findPss2" method="post" name="findform2">
		<div class="search-title">
			<h3>학부모</h3>
		</div>
			<div class="find-id">
				<label>아이디</label> 
				<input type="text" name="paa_username" id="id"
					class="form-control is-invalid" placeholder="아이디를 입력하세요."> <br>
			</div>
			<div class="find-phone">
				<label>번호</label> 
				<input type="text" onKeyup="addHypen();"
					name="paa_phonenumber" id="phone" class="btn-phone" placeholder="휴대폰번호를 '-'를 포함하여 입력하세요.">
			</div>
		<div class="btnSearch">
			<button type="submit" name="enter" value="찾기" onClick="pw_search()">찾기</button>
			<input type="button" name="cancle" value="취소" onClick="location.href='/login'">
		</div>
		
		<div class="check">
			<!-- 정보가 일치하지 않을 때-->
			<c:if test ="${check == 3}">
			<div class="dis">
				<script>
					opener.document.findform2.paa_username.value = "";
					opener.document.findform2.paa_phonenumber.value = "";
				</script>
				<br>
				<label class="dislike">일치하는 정보가 존재하지 않습니다.</label>
			</div>
			</c:if>
	
			<!-- 정보가 일치할 때 -->
			<c:if test ="${check == 2}">
				<div class="hidden-ps">
					<label>비밀번호를 변경해주세요.</label>
				</div>
				<input type="hidden" id="id" name="updateid2" value="${updateid2}">
				<div class="password-ch">
					<label for="password" class="check-ps">비밀번호</label>
					<input type="password" id="password" name="paa_password" class="form-control"/>
					<span id="must-pw2" class="hid_span_area"></span>
				</div>
				<div class="password-chk">
					<label for="confirmpassword2" class="check-psck">비밀번호 확인</label>
					<input type="password" id="confirmpassword2" name="confirmpwd2" class="form-control"/>
					<span id="must-pw-ckh2" class="hid_span_area"></span>
				</div>
				<div class="form-label-group">
						<input class="btn-return"
							type="button" value="비밀번호 변경" onclick="updatePassword2()">
				</div>
			</c:if>
		</div>
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
		
		$(document).on("keyup", ".btn-phone", function(addHypen) { 
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
			});
		
		function updatePassword2(){
			if(document.findform2.paa_password.value==""){
				alert("비밀번호를 입력해주세요.");
				document.findform2.paa_password.focus();
			} else if(document.findform2.paa_password.value != document.findform2.confirmpwd2.value){
				alert("비밀번호가 일치하지 않습니다.");
				document.findform2.confirmpwd2.focus();
			} else {
				document.findform2.action="update_password2";
				document.findform2.submit();
			}
		}
	</script>

<script type="text/javascript" src="stc/js/findPss.js"></script>
</body>
</html>