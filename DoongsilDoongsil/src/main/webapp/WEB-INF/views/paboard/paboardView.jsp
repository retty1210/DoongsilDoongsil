<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='readForm']");
		
		// 수정 
		$(".update_btn").on("click", function(){
			$("#pab_title,#pab_contents").removeAttr("readOnly");
			$(".update_btn").on("click",function(){
				formObj.attr("action", "/paboardUpdate");
				formObj.attr("method", "post");
				formObj.submit();	
			})				
		})
		
		// 삭제
		$(".delete_btn").on("click", function(){
			if(confirm('게시물을 삭제 하시겠습니까 ?')){
				formObj.attr("action", "/paboardDelete");
				formObj.attr("method", "get");
				formObj.submit();
			}else{
				alert('게시글 삭제를 취소하셨습니다.');
				location.reload();
			}
			
		})
		
		// 취소
		$(".list_btn").on("click", function(){
			
			location.href = "/paboardList";
		})
	})
</script>
<style type="text/css" rel=stylesheet">
	.form-control:not(:first-child){
		width:1300px;
	}
	.update_btn,
	.delete_btn,
	.list_btn{
		width:80px;
		height:30px;
		background-color:#085ED6;
		color:white;
		border:none;
		border-radius:8px;
	}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<div id="root">
			<h1>학부모 게시판</h1>
		
			
			
			<section id="container">
				<form role="form" method="post" name="readForm">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="pab_id" class="form-label">글 번호</label><input type="text" id="pab_id" name="pab_id" value="${view.pab_id}" class="form-control" readOnly/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_title" class="form-label">제목</label><input type="text" id="pab_title" name="pab_title" value="${view.pab_title}" class="form-control"readOnly/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_contents" class="form-label">내용</label><textarea id="pab_contents" name="pab_contents" style="resize:none;" rows="10" class="form-control" readOnly><c:out value="${view.pab_contents}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_writer" class="form-label">작성자</label><input type="text" id="pab_writer" value="${view.paa_UserName}" class="form-control" readOnly />
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_date" class="form-label">작성날짜</label>
									<fmt:formatDate value="${view.pab_date}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>	
						</tbody>			
					</table>
					<div>
						<c:if test="${sessionScope.account.paa_id eq view.pab_writer}">
						<button type="button" class="update_btn">수정</button>
						<button type="button" class="delete_btn">삭제</button>
						</c:if>
						<button type="button" class="list_btn">목록</button>
					</div>
				</form>
			</section>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
</body>
</html>