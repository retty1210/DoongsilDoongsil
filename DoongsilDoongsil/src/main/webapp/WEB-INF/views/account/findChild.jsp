<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자녀 검색</title>
</head>
<body>
	<section>
	<div>
		<h2>자녀 검색</h2>
		<form action="./childCheck" method="post">
			<input type="text" id="sta_name" name="sta_name" placeholder="아이 이름을 입력하세요.">
			<button type="submit">검색</button>
			
			<div>
			<c:if test="${fail_list == 1}">
				<label>
					정보를 찾을 수 없습니다.
				</label>
			</c:if>
			
			<c:if test="${success_list == 0}">
				<div class="tbl-header">
					<table>
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>학년</th>
								<th>반</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="stVo">
								<tr>
									<td>${stVo.sta_id}</td>
									<td>${stVo.sta_name}</td>
									<td>${stVo.sta_grade}</td>
									<td>${stVo.sta_class}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			</c:if>
			</div>
			
			<div>
				<input type="button" value="창닫기" onClick='window.close()'>
			</div>
			</form>
	</div>
	</section>
</body>
</html>