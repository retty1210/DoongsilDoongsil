<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<header>
		<h2> 공지사항 작성</h2>
	</header><hr />
	<!-- 네비 넣기
		<div>
		   <!--%@include file="" % </div> --> 
		
	<section id="container">
		<form role="writeForm" method="post" action="/notice/noticeWrite">
		<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">열람 권한</label>
			<select id="permit" name="not_permit" >
			<option value="S">학생</option>
			<option value="P">학부모님</option>
			<option value="A">학생과 학부모님</option>
			</select>
		</div>
		
		<div class="mb-3">
 			 <label for="exampleFormControlInput1" class="form-label">제목을 입력하세요</label>
  			<input type="text" name="not_title" class="form-control" id="exampleFormControlInput1" >
		</div>
		<div class="mb-3">
  			<label for="exampleFormControlTextarea1" class="form-label">내용을 작성하세요</label>
 			 <textarea name="not_contents" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
		</div>
		<div class="mb-3">
 			 <label for="exampleFormControlInput1" class="form-label">작성자</label>
  			<input type="text" name="not_writer" class="form-control" id="exampleFormControlInput1" >
		</div>
		<div class="mb-3">
 			 <label for="exampleFormControlInput1" class="form-label">작성일 : </label>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
			<c:out value="${today}"/>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button type="submit" class="btn btn-primary" >게시하기</button>
		</div>
	</form>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>