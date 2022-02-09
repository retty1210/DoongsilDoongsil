<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학년 반의 학급게시판</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<c:url var="hwr_list_url" value="/stc/js/homework/homework_list.js" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${hwr_list_url}"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<section class="container">
			<div class="container tmg40">
				<table name="t_hw_table" id="t_hw_table" class="table table-bordered perc100">
					<thead>
						<tr class="table-info" name="homework_data_maincol">
							<th scope="col" class="perc10">ID</th>
							<th scope="col" class="perc60">제목</th>
							<th scope="col" class="perc10">날짜</th>
							<th scope="col" class="perc10">마감기한</th>
							<th scope="col" class="perc10">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="homeworkList" begin="1" end="${pages.getTotal() }">
							<c:forEach var="data" items="${datas.get(homeworkList) }">
								<tr name="homework_data_${homeworkList }" >
									<th scope="row" class="perc10">${data.getTho_id() }</th>
									<c:url var="t_homeURL" value="/homework/detail?tho_id=${data.getTho_id() }" />
									<td class="perc60"><a href="${t_homeURL}">${data.getTho_title()}</a></td>
									<td class="perc10">
										<fmt:formatDate value="${data.getTho_writedate() }" type="date" pattern="YY/MM/dd(E)" />
									</td>
									<td class="perc10">
										<c:choose>
											<c:when test="${data.getTho_deadline() == null}">
													X
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${data.getTho_deadline() }" type="date" pattern="YY/MM/dd(E)" />
											</c:otherwise>
										</c:choose></td>
									<td class="perc10">${data.getTho_count()}</td>
								</tr>
							</c:forEach>
						</c:forEach>
						
					</tbody>
				</table>
				<c:if test="${sessionScope.accountType == 'T'}">
					<div class="row mg20">
						<button type="button" onclick="location.href='/homework/write'"
							class="btn btn-sbl btn-lg">새로운 숙제 올리기</button>
					</div>
				</c:if>
				<div class="row tmg20 flex">
					<div style="display:contents;">
						<input id="pageNoInput" type="number" value="${pages.getNowPage() }" style="display:none;">
						<ul class="pagination btn absolute" >
							<li class="page-item">
								<a class="page-link" href="/homework?pageNo=1" aria-label="FirstPage">
									<span aria-hidden="true">«</span>
								</a>
							</li>
							<li class="page-item">
								<a class="page-link" onclick="prePage()" aria-label="Previous">
									<span aria-hidden="true">‹</span>
								</a>
							</li>
							<!-- startpage를 현재페이지 기준 jquery로 작업하도록 로직 짤 것 -->
							
							<c:forEach var="page" begin="${pages.getStartPage() }" end="${pages.getEndPage()}">
								<li class="page-item" id="page-item${page }">
									<a class="page-link" onclick="pageChange(${page })">${page }</a>
								</li>
							</c:forEach>
							
							<li class="page-item">
								<a class="page-link" onclick="nextPage()" aria-label="Next"> 
									<span aria-hidden="true">›</span>
								</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="/homework?pageNo=${pages.getTotal()}" aria-label="LastPage"> 
									<span aria-hidden="true">»</span>
								</a>
							</li>
						</ul>
					</div>
					<div>
						<input type="number" id="pageNo" name="pageNo" style="display:none;" value="${pages.getNowPage() }">
						<input type="number" id="startpage" name="startpage" style="display:none;" value="${pages.getStartPage() }">
						<input type="number" id="lastpage" name="lastpage" style="display:none;" value="${pages.getEndPage()}">
						<input type="number" id="total" name="total" style="display:none;" value="${pages.getTotal()}">
					</div>
				
				</div>
			</div>
		</section>
	</main>
	<footer class="fixed-bottom">
		<div>
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</div>
	</footer>
</body>
</html>