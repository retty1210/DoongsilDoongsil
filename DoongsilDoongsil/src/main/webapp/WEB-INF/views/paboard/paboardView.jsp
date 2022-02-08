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
			formObj.attr("action", "/paboardUpdate");
			formObj.attr("method", "post");
			formObj.submit();				
		})
		
		// 삭제
		$(".delete_btn").on("click", function(){
			formObj.attr("action", "/paboardDelete");
			formObj.attr("method", "get");
			formObj.submit();
		})
		
		// 취소
		$(".list_btn").on("click", function(){
			
			location.href = "/paboardList";
		})
	})
</script>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<div id="root">
			<header>
				<h1>학부모 게시판</h1>
			</header>
			
			<section id="container">
				<form role="form" method="post" name="readForm">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="pab_id">글 번호</label><input type="text" id="pab_id" name="pab_id" value="${view.pab_id}" readOnly/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_title">제목</label><input type="text" id="pab_title" name="pab_title" value="${view.pab_title}"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_contents">내용</label><textarea id="pab_contents" name="pab_contents" style="resize:none;"><c:out value="${view.pab_contents}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_writer">작성자</label><input type="text" id="pab_writer" value="${view.paa_UserName}" readOnly />
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_date">작성날짜</label>
									<fmt:formatDate value="${view.pab_date}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>		
						</tbody>			
					</table>
					<div>
					<button type="button" class="update_btn">수정</button>
					<button type="button" class="delete_btn">삭제</button>
					<button type="button" class="list_btn">목록</button>
					</div>
				</form>
			</section>
			<hr/>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
</body>
</html>