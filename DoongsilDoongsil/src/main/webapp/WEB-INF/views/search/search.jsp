<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>둥실둥실 - 검색!</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false"/>
<style type="text/css" rel="stylesheet">
	tr{
		border-bottom:1px solid black;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	<table align="center" style="text-align:center;">
		<tr>
			<th>번호</th>
			<th width="70%">제목</th>
			<th>작성자</th>
			<th>작성날짜</th>
			<th>조회수</th>
		</tr>
		<c:choose>
			<c:when test="${searchError != null}">
				<tr>
					<td colspan="5">${searchError }</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="search" items="${searchList }">
					<tr>
						<td>${search.searchId }</td>
						<td>${search.searchTitle}</td>
						<td>${search.searchUserName}</td>
						<td>${search.searchDate}</td>
						<td>${search.searchCount}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"></jsp:include>
</body>
</html>