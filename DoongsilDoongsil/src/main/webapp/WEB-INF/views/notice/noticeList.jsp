<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 목록</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="nc_css_url" value="/stc/css/notice.css" />
<link href="${nc_css_url}" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
	$(function() {
		$("#category").change(function() {
			var category = $(this).val();
			if(category == 'S') {
				$("tr[name=tableRowS]").show();
				$("tr[name=tableRowP]").hide();
				$("tr[name=tableRowA]").hide();
			} else if(category == 'P') {
				$("tr[name=tableRowS]").hide();
				$("tr[name=tableRowP]").show();
				$("tr[name=tableRowA]").hide();
			} else if(category == 'A') {
				$("tr[name=tableRowS]").hide();
				$("tr[name=tableRowP]").hide();
				$("tr[name=tableRowA]").show();
			} else {
				$("tr[name=tableRowS]").show();
				$("tr[name=tableRowP]").show();
				$("tr[name=tableRowA]").show();
			}
		});
	});

	function changeSelect(){ 
		let s = document.querySelector(".selectType");
		s.submit();
	}
</script>
<body>
	<div id="root">
	<header>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<div class="container">
	<h1>공지사항</h1>
	<hr />
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	<c:if test="${accountType eq 'T' }">
		<button type="button" class="btn btn-outline-primary" onclick="location.href='/notice/noticeWrite'">작성하기</button>
	</c:if></div>
	
	<section id="container" >	
		<div class="col-sm-3">
				<select id="category" onchange="changeSelect();" class="form-select"  name="not_permit">
					<option selected>열람 대상을 선택하세요</option>
					<option value="S">학생</option>
					<option value="P">학부모님</option>
					<option value="A" >학생과 학부모님</option>
				</select>
				<br>
			</div>	
		<table class="table table-hover" style="width:100%">
			<thead>
			<tr style="background-color:#C1F1FF;">
			<th style="width:10%;text-align:center;">No.</th>
			<th style="text-align:center; width:50%">제목</th>
			<th style="width:10%;">작성자</th>
			<th style="width:10%;text-align:center;">등록일</th>
			<th style="width:10%;text-align:center;">조회수</th>
			<th style="width:10%;text-align:center;">첨부파일</th>
			</tr>
		</thead>	
			<tbody>	
				<c:forEach items="${list}" var = "list">	
					<tr name="tableRow${list.not_permit }">
					<th style="width:10%; text-align:center;"><c:out value="${list.not_id}" /></th>
					<td style="width:50%; text-align:center;" >
						<a href="/notice/noticeView?not_id=${list.not_id}" style="text-decoration:none; color:black;">
						<c:out value="${list.not_title}" />
							<c:if test="${list.reply_count ne 0}">
							<small><b>[<c:out value="${list.reply_count}"/>]</b></small>
							</c:if>
					</a></td>		
					<td style="width:10%"><c:out value="교사" /></td> 		
					<td style="width:10%; text-align:center;"><fmt:formatDate value="${list.not_writedate}" pattern="yyyy-MM-dd"/></td>
					<td style="width:10%; text-align:center;" ><c:out value="${list.not_count }" /></td>
					<td style="width:10%; text-align:center;" > <c:if test="${list.not_file_name ne null}"> 
						<a href="fileDownload.do?fileName=${list.not_file_name}" download>
						<img src="/stc/img/clip.png" class="file-img" /> 	
						
						</a>			
						</c:if> 
					</td>				
					</tr>	
				</c:forEach>	
			</tbody>				
		</table>
		
	<div style="display:contents;">
		<ul class="pagination justify-content-center">
			<!-- 이전 버튼 -->
			<c:if test="${pageMaker.prev}">
				<li class="page-item">
					<a class="page-link" href="listPage${pageMaker.makeQuery(pageMaker.startPage-1)}">
					 <span aria-hidden="true">&laquo;</span></a>
				</li>
			</c:if>		
			<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var ="idx">
					<li class="page-item">
						<a class="page-link " href="/notice/noticeList${pageMaker.makeQuery(idx)}">			
							<span>${idx}</span>
						</a>
					</li>
				</c:forEach>			
			<!-- next 버튼 -->
			<c:if test="${pageMaker.next}">
				<li class="page-item">
			    	<a class="page-link" href="listPage${pageMaker.makeQuery(pageMaker.endPage + 1)}">
			    	<span aria-hidden="true">&raquo;</span></a>
				</li>
			</c:if>
		</ul>
	</div>
</section>
</div>
</div>
<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>