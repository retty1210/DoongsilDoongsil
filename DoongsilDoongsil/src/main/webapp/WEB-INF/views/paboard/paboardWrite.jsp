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
	<div id="root">
		<header>
			<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
		</header>
		<div style="padding: 15px 30px;">
			<h1> 학부모 게시글 작성</h1>
		</div>
		
			<div class="container">
				<section id="container">
					<form role="form" method="post" action="/paboardWrite">
						<table style="margin: 15px 0px;">
							<tbody>
								<tr>
									<td>
										<div class="mb-3">
											<label class="form-label">카테고리</label>
											<select name="pab_category" class="form-select form-select-sm" style="width:1300px;">
												<option selected>---- 카테고리 선택 ----</option>
												<c:forEach var="cg" items="${category }">
													<option value="${cg.pac_id }">${cg.pac_category }</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<label for="title" class="form-label">제목</label><input type="text" id="pab_title" name="pab_title" class="form-control" />
									</td>
								</tr>	
								<tr>
									<td>
										<label for="contents" class="form-label">내용</label><textarea id="pab_contents" name="pab_contents" style="resize:none;" class="form-control" rows="20" ></textarea>
									</td>
								</tr>
								<tr>
									<td><input type="hidden" name="pab_writer" value="${sessionScope.account.paa_id }"/></td>
								</tr>
							</tbody>			
						</table>
						<div>
							<button type="button" class="btn btn-primary" onclick="location.href='/paboardList'">취소</button>
							<button type="submit" class="btn btn-primary" >작성</button>
						</div>
					</form>
				</section>
			</div>
		</div>
		<div>
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</div>
</body>
</html>

