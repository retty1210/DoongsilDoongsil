<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <title>공지사항 목록</title>
  </head>
<body class=container>
	<div id="root">
	<header>
		<h1>공지사항</h1>
	</header>
		<!-- 네비넣기nav>	  
			</nav>-->
	<hr />
	<!--작성하기 버튼은 교사만 보이게 수정하기 -->
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<button type="button" class="btn btn-primary" onclick="location.href='/notice/noticeWrite'">작성하기</button>
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
						<a href="/notice/noticeView?not_id=${list.not_id}">
						<c:out value="${list.not_title}" /></a>
					</th>
					<th><c:out value="${list.not_writer}" /></th>
					<th><fmt:formatDate value="${list.not_writedate}" pattern="yyyy-MM-dd"/></th>
					<th><c:out value="${list.not_count }" /></th>
					</tr>	
				</c:forEach>	
			</tbody>				
		</table>
		</form>
	</section>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>