<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 목록</title>
<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
		</style>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<body>
	<div id="root">
	<header>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<div class="container">
	<h1>공지사항</h1>
	<hr />
	<!--작성하기 버튼은 교사만 보이게 수정하기 -->
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<button type="button" class="btn btn-outline-primary" onclick="location.href='/notice/noticeWrite'">작성하기</button>
	</div><br>
	<section id="container">
		<form role="form" method="post" action="/notice/noticeList">
		  <table class="table table-hover">
			<thead>
			<tr class="table-secondary">
			<th scope="col">No.</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일</th>
			<th scope="col">조회수</th>
			</tr>
			</thead>	
			<tbody>
				<c:forEach items="${list}" var = "list">
					<tr>
					<th><c:out value="${list.not_id}" /></th>
					<th>
						<a href="/notice/noticeView?not_id=${list.not_id}" style="text-decoration:none; color:black;">
						<c:out value="${list.not_title}" /></a>
					</th>
					<c:choose>
						<c:when test="${list.not_writer eq 5}">
						<th><c:out value="교사" /></th> </c:when>
						<c:otherwise>
						<th><c:out value="작성권한이없는사용자" /></th> </c:otherwise>
					</c:choose>
					<th><fmt:formatDate value="${list.not_writedate}" pattern="yyyy-MM-dd"/></th>
					<th><c:out value="${list.not_count }" /></th>
					</tr>	
				</c:forEach>	
			</tbody>				
		</table>
	<!-- 페이징 -->
	<nav aria-label="Page navigation">
	   <ul class="pagination justify-content-center">
   		 <c:if test="${pageMaker.prev}">
    	 <li class="page-item disabled"><a class="page-link" href="noticeList${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    	 </c:if> 

   	 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li class="page-item" aria-current="page"><a class="page-link" href="noticeList${pageMaker.makeQuery(idx)}">${idx}</a></li>
     </c:forEach>

  	  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li class="page-item"><a class="page-link" href="noticeList${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
   	  </c:if> 
 	 </ul>
  </nav>
</form>
</section>
<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</div>
</div>
</body>
</html>