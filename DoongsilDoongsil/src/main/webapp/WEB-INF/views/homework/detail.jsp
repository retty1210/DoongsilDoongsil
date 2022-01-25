<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙제 상세 페이지</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="shwr_url" value="/stc/js/s_homework_write.js" />
<script type="text/javascript" src="${shwr_url}" ></script>
</head>
<body>
	<header></header>
	<main role="main">
		<section>
			<table>
				<tr>
					<td colspan="4">
						<h3>${data.getTho_title() }</h3>
					</td>
				</tr>
				<tr>
					<td>
						글쓴이
					</td>
					<td>
						<!-- tho_writer값으로 STAccount select해서 session에 글쓴이 이름 추가 -->
					</td>
					<td colspan="2">
						${data.getTho_grade() }학년 ${data.getTho_class() }반
					</td>
				</tr>
				<tr>
					<td>
						글 쓴 날짜
					</td>
					<c:choose>
						<c:when test="${data.getTho_deadline() != null}">
							<td>
								${data.getTho_writedate() }
							</td>
							<td>
								제출 마감일
							</td>
							<td>
								${data.getTho_deadline() }
							</td>
						</c:when>
						<c:otherwise>
							<td colspan="3">
								${data.getTho_writedate() }
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<c:choose>
					<c:when test="${data.getTho_homeworktype() == 1 }">
						<c:if test="${img != null }">
							<c:forEach items="${img }" var="i" varStatus="index">
								<tr>
									<td>
										${index.count}번째 이미지
									</td>
									<td colspan="3">
										<c:url var="imgURL" value="/stc/up/${i}" />
										<img src="${imgURL }">
									</td>
								</tr>
							</c:forEach>
							
						</c:if>
						<tr>
							<td>
								내용
							</td>
							<td colspan="3">
								${data.getTho_contents() }
							</td>
						</tr>
					</c:when>
					<c:when test="${data.getTho_homeworktype() == 2 }">
						<tr>
							<td colspan="4">2</td>
						</tr>
					</c:when>
				</c:choose>
			</table>
		</section>
		
		<hr>
		
		<!-- 교사용 section->구분은 interceptor가 아니라 controller로 할 것 -->
		<section>
			<c:choose>
				<c:when test="${sdatas != null }">
					<c:if test="${data.getTho_homeworktype() == 1 }">
						<c:forEach var="sdata" items="${sdatas }">
							<form action="/ajaxComment" method="post" id="ajaxComment${sdata.getSho_id() }">
							<table>
								<tr>
									<td>${sdata.getSho_id() }</td> <!-- 나중에는 Account table 서치해서 이름 넣게 -->
									<td colspan="5">${sdata.getSho_contents() }</td>
									<td>
										<div name="ajax_good" id="ajax_good${sdata.getSho_id() }" onclick="ajax_good(${sdata.getSho_id() })">잘했어요</div>
										<input type="hidden" name="sho_goodbad" id="sho_good${sdata.getSho_id() }" value="G" disabled>
									</td>
									<td>
										<div name="ajax_bad" id="ajax_bad${sdata.getSho_id() }" onclick="ajax_bad(${sdata.getSho_id() })">아쉬워요</div>
										<input type="hidden" name="sho_goodbad" id="sho_bad${sdata.getSho_id() }" value="N" disabled>
									</td>
								</tr>
								<tr>
									<td colspan="8">
										<button type="button" id="btn_comment${sdata.getSho_id() }" onclick="commentCheck(${sdata.getSho_id() })">숙제에 대한 평가 입력창 열기</button>
									</td>
								</tr>
							</table>
							
							<div id="commentArea${sdata.getSho_id() }">
								<div>
									<textarea name="sho_comment" id="sho_comment${sdata.getSho_id() }" placeholder="학생의 숙제에 대한 평가를 입력하세요(선택)"></textarea>
								</div>
								<div>
									<input type="number" name="sho_id" id="sho_comment_id${sdata.getSho_id() }" value="${sdata.getSho_id() }" style="display:none;">
								</div>
								<div>
									<button type="button" onclick="submitAjaxComment(${sdata.getSho_id() })">채점결과와 숙제에 대한 평가 함께 제출하기</button>
								</div>
							</div>
						</form>
						</c:forEach>
					
						
					</c:if>
					
					<c:if test="${data.getTho_homeworktype() == 2 }">
						<table>
							<tr>
								<td colspan="2"><p>homework type 2</p></td>
							</tr>
						</table>
					</c:if>
				</c:when>
				<c:otherwise>
					<h4>아직 아무도 숙제를 제출하지 않았습니다.</h4>
				</c:otherwise>
			</c:choose>
			
		</section>
		
		<hr>
		
		<!-- 학생용 section -->
		<section>
			<!-- session에 있는 학생정보와 TID값으로 select했을때 결과값이 null인 경우 -->
			<div>
				<span>학생이 올린 숙제가 없을때</span>
				<form id="hw_up_form" name="hw_up_form" action="/homework/write/up/file" method="post" enctype="multipart/form-data">
					<div>
						<button id="btn_up" name="btn_up" type="button">업로드할 사진 선택하기</button>
						<span>사진 업로드는 3장까지 가능합니다.</span>
					</div>
					<div id="uploadFileName">
						
					</div>
					<input multiple="multiple" type="file" name="picFile" id="picFile" style="display:none;">
				</form>
			</div>
			<div>
				<button type="button" onclick="fileUp()">사진 업로드</button>
			</div>
			<form id="s_homework_input" action="/studentup" method="post">
				<table>
					<tr>
						<td colspan="3">
							<textarea name="sho_contents" id="sho_contents" placeholder="내용을 입력하세요"></textarea>
						</td>
						<td>
							<button type="button" onclick="submitSH()">제출하기</button>
						</td>
					</tr>
				</table>
				<div>
					<input type="number" name="sho_tid" id="sho_tid" value="${data.getTho_id() }" style="display:none;">
					<input type="number" name="sho_writer" id="sho_writer" value="4" style="display:none;">
					<input type="number" name="sho_homeworktype" id="sho_homeworktype" value="${data.getTho_homeworktype() }" style="display:none;">
					<input type="number" name="sho_grade" id="sho_grade" value="1" style="display:none;">
					<input type="number" name="sho_class" id="sho_class" value="2" style="display:none;">
					<input type="date" name="sho_date" id="sho_date" style="display:none;">
					<input type="hidden" name="sho_fileurl" id="sho_fileurl">
				</div>
			</form>
			
			<hr>
			
			<!-- select했을 때 결과값이 있을 경우 -->
			<span>학생이 올린 숙제가 있을때</span>
			<table>
				<tr>
					<td colspan="5">숙제내용</td>
					<!-- 채점이 되었을 때 -->
					<td colspan="3"><div id="SHResult">select한 채점결과 insert</div></td>
					<!-- 채점이 안 되었을 때
						<td>아직 채점중이예요</td>
						<td><button type="button" onclick="updateSH()">수정하기</button></td>
						<td><button type="button" onclick="deleteSH()">삭제하기</button></td>
					 -->
				</tr>
				<!-- comment가 있을 경우 -->
				<tr>
					<td colspan="8">comment 내용</td>
				</tr>
			</table>
			
			<hr>
			
			<!-- 숙제 제출은 안 했는데 마감기한이 지난 경우 -->
			<span>마감기한이 지났을때</span>
			<table>
				<tr>
					<td colspan="8">
						<h6>숙제 제출 기한이 지났어요.</h6>
					</td>
				</tr>
			</table>
		</section>
	</main>
</body>
</html>