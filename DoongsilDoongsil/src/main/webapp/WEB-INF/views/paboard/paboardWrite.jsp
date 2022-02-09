<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<title>글작성</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<div id="root">
			<header>
				<h1>글작성</h1>
			</header>
			
			<section id="container">
				<form role="form" method="post" action="/paboardWrite">
					<table>
						<tbody>
							<tr>
								<td>
									<label>카테고리</label>
									<select name="pab_category">
										<option selected>---- 카테고리 선택 ----</option>
										<c:forEach var="cg" items="${category }">
											<option value="${cg.pac_id }">${cg.pac_category }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<label for="title">제목</label><input type="text" id="pab_title" name="pab_title" />
								</td>
							</tr>	
							<tr>
								<td>
									<label for="contents">내용</label><textarea id="pab_contents" name="pab_contents" style="resize:none;"></textarea>
								</td>
							</tr>
							<tr>
								<td><input type="hidden" name="pab_writer" value="${sessionScope.account.paa_id }"/></td>
							</tr>
							<tr>
								<td>				
									<button type="button" class="btn btn-primary" onclick="location.href='/paboardList'">취소</button>
									<button type="submit" class="btn btn-primary" >작성</button>
								</td>
							</tr>			
						</tbody>			
					</table>
				</form>
			</section>
		</div>
	</main>
	<footer>
		<div>
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</div>
	</footer>
</body>
</html>

