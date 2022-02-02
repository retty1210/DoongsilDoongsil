<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <title>댓글수정페이지</title>
	 <jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$("#cancel_btn").on("click", function(){
				location.href = "/notice/noticeView?not_id=${replyUpdate.n_id}";
			})
			
		})
</script>
	<body>
		<div id="root">
		<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/><br>
			<h4 class="container">댓글 수정하기 ✏️</h4>
		</header>
		<hr class="container"/>

		<section class="container">
			<form name="updateForm" role="form" method="post" action="/notice/replyUpdate">
				<input type="hidden" name="n_id" value="${replyUpdate.n_id}" readonly="readonly"/>
				<input type="hidden" id="rno" name="reply_id" value="${replyUpdate.reply_id}" />
			<div class="input-group mb-3">
				<textarea class="form-control" aria-label="With textarea" id="content" name="reply_contents" />${replyUpdate.reply_contents}</textarea>&nbsp;&nbsp;
				<button type="submit" class="btn btn-outline-primary" id="update_btn">저장</button>

				</div>
					<button type="button" class="btn btn-outline-secondary" id="cancel_btn">돌아가기</button>
			</form>
		<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
		</section>
	</div>
</body>

</html>