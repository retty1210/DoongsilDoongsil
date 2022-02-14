<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 작성</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="notice_js_url" value="/stc/js/noticefile.js" />
<script type="text/javascript" src="${notice_js_url}"></script>
</head>
<body>
	<div id="root">
	<header>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
<div class="container">
	<h2><a href="/notice/noticeList?page=1" style="text-decoration : none; color:black;"> 공지사항 수정</a></h2><hr/>
	<section id="container">
	<form name="updateForm" role="form" method="post" action="/notice/update" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">글번호</label>
			<input type="text" name="not_id" class="form-control" id="exampleFormControlInput1" value="${update.not_id}" readonly>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label" >열람 권한</label>
			<!-- 세션으로.. if c.. p=학부모, s=학생.... -->
			<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="not_permit" >
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
	<!-- 파일업로드 -->
	<div class="mb-3">
  		<input type="file" name="upload" class="form-control" id="exampleFormControlInput1">
	</div>
	
	<div class="mb-3">
 		<label for="exampleFormControlInput1" class="form-label">작성일 : </label>
		<fmt:formatDate value="${update.not_writedate}" pattern="yyyy-MM-dd"/>
	</div>

	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<button type="button" class="btn btn-outline-secondary" id="cancel_btn" onclick="history.back()">돌아가기</button>
		<button type="submit" class="btn btn-primary" id="update_btn">저장</button>
	</div>
	</form>
</section>
</div>
</div>
<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>