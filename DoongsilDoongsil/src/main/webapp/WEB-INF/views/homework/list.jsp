<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학년 반의 학급게시판</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<main role="main" class="container">
		<section class="perc80">
				<table name="t_hw_table" id="t_hw_table" class="table table-bordered">
					<thead>
					<tr class="info">
						<td scope="col">ID</td>
						<td scope="col" colspan="8">제목</td>
						<td scope="col" colspan="2">날짜</td>
						<td scope="col" colspan="2">마감기한</td>
						<td scope="col">조회수</td>
					<tr>
					</thead>
					<c:forEach var="data" items="${datas}">
					
						<tr>
							<td>${data.getTho_id() }</td>
							<c:url var="t_homeURL" value="/homework/detail?tho_id=${data.getTho_id() }" />
							<td colspan="8"><a href="${t_homeURL}">${data.getTho_title()}</a></td>
							<td colspan="2">
								<fmt:formatDate value="${data.getTho_writedate() }" type="date" pattern="YY/MM/dd(E)"/>
							</td>
							<td colspan="2">
								<c:choose>
									<c:when test="${data.getTho_deadline() == null}">
										X
									</c:when>
									<c:otherwise>
										<fmt:formatDate value="${data.getTho_deadline() }" type="date" pattern="YY/MM/dd(E)"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${data.getTho_count()}</td>
						</tr>
					
					</c:forEach>
					
				</table>
			
			<div>
				<button type="button" onclick="location.href='/homework/write'" class="btn btn-sbl btn-lg">새로운 숙제 올리기</button>
			</div> <!-- -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
	</footer>
</body>
</html>