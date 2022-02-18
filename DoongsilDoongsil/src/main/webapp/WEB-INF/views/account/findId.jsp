<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생과 교사 아이디 찾기</title>
<script type="text/javascript" src="stc/jq/jquery-3.6.0.min.js"></script>
<link href="/stc/css/findId.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="box">
		<div class="in-box">
		<form action="./findId" method="post" name="findform">
			<div class="search-title">
				<h3>학생과 교사 본인확인</h3>
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
					<button class="enter" id="check" name="enter" value="check" type="submit">찾기</button>
					<input type="button" class="cancle" name="cancle" value="취소" onClick="location.href='/login'">
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
						<h4>검색된 아이디는 아래와 같습니다.</h4>
						<c:forEach var="selectId" items="${id }" varStatus="a">
							<label>"${selectId.sta_username}"</label>
						</c:forEach>
					</c:if>
				</div>
			</section>
		</form>
		<div class="form-label-group">
			<input class="btn-return"
				type="button" value="돌아가기" onclick="location.href='/login'">
		</div>
		</div>
		
		<form action="./findId2" method="post" name="findform2">
			<div class="search-title">
				<h3>학부모 본인확인</h3>
			</div>
			<section class="form-search">
				<div class="find-name">
					<label class ="pa_name">이름</label> 
					<input type="text" name="paa_child_id" id="paa_child_id" class="child" placeholder="아이의 번호" required>
					<input class="inner input_inner" type="button" type="submit" onclick="findChild(this);" value="검색">
					<span id="must-ck" class="hid_span_area"></span>
				</div>
				<div class="find-phone">
					<label>번호</label> 
					<input type="text" name="paa_phonenumber" class="btn-phone" placeholder="휴대폰 번호를 입력하세요">
				</div>
				<div class="btnSearch">
					<button class="enter" id="check" name="enter" value="check" type="submit">찾기</button>
					<input type="button" class="cancle" name="cancle" value="취소" onClick="location.href='/login'">
				</div>
			
				<div class="check2">
					<!-- 이름과 전화번호가 일치하지 않을 때-->
					<c:if test ="${check == 3}">
						<script>
							opener.document.findform2.paa_child_id.value = "";
							opener.document.findform2.paa_phonenumber.value = "";
						</script>
						<label class="dis">일치하는 정보가 존재하지 않습니다.</label>
					</c:if>
					
					<!-- 이름과 전화번호가 일치할 때 -->
					<c:if test ="${check == 2}">
						<h4>검색된 아이디는 아래와 같습니다.</h4>
						<c:forEach var="selectId2" items="${id2 }" varStatus="a">
							<label>"${selectId2.paa_username}"</label>
						</c:forEach>
					</c:if>
				</div>
			</section>
		</form>
		<div class="form-label-group">
			<input class="btn-return"
				type="button" value="돌아가기" onclick="location.href='/login'">
		</div>
	</div>
	
	<script type="text/javascript">
		$('input[name=paa_child_id]').focusout(function() {
		      var paid = $('input[name=paa_child_id]').val();
		      var check = /^[0-9]+$/;
		      if(!check.test(paid)) {
		            $('#must-ck').text("번호로 된 아이디만 입력가능");
		            return false;
		        } else if(check.test(paid)){
		            $('#must-ck').text("");
		        }
		   });

		function findChild(href) {	
			window.open("/childCheck","popup","width=500,height=605");
		}
	</script>
<script type="text/javascript" src="stc/js/addHypen.js"></script>
<script type="text/javascript" src="stc/js/join.js"></script>
</body>
</html>