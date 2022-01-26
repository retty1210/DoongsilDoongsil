<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>공지사항 작성</title>
</head>
<body class="container">
	<div id="root">
	<header>
		<h2> 공지사항 수정</h2>
	</header><hr />
	<!-- 네비 넣기
		<div>
		   <!--%@include file="" % </div> --> 
	<section id="container">
	<form name="updateForm" role="form" method="post" action="/notice/update">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">글번호</label>
			<input type="text" name="not_id" class="form-control" id="exampleFormControlInput1" value="${update.not_id}">
		</div>
		<div class="mb-3">
			<label for="not_permit" >열람 권한</label>
			<select class="not_permit" name="not_permit" >
			<option selected >${update.not_permit}</option>
			<option value="S">학생</option>
			<option value="P">학부모님</option>
			<option value="A">학생과 학부모님</option>
			</select>
		</div>
	<div class="mb-3">
 		<label for="exampleFormControlInput1" class="form-label">제목</label>
  		<input type="text" name="not_title" class="form-control" id="exampleFormControlInput1" value="${update.getNot_title()}">
	</div>
	<div class="mb-3">
  		<label for="exampleForControlTextarea1" class="form-label">내용</label>
 		<textarea name="not_contents" class="form-control" id="exampleFormControlTextarea1" style="height: 350px" ><c:out value="${update.not_contents}" />
 		</textarea>
	</div>
	<!--  
 <div class="mb-3">
 		<label for="exampleFormControlInput1" class="form-label">작성자</label>
  		<input type="text" name="not_writer" class="form-control" id="exampleFormControlInput1" value="교사" readonly="readonly">
	</div>
	-->
	<div class="mb-3">
 		<label for="exampleFormControlInput1" class="form-label">작성일 : </label>
		<fmt:formatDate value="${update.not_writedate}" pattern="yyyy-MM-dd"/>
	</div>
	<div>
		<button type="submit" class="btn btn-primary" id="update_btn">저장</button>
		<button type="button" class="btn btn-primary" id="cancel_btn" onclick="location.href='/notice/noticeList'">취소</button>
	</div>
	</form>
</section>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>