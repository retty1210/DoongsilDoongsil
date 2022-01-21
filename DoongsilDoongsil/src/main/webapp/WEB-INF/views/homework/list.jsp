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
</head>
<body>
	<header>
	</header>
	<main role="main">
		<section>
			<div>
				<table name="t_hw_table" id="t_hw_table">
					<tr>
						<td>ID</td>
						<td>제목</td>
						<td>날짜</td>
						<td>마감기한</td>
						<td>조회수</td>
					<tr>
					
					<c:forEach var="data" items="${datas}">
					
						<tr>
							<td>${data.getTho_id() }</td>
							<c:url var="t_homeURL" value="/homework?id=${data.getTho_id() }" />
							<td><a href="${t_homeURL}">${data.getTho_title()}</a></td>
							<td>
								<fmt:formatDate value="${data.getTho_writedate() }" type="both" pattern="YY/MM/dd(E) a hh:mm"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${data.getTho_deadline() == null}">
										X
									</c:when>
									<c:otherwise>
										${data.getTho_deadline() }
									</c:otherwise>
								</c:choose>
							</td>
							<td>${data.getTho_count()}</td>
						</tr>
					
					</c:forEach>
					
				</table>
			</div>
			<div>
				<button type="button" onclick="window.open('/homework/write')">새로운 숙제 올리기</button>
			</div>
		</section>
	</main>
</body>
</html>