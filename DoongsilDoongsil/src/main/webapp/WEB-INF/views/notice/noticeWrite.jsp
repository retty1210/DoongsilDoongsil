<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 작성</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<script src="/stc/js/summernote/lang/summernote-ko-KR.js"></script>
<c:url var="sn_js_url" value="/stc/js/summernote/summernote-lite.js" />
<c:url var="sn_css_url" value="/stc/css/summernote/summernote-lite.css" />
<link href="${sn_css_url}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${sn_js_url}"></script>
<c:url var="notice_js_url" value="/stc/js/noticeView.js" />
<script type="text/javascript" src="${notice_js_url}"></script>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '내용을 작성해주세요'	//placeholder 설정

			
		});
		
	});

</script>
<body>
<div id="root">
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<div class="container">
	<h2> 공지사항 작성</h2><hr />
	<section id="container">
		<form role="writeForm" method="post" action="/notice/noticeWrite">
		<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">열람 권한</label>
			<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="not_permit" >
			<option selected>열람 대상을 선택해주세요</option>
			<option value="S">학생</option>
			<option value="P">학부모님</option>
			<option value="A">학생과 학부모님</option>
			</select>
		</div>

		<div class="mb-3">
 			 <label for="exampleFormControlInput1" class="form-label">제목을 입력하세요</label>
  			<input type="text" name="not_title" class="form-control" id="exampleFormControlInput1" >
		</div>
		<div >
  			<label >내용을 작성하세요</label>
 			 <textarea name="not_contents" id="summernote"></textarea>
		</div>
		<div class="mb-3">
			<c:if test="${accountType eq 'T' }">
  			<input type="hidden" name="not_writer" class="form-control" id="exampleFormControlInput1" value="${accountNumber }"/>
  			</c:if>
		</div>
		<div class="mb-3">
 			 <label for="exampleFormControlInput1" class="form-label">작성일 : </label>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
			<c:out value="${today}"/>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button type="button" class="btn btn-outline-secondary" onclick="history.back()">목록으로</button>
			<button type="submit" class="btn btn-primary" id="btn" >게시하기</button>
		</div>
	</form>
</section>
</div>
</div>
<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>