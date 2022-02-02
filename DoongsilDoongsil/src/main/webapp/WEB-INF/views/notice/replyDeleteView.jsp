<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <title>댓글삭제페이지</title>
	 <jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	$(document).ready(function() {
		var formObj = $("form[name='deleteForm']");
		
		$("#cancel_btn").on("click", function() {
			location.href = "/notice/noticeView?not_id=${replyDelete.n_id}";
		})
	})
	</script>
<body>
	<header>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/><br>
	</header>
	

	<div style="display:none">글번호 : ${replyDelete.n_id}</div>
	
		<section class="container">
		<form name="deleteForm" role="form" method="post" action="/notice/replyDelete">
			<input type="hidden" name="n_id" value="${replyDelete.n_id}" readonly="readonly"/>
			<input type="hidden" id="reply_number" name="reply_id" value="${replyDelete.reply_id}" />
			<input type="hidden" id="replytext" name="reply_contents" value="${replyDelete.reply_contents}" />
		<div class="alert alert-primary d-flex align-items-center" role="alert">
	  	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
	    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
	  </svg>
	  <div>
	    &nbsp;&nbsp;댓글을 삭제하시겠습니까?
	    <div class="btn-group" role="group" aria-label="Basic outlined example">
				&nbsp;&nbsp;<button type="submit" class="btn btn-outline-primary active" id="delete_btn">예. 삭제합니다</button>
				<button type="button" class="btn btn-outline-primary" id="cancel_btn">아니요. 삭제하지 않습니다</button>
		</div>
	  </div>
	  </div>

		</form>
	</section>
</body>
</html>