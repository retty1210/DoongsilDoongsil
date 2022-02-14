<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙제 상세 페이지</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="shwr_url" value="/stc/js/homework/s_homework_write.js" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${shwr_url}"></script>
<c:url var="hwr_css3_url" value="/stc/css/homework_type3.css" />
<link href="${hwr_css3_url}" rel="stylesheet" type="text/css" />
<c:url var="hwr_t3_url" value="/stc/js/homework/homework_type3.js" />
<script type="text/javascript" src="${hwr_t3_url}" ></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic-coding.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumJungHagSaeng.css" rel="stylesheet">
</head>
<body>
	<script type="text/javascript">
		window.onload = function() {
			if(session.getAttribute("error") != null) {
				var error = '<%=(Boolean)session.getAttribute("error") %>';
				if(error) {
					var error_msg = '<%=(String)session.getAttribute("error_msg") %>';
					if(error_msg != null) {
						alert(error_msg);
					}
				}
			}
		}
	</script>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<div class="body-wrapper">
		<main role="main" class="container-fluid">
			<div class="container body-content">
				<div class="container row tmg20">
					<section class="bdr-1 bdr-r5">
						<div class="row tmg10">
							<div class="col-md-12">
								<h3>${data.getTho_title() }</h3>
							</div>
						</div>
						<div class= "row tmg10">
							<div class="col-md-2">
								<button type="button" class="btn btn-sm btn-sbl" onclick="location='/homework'">목록으로</button>
									<c:if test="${sessionScope.accountNumber == data.getTho_writer() }">
										<button type="button" class="btn btn-sm btn-drt" onclick="deleteHW(${data.getTho_id()})'">삭제</button>
									</c:if>
							</div>
							<div class="col-md-2">
								<p><strong>글쓴이</strong> ${writerName }</p>
							</div>
							<div class="col-md-1">
								<span>${data.getTho_grade() }학년${data.getTho_class() }반  </span>
							</div>
							<div class="col-md-2">
								<span><strong>조회수</strong> ${data.getTho_count() }회</span>
							</div>
							<div class="col-md-5">
								<span>
									<c:choose>
										<c:when test="${data.getTho_homeworktype() == 3 }">
											<strong>일기 시작 날짜</strong>
										</c:when>
										<c:otherwise>
											<strong>글 쓴 날짜</strong>
										</c:otherwise>
									</c:choose>
									 ${data.getTho_writedate() }  
								</span>
								<c:if test="${data.getTho_deadline() != null}">
									<div class="pd10"></div>
									<span>
									<c:choose>
										<c:when test="${data.getTho_homeworktype() == 3 }">
											<strong>일기 마지막 날짜</strong>
										</c:when>
										<c:otherwise>
											<strong>제출 마감일</strong>
										</c:otherwise>
									</c:choose>
									${data.getTho_deadline() }
									</span>
									<div>
										<input type="hidden" id="tho_deadline" value="${data.getTho_deadline() }">
									</div>
								</c:if>
							</div>
						</div>
						
						<div class="row tmg10 flex">
							<c:if test="${img != null }">
								<c:forEach items="${img }" var="i" varStatus="index">
									<div class="col-md-4">
										<c:url var="imgURL" value="/stc/up/${i}" />
										<a href="${imgURL }" target="_blank">
											<img class="imgfull" src="${imgURL }">
										</a>
									</div>
								</c:forEach>
							</c:if>
							<c:choose>
								<c:when test="${data.getTho_homeworktype() == 1 || data.getTho_homeworktype() == 3}">
									<div class="row flex tmg20">
										<div class="col-md-2 vtc">
											<strong>내용</strong>
										</div>
										<div class="col-md-10 vtc">${data.getTho_contents() }</div>
									</div>
								</c:when>

							</c:choose>
						</div>
					</section>

					<hr>
				</div>
				
				<c:choose>
					<c:when test="${sessionScope.accountType == 'T' }">
						<div class="container row tmg40">
							<jsp:include page="/WEB-INF/views/homework/detail/detail_s_teacher.jsp" flush="false" />
						</div>
					</c:when>
					<c:when test="${sessionScope.accountType == 'S' }">
						<div class="container row tmg40">
							<jsp:include page="/WEB-INF/views/homework/detail/detail_s_student.jsp" flush="false" />
						</div>
					</c:when>
					<c:otherwise>
						<span>로그인 값이 없습니다.</span>
					</c:otherwise>
				</c:choose>
			</div>
		</main>
		<footer>
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</footer>
	</div>
</body>
</html>