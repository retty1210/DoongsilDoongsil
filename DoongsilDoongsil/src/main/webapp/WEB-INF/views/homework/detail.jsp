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
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${shwr_url}"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<div class="body-wrapper">
	<main role="main" class="container-fluid">
		<div class="container body-content">
			<div class="row tmg20">
				<section class="bdr-1 bdr-r5">
					<div class="row tmg10">
						<div class="col-md-10"><h3>${data.getTho_title() }</h3></div>
						<div class="col-md-2"><button type="button" class="btn btn-sm btn-sbl" onclick="location='/homework'">목록으로</button></div>
					</div>
					<div class="row tmg10">
						<div class="col-md-2"><strong>글쓴이</strong></div>
						<div class="col-md-3"><p>글쓴사람이름</p></div>
						<div class="col-md-3">
							<p>${data.getTho_grade() }학년 ${data.getTho_class() }반</p>
						</div>
						<div class="col-md-1"><strong>조회수</strong></div>
						<div class="col-md-1"><p>${data.getTho_count() } 회</p></div>
						<!-- 만약 작성자=로그인한 사람인 경우 -->
						<div class="col-md-1">
							<button type="button" class="btn btn-sm btn-drt" onclick="TSHWupdate()">수정</button>
						</div>
						<div class="col-md-1">
							<button type="button" class="btn btn-sm btn-drt" onclick="THWdelete()">삭제</button>
						</div>
					</div>
					<div class="row tmg10">
						<div class="col-md-2"><strong>글 쓴 날짜</strong></div>
						<c:choose>
							<c:when test="${data.getTho_deadline() != null}">
								<div class="col-md-4">${data.getTho_writedate() }</div>
								<div class="col-md-2"><strong>제출 마감일</strong></div>
								<div class="col-md-4">${data.getTho_deadline() }</div>
								<input type="hidden" id="tho_deadline" value="${data.getTho_deadline() }">
							</c:when>
							<c:otherwise>
								<div class="col-md-10">${data.getTho_writedate() }</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="row tmg10">
						<c:if test="${img != null }">
							<c:forEach items="${img }" var="i" varStatus="index">
								<div class="row flex">
									<div class="col-md-12">
										<c:url var="imgURL" value="/stc/up/${i}" />
										<img class="imgfull" src="${imgURL }">
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:choose>
							<c:when test="${data.getTho_homeworktype() == 1 }">
								<div class="row flex tmg20">
									<div class="col-md-2 vtc">
										<strong>내용</strong>
									</div>
									<div class="col-md-10 vtc">
										${data.getTho_contents() }
									</div>
								</div>
							</c:when>
							
						</c:choose>
					</div>
				</section>
				
				<hr>
			</div>	
				<!-- 교사용 section->구분은 interceptor가 아니라 controller로 할 것 -->
			<div class="container row tmg40">	
				<section class="bdr-1 bdr-r5">
					<span>교사용 section</span>
					<c:choose>
						<c:when test="${sdatas != null }">
							<c:if test="${data.getTho_homeworktype() == 1 }">
								<c:forEach var="sdata" items="${sdatas }">
								<!-- sdata의 goodbad가 null이면 폼, 값이 있으면 테이블을 띄움 -->
									<c:choose>
										<c:when test="${sdata.getSho_goodbad() != null }">
											<div class="row tmg10">
												<div class="col-md-1">${sdata.getSho_id() }</div>
												<div class="col-md-2">${sdata.getSho_date() }</div>
												<div class="col-md-7">${sdata.getSho_contents() }</div>
												<c:if test="${sdata.getSho_goodbad() == 'G' }">
													<div class="col-md-1 strblue-b whtcream bdr-1 bdr-r5 mg10">잘했어요</div>
												</c:if>
												<c:if test="${sdata.getSho_goodbad() == 'N' }">
													<div class="col-md-1 strblue-b whtcream bdr-1 bdr-r5 mg10">아쉬워요</div>
												</c:if>
											</div>
											<c:if test="${sdata.getSho_comment() != null }">
												<div class="row tmg10 pd10">
													<div class="col-md-12 bdr-1 bdr-r5 palesblue-b drtblue">
														${sdata.getSho_comment() }
													</div>
												</div>
											</c:if>
										</c:when>
										<c:otherwise>
											<form class="form-horizontal" action="/ajaxComment" method="post" id="ajaxComment${sdata.getSho_id() }">
												<div class="form-group bdr-1 bdr-r5 tmg10" style="display:flex;">
													<div class="col-md-1">${sdata.getSho_id() }</div>
													<div class="col-md-9">${sdata.getSho_contents() }</div>
													<div class="col-md-1">
														<div name="ajax_good" id="ajax_good${sdata.getSho_id() }" class="mg10">
															<button class="btn btn-wht btn-sm" id="btn_ajaxGood${sdata.getSho_id() }" type="button" onclick="ajax_good(${sdata.getSho_id() })">잘했어요</button>
														</div>
														<input type="hidden" name="sho_goodbad" id="sho_good${sdata.getSho_id() }" value="G" disabled>
													</div>
													<div class="col-md-1">
														<div name="ajax_bad" id="ajax_bad${sdata.getSho_id() }" class="mg10">
															<button class="btn btn-wht btn-sm" id="btn_ajaxBad${sdata.getSho_id() }" type="button" onclick="ajax_bad(${sdata.getSho_id() })">아쉬워요</button>
														</div>
														<input type="hidden" name="sho_goodbad" id="sho_bad${sdata.getSho_id() }" value="N" disabled>
													</div>
												</div>
												<div class="form-group tmg10">
													<div class="col-md-12 tmg10">
														<button class="btn btn-sbl" type="button" id="btn_comment${sdata.getSho_id() }" onclick="commentCheck(${sdata.getSho_id() })">숙제에 대한 평가 입력창 열기</button>
													</div>
												</div>
												<div class="form-group tmg10 flex" name="commentArea" id="commentArea${sdata.getSho_id() }" >
													<div class="col-md-10">
														<textarea class="form-control" rows="1" name="sho_comment" id="sho_comment${sdata.getSho_id() }" placeholder="학생의 숙제에 대한 평가를 입력하세요(선택)"></textarea>
													</div>
													<div>
														<input type="number" name="sho_id" id="sho_comment_id${sdata.getSho_id() }" value="${sdata.getSho_id() }" style="display:none;">
													</div>
													<div class="col-md-2">
														<button class="btn btn-sbl" type="button" id="btn_submitcomm${sdata.getSho_id() }" onclick="submitAjaxComment(${sdata.getSho_id() })">채점결과와 숙제에 대한 평가 함께 제출하기</button>
													</div>
												</div>
											</form>
										</c:otherwise>
									</c:choose>
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
							<div class="col-md-12 tmg10">
								<h4>아직 아무도 숙제를 제출하지 않았습니다.</h4>
							</div>
						</c:otherwise>
					</c:choose>
					
				</section>
			</div>
			
			<div class="container row tmg40">
			<!-- 학생용 section -->
			<section class="bdr-1 bdr-r5">
				<c:choose>
				
				<c:when test="${data.getTho_homeworktype() == 1 }">
					<!-- session에 있는 학생정보와 TID값으로 select했을때 결과값이 null인 경우 -->
					<div class="col-md-12 tmg20">
						<c:choose>
							<c:when test="${sworksnull == true }">
								<div class="row tmg10">
									<form id="hw_up_form" name="hw_up_form" class="form-horizontal" action="/homework/write/up/file" method="post" enctype="multipart/form-data">
										<div class="form-group pd10">
											<button id="btn_up" name="btn_up" type="button" class="btn btn-wht btn-sm">업로드할 사진 선택하기</button>
											<span class="subtxt">사진 업로드는 3장까지 가능합니다.</span>
										</div>
										<div id="uploadFileName"  class="form-group pd10">
											
										</div>
										<input multiple="multiple" type="file" name="picFile" id="picFile" style="display:none;">
										<div class="form-group pd10">
											<button type="button" id="btn_img_up" onclick="fileUp()" class="btn btn-wht btn-sm">사진 업로드</button>
										</div>
									</form>
								</div>
								<hr>
								<form id="s_homework_input" action="/studentup" method="post" class="form-inline block">
									<div class="form-group flex tmg10">
										<div class="col-md-10 inline">
											<textarea name="sho_contents" id="sho_contents" class="form-control" rows="2" placeholder="내용을 입력하세요"></textarea>
										</div>
										<div class="col-md-1 inline">
											<button type="button" id="btn_submitsh" class="btn-square btn btn-sbl" onclick="submitSH()">제출하기</button>
										</div>
									</div>
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
							</c:when>
							<c:otherwise>
								<div class="row flex tmg10">
									<c:forEach var="swork" items="${sworks }">
										<div class="row tmg5">
											<div class="col-md-8">${swork.getSho_contents() }</div>
											<c:choose>
												<c:when test="${swork.getSho_goodbad() == null }">
													<div class="col-md-2 drtblue-b whtcream bdr-r5 tmg5" id="SHResult${swork.getSho_id() }">
														<h6>아직 채점중이예요</h6>
													</div>
													<div class="col-md-1 tmg5">
														<button type="button" class="btn btn-sm btn-drt" onclick="SHWupdate()">수정</button>
													</div>
													<div class="col-md-1 tmg5">
														<button type="button" class="btn btn-sm btn-drt" onclick="SHWdelete()">삭제</button>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-md-4 drtblue-b bdr-n bdr-r5 whtcream tmg5" id="SHResult${swork.getSho_id() }">
														<c:if test="${swork.getSho_goodbad() == 'G' }">
															잘했어요
														</c:if>
														<c:if test="${swork.getSho_goodbad() == 'N' }">
															아쉬워요
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<c:if test="${swork.getSho_comment() != null }">
											<div class="row tmg10 pd10">
												<div class="col-md-12 bdr-1 bdr-r5 palesblue-b drtblue">
													선생님의 한마디: ${swork.getSho_comment() }
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
				
				<c:when test="${data.getTho_homeworktype() == 2 }">
					<div class="container">
						<form class="form-horizontal" id="type2studentsmform">
							<div class="row flex tmg20">
								<c:forEach items="${type2contents }" var="t2q" varStatus="index">
									<div class="col-md-12 tmg20">
										<div class="row tmg10">
											<div class="col-md-2"><strong>${t2q.key }번 문제</strong></div>
											<div class="col-md-10 left">${t2q.value[1] }</div>
										</div>
										<c:if test="${t2q.value[0] == 'mc' }"> <!-- 객관식 -->
											<c:forEach var="mc" begin="3" end="${t2q.value[2] }">
												<div class="row tmg10">
													<div class="col-md-2 right">
														<input type="radio" id="type2studentsmformmcq${t2q.key }a${mc-2}" name="type2studentsmformmcq${t2q.key }" value="${mc-2 }">
													</div>
													<div class="col-md-10 left">${t2q.value[mc] }</div>
												</div>
											</c:forEach>
										</c:if>
										<c:if test="${t2q.value[0] == 'sc' }"> <!-- 주관식 -->
											<c:if test="${t2q.value[2] == true }">
												<div class="row tmg10">
													<div class="col-md-2"></div>
													<div class="col-md-10 left">
														${t2q.value[3]}
													</div>
												</div>
											</c:if>
											<div class="row tmg10">
												<div class="col-md-2">답 입력하기</div>
												<div class="col-md-10">
													<input type="text" id="type2studentsmformq${t2q.key }sc" class="form-control">
												</div>
											</div>
										</c:if> <!-- 주관식 -->
									</div>
								</c:forEach> <!-- type2contents -->
								<div class="row flex tmg20" id="type2studentsmformbtnArea">
									<div class="col-md-12">
										<c:choose>
											<c:when test="${sworksnull == true }">
												<button type="button" class="btn btn-sbl">숙제 내기</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-sbl">수정하기</button>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</form>
					</div>
				</c:when>
				</c:choose>
			</section>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
	</footer>
	</div>
</body>
</html>