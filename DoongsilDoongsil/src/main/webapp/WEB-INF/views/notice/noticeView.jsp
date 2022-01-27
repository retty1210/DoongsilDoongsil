<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>공지사항 상세보기</title>
</head>
<c:url var="updateUrl" value="/notice/updateView">
	<c:param name="not_id" value="${read.not_id}"/>
</c:url>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			// 수정 
			$("#update_btn").on("click", function(){
				location.href="${updateUrl}";	
				
			})
			
		// 삭제
		$("#delete_btn").on("click", function(){
			var deleteYN = confirm("삭제하시겠습니가?");
			if(deleteYN == true){
				formObj.attr("action", "/notice/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
		})
			
			// 취소
			$("#list_btn").on("click", function(){	
				location.href = "/notice/noticeList";
			})
		});
	</script>
<body class=container>
<div id="root">
	<header>
		<h1>공지사항</h1>
	</header>
	<hr />
	<!-- 네비넣기 <nav>
			  홈 - 글 작성
	</nav>-->
<section id="container">
	<form name="readForm" role="form" method="post">
		<table class="table">
		<thead>
		   	<tr>
		   	 <th style="display:none;" scope="col">${read.not_id}</th> 
		   	 <th scope="col" >[${read.not_permit}]&nbsp;${read.not_title}</th> 
		   	 <th scope="col" style="text-align:right"><fmt:formatDate value="${read.not_writedate}" pattern="yyyy-MM-dd"/></th>
		  	</tr>
		 </thead>
		 <tbody>	
			<tr>
				<td colspan="3">
					<textarea readonly class="form-control-plaintext" id="not_contents" name="not_contents"  style="height: 350px" ><c:out value="${read.not_contents}" /></textarea>
				</td>
			</tr>
		</tbody>			
		</table>
		<div>
		<!-- 교사만 수정 삭제 버튼 보이기( 나중에 수정하기 )  
		<c:if test="${userid eq NoticeVO.not_writer}">-->
			<button type="button" class="btn btn-primary" id="update_btn">수정</button>
			<a href="/notice/delete?not_id=${read.not_id }" role="button" class="btn btn-primary" id="delete_btn">삭제</a>
			<!--</c:if>-->
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button type="button" class="btn btn-primary" id="list_btn">목록으로</button>
		</div>	
		</form>
	</section>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>