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
<c:url var="shwr_url" value="/stc/js/s_homework_write.js" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${shwr_url}"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<div class="body-wrapper">
		<main role="main" class="container-fluid">
			<div class="container body-content">
				<div class="row tmg20">
					<section class="bdr-1 bdr-r5">
						<div class="row tmg10">
							<div class="col-md-10">
								<h3>${data.getTho_title() }</h3>
							</div>
							<div class="col-md-2">
								<button type="button" class="btn btn-sm btn-sbl"
									onclick="location='/homework'">목록으로</button>
							</div>
						</div>
						<div class="row tmg10">
							<div class="col-md-2">
								<strong>글쓴이</strong>
							</div>
							<div class="col-md-3">
								<p>글쓴사람이름</p>
							</div>
							<div class="col-md-3">
								<p>${data.getTho_grade() }학년${data.getTho_class() }반</p>
							</div>
							<div class="col-md-1">
								<strong>조회수</strong>
							</div>
							<div class="col-md-1">
								<p>${data.getTho_count() }회</p>
							</div>
							<!-- 만약 작성자=로그인한 사람인 경우 -->
							<div class="col-md-1">
								<button type="button" class="btn btn-sm btn-drt"
									onclick="TSHWupdate()">수정</button>
							</div>
							<div class="col-md-1">
								<button type="button" class="btn btn-sm btn-drt"
									onclick="THWdelete()">삭제</button>
							</div>
						</div>
						<div class="row tmg10">
							<div class="col-md-2">
								<strong>글 쓴 날짜</strong>
							</div>
							<c:choose>
								<c:when test="${data.getTho_deadline() != null}">
									<div class="col-md-4">${data.getTho_writedate() }</div>
									<div class="col-md-2">
										<strong>제출 마감일</strong>
									</div>
									<div class="col-md-4">${data.getTho_deadline() }</div>
									<input type="hidden" id="tho_deadline"
										value="${data.getTho_deadline() }">
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
										<div class="col-md-10 vtc">${data.getTho_contents() }</div>
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
													<div class="col-md-1 tmg10 tpd10">${sdata.getSho_id() }</div>
													<div class="col-md-2 tmg10 tpd10">${sdata.getSho_date() }</div>
													<div class="col-md-7 tmg10 tpd10">${sdata.getSho_contents() }</div>
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
															${sdata.getSho_comment() }</div>
													</div>
												</c:if>
											</c:when>
											<c:otherwise>
												<form class="form-horizontal" action="/ajaxComment"
													method="post" id="ajaxComment${sdata.getSho_id() }">
													<div class="form-group bdr-1 bdr-r5 tmg10"
														style="display: flex;">
														<div class="col-md-1 tmg10">${sdata.getSho_id() }</div>
														<div class="col-md-9 tmg10">${sdata.getSho_contents() }</div>
														<div class="col-md-1">
															<div name="ajax_good" id="ajax_good${sdata.getSho_id() }"
																class="mg10">
																<button class="btn btn-wht btn-sm"
																	id="btn_ajaxGood${sdata.getSho_id() }" type="button"
																	onclick="ajax_good(${sdata.getSho_id() })">잘했어요</button>
															</div>
															<input type="hidden" name="sho_goodbad"
																id="sho_good${sdata.getSho_id() }" value="G" disabled>
														</div>
														<div class="col-md-1">
															<div name="ajax_bad" id="ajax_bad${sdata.getSho_id() }"
																class="mg10">
																<button class="btn btn-wht btn-sm"
																	id="btn_ajaxBad${sdata.getSho_id() }" type="button"
																	onclick="ajax_bad(${sdata.getSho_id() })">아쉬워요</button>
															</div>
															<input type="hidden" name="sho_goodbad"
																id="sho_bad${sdata.getSho_id() }" value="N" disabled>
														</div>
													</div>
													<div class="form-group tmg10">
														<div class="col-md-12 tmg10">
															<button class="btn btn-sbl" type="button"
																id="btn_comment${sdata.getSho_id() }"
																onclick="commentCheck(${sdata.getSho_id() })">숙제에
																대한 평가 입력창 열기</button>
														</div>
													</div>
													<div class="form-group tmg10 flex" name="commentArea"
														id="commentArea${sdata.getSho_id() }">
														<div class="col-md-10 pd10">
															<textarea class="form-control" rows="1"
																name="sho_comment" id="sho_comment${sdata.getSho_id() }"
																placeholder="학생의 숙제에 대한 평가를 입력하세요(선택)"></textarea>
														</div>
														<div class="col-md-2 pd10">
															<button class="btn btn-sbl" type="button"
																id="btn_submitcomm${sdata.getSho_id() }"
																onclick="submitAjaxComment(${sdata.getSho_id() })">채점결과와
																숙제에 대한 평가 함께 제출하기</button>
														</div>
													</div>
													<div>
														<input type="number" name="sho_id"
															id="sho_comment_id${sdata.getSho_id() }"
															value="${sdata.getSho_id() }" style="display: none;">
													</div>
												</form>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>

								<c:if test="${data.getTho_homeworktype() == 2 }">
									<div class="btn-toolbar row flex">
										<c:forEach var="sdata" items="${sdatas}">
											<form class="form-horizontal" action="/Type2ajaxComment"
														method="post" id="Type2ajaxComment${sdata.getSho_id() }">
												<c:choose>
													<c:when test="${sdata.getSho_goodbad() == null }">
														<!-- 아직 채점안됨 -->
														<div class="row"> 
															<div class="col-md-1 tmg10 tpd10">${sdata.getSho_id() }</div>
															<div class="col-md-2 tmg10 tpd10">${sdata.getSho_date() }</div>
															<div class="col-md-7 tmg10 tpd10">
																<div class="btn-group">
																	<c:forEach var="t2answers" items="${type2answers.get(sdata.getSho_id()) }" varStatus="status">
																		<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#makeGoodbadSc${status.count}">
																			<img src="/stc/img/question-lg.svg" class="ic20 filter-whtcream" />
																		</button>
																	</c:forEach>
																</div>
															</div>
															<div class="col-md-2 tmg10 tpd10">
																<button type="button" class="btn btn-sbl">채점완료하기</button>
															</div>
														</div>
														<div>
															<c:forEach var="t2answers" items="${type2answers.get(sdata.getSho_id()) }" varStatus="status">
																<input type="hidden" id="${sdata.getSho_id() }type2q${status.count}Goodbad">
																<div class="modal fade" id="makeGoodbadSc${status.count}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
																	<div class="modal-dialog">
																		<c:set var="type2cont" value="${type2contents.get(status.count) }"/>
																		<div class="modal-content">
																			<div class="modal-header">
																		    	<h5 class="modal-title" id="exampleModalLabel">${status.count }번 문제</h5>
																		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
																			</div>
																			<div class="modal-body">
																				<div class="row">
																					<strong>문제: </strong>${type2cont[1] }
																				</div>
																				<c:choose>
																					<c:when test="${type2cont[0] == 'mc' }">
																						<table class="table table-sm">
																							<thead>
																								<tr>
																									<th scope="col">번호</th>
																									<th scope="col">정답</th>
																									<th scope="col">학생 선택값</th>
																									<th scope="col">문제 내용</th>
																								</tr>
																							</thead>
																							<tbody>
																								<c:forEach var="mcs" begin="1" end="${type2cont[2] }">
																									<tr>
																										<th scope="row">${mcs}</th>
																										<td>
																											<c:if test="${mcs == type2cont[fn:length(type2cont) - 1] }">✔</c:if>
																										</td>
																										<td>
																											<c:if test="${mcs == t2answers }">✔</c:if>
																										</td>
																										<td>
																											${type2cont[mcs+2] }
																										</td>
																									</tr>
																								</c:forEach>
																							</tbody>																						
																						</table>
																					</c:when>
																					<c:when test="${type2cont[0] == 'sc' }">
																						<c:if test="${type2cont[2] == 'Y' }">
																							<div class="row">
																								${type2cont[3] }
																							</div>
																						</c:if>
																					</c:when>
																					<c:otherwise><span>arr[0]값 안읽힘</span></c:otherwise>
																				</c:choose>
																			</div>
																		    <div class="modal-footer">
																				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
																				<button type="button" class="btn btn-success">O</button>
																				<button type="button" class="btn btn-danger">X</button>
																			</div>
																		</div>
																	</div>
																</div>
															</c:forEach>
														</div>
													</c:when>
													<c:otherwise>
														<!-- 채점끝남 -->
														
													</c:otherwise>
												</c:choose>
											</form>
										</c:forEach>
									</div>
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
						<div>
							<input type="hidden" id="Tho_homeworktype_conf" name="Tho_homeworktype_conf" value="${data.getTho_homeworktype() }">
							<input type="hidden" id="sworksnull_conf" name="sworksnull_conf" value="${sworksnull }">
						</div>
						<c:choose>
							<c:when test="${data.getTho_homeworktype() == 1 }">
								<!-- session에 있는 학생정보와 TID값으로 select했을때 결과값이 null인 경우 -->
								<div class="col-md-12 tmg20">
									<c:if test="${sworksnull == true }">
										<div class="row tmg10">
											<form id="hw_up_form" name="hw_up_form" class="form-horizontal" 
												action="/homework/write/up/file" method="post" enctype="multipart/form-data">
												<div class="form-group pd10">
													<button id="btn_up" name="btn_up" type="button"
														class="btn btn-wht btn-sm">업로드할 사진 선택하기</button>
													<span class="subtxt">사진 업로드는 3장까지 가능합니다.</span>
												</div>
												<div id="uploadFileName" class="form-group pd10"></div>
												<input multiple="multiple" type="file" name="picFile"
													id="picFile" style="display: none;">
												<div class="form-group pd10">
													<button type="button" id="btn_img_up" onclick="fileUp()"
														class="btn btn-wht btn-sm">사진 업로드</button>
												</div>
											</form>
										</div>
									</c:if>
									<hr>
									<form id="s_homework_input" method="post" class="form-inline block">
										<c:choose>
											<c:when test="${sworksnull == true }">
												<div class="form-group">
													<div class="form-group flex tmg10">
														<div class="col-md-10 inline">
															<textarea name="sho_contents" id="sho_contents"
																class="form-control" rows="2" placeholder="내용을 입력하세요"></textarea>
														</div>
														<div class="col-md-2 inline">
															<button type="button" id="btn_submitsh"
																class="btn btn-sbl btn-lg" onclick="submitSH1()">제출하기</button>
														</div>
													</div>
													<div>
														<input type="number" name="sho_tid" id="sho_tid_type1"
															value="${data.getTho_id() }" style="display: none;">
														<input type="number" name="sho_writer"
															id="sho_writer_type1" value="4" style="display: none;">
														<input type="number" name="sho_homeworktype" id="sho_homeworktype_type1"
															value="${data.getTho_homeworktype() }" style="display: none;"> 
														<input type="number" name="sho_grade" id="sho_grade_type1" 
															value="1" style="display: none;"> 
														<input type="number" name="sho_class" id="sho_class_type1" 
															value="2" style="display: none;"> 
														<input type="date" name="sho_date" id="sho_date_type1" style="display: none;"> 
														<input type="hidden" name="sho_fileurl" id="sho_fileurl_type1">
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="form-group">
													<c:forEach var="swork" items="${sworks }" varStatus="index">
														<div class="form-group flex tmg10">
															<div class="col-md-10 inline">
																<textarea name="sho_contents" id="sho_contents_type1_${index.count}"
																	class="form-control" rows="2" disabled readonly
																	>${swork.getSho_contents() }</textarea>
															</div>
															<c:choose>
																<c:when test="${swork.getSho_goodbad() == null }">
																	<div class="col-md-2 " id="SHtype1basic${index.count }" name="SHtype1basic">
																		<button type="button" class="btn btn-drt btn-sm">채점중</button>
																		<button type="button" class="btn btn-ryl btn-sm" onclick="updateSH1(${index.count})">수정</button>
																		<button type="button" class="btn btn-rwh btn-sm" onclick="deleteSH1(${index.count})">삭제</button>
																	</div>
																	<div class="col-md-2 inline" id="SHtype1update${index.count }" name="SHtype1update">
																		<button type="button" class="btn btn-ryl"
																			onclick="updateCompSH1(${index.count})">수정완료</button>
																			<button type="button" class="btn btn-rwh"
																			onclick="cancelupdateSH1(${index.count})">취소하기</button>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="col-md-2 inline">
																		<c:if test="${swork.getSho_goodbad() == 'G' }">
																			<button type="button" class="btn btn-sbl btn-sm">잘했어요</button>
																		</c:if>
																		<c:if test="${swork.getSho_goodbad() == 'N' }">
																			<button type="button" class="btn btn-wht btn-sm">아쉬워요</button>
																		</c:if>
																	</div>
																</c:otherwise>
															</c:choose>
														</div>
														<div class="form-group flex">
															<c:if test="${swork.getSho_comment() != null }">
																<div class="col-md-2">
																	<strong>선생님의 한마디</strong>
																</div>
																<div class="col-md-10 left">
																	<textarea class="form-control" row="1" readonly
																		disabled>${swork.getSho_comment() }</textarea>
																</div>
															</c:if>
														</div>
														<div>
															<input type="number" name="sho_id" id="sho_id_type1_${index }" value="${swork.getSho_id() }" 
																style="display: none;">
															<input type="number" name="sho_tid" id="sho_tid_type1"
															value="${data.getTho_id() }" style="display: none;">
														</div>
													</c:forEach>
												</div>
											</c:otherwise>
										</c:choose>
									</form>



								</div>
							</c:when>

							<c:when test="${data.getTho_homeworktype() == 2 }">
								<div class="container" id="type2SHArea">
									<form class="form-horizontal" id="type2studentsmform"
										method="post">
										<div class="row flex tmg20" id="type2SHformArea">
											<c:forEach items="${type2contents }" var="t2q" varStatus="index">
												<div class="col-md-12 tmg20" id="type2SHquestion${t2q.key}">
													<div class="row tmg10" id="type2questionArea${t2q.key }"
														name="type2questionArea">
														<div class="col-md-2">
															<strong>${t2q.key }번 문제</strong>
														</div>
														<div class="col-md-10 left">${t2q.value[1] }</div>
														<input type="hidden" id="type2questionType${t2q.key }"
															value="${t2q.value[0]}">
													</div>
													<c:if test="${t2q.value[0] == 'mc' }">
														<!-- 객관식 -->
														<c:forEach var="mc" begin="3" end="${t2q.value[2] +2}">
															<div class="row tmg10"
																name="type2SHquestion${t2q.key }mcArea">
																<div class="col-md-2 right form-checked"
																	name="type2SHquestionmc">
																	<input type="radio" id="type2SHquestion${t2q.key }mca${mc-2}"
																		name="type2SHquestion${t2q.key }mc" value="${mc-2 }"
																		<c:if test="${sworksnull == false && sanswer[t2q.key - 1] == mc-2 }"> checked </c:if>>
																</div>
																<div class="col-md-10 left">${t2q.value[mc] }</div>
															</div>
														</c:forEach>
													</c:if>
													<c:if test="${t2q.value[0] == 'sc' }">
														<!-- 주관식 -->
														<c:if test="${t2q.value[2] == true }">
															<div class="row tmg10">
																<div class="col-md-2"></div>
																<div class="col-md-10 left">${t2q.value[3]}</div>
															</div>
														</c:if>
														<div class="row tmg10">
															<div class="col-md-2">답 입력하기</div>
															<div class="col-md-10">
																<input type="text" id="type2SHquestion${t2q.key }sca"
																	name="type2SHquestionsc" class="form-control"
																	<c:if test="${sworksnull == false}"> value="${sanswer[t2q.key - 1]}" </c:if>>
															</div>
														</div>
													</c:if>
													<!-- 주관식 -->
												</div>
											</c:forEach>
											<!-- type2contents -->
											<div class="row flex tmg20" id="type2studentsmformbtnArea">
												<div class="col-md-12">
													<div name="type2-btnArea" id="btn-cancelSH2">
														<button type="button" class="btn btn-wht"
															onclick="cancleupdateSH2()">취소</button>
													</div>
													<div name="type2-btnArea" id="btn-submitSH2">
														<button type="button" class="btn btn-sbl"
															onclick="submitSH2()">숙제 내기</button>
													</div>
													<div name="type2-btnArea" id="btn-updateSH2">
														<button type="button" class="btn btn-sbl"
															onclick="updateSH2()">수정하기</button>
													</div>
													<div name="type2-btnArea" id="btn-updateCompSH2">
														<button type="button" class="btn btn-sbl"
															onclick="updateCompSH2()">수정한 답 제출하기</button>
													</div>
												</div>
												<div>
													<c:if test="${sworksnull == false}">
														<input type="number" name="sho_id" id="sho_id_type2"
															value="${sworks[0].getSho_id() }" style="display: none;">
													</c:if>
													<textarea name="sho_contents" id="sho_contents_type2"
														style="display: none;"></textarea>
													<input type="number" name="sho_tid" id="sho_tid_type2"
														value="${data.getTho_id() }" style="display: none;">
													<input type="number" name="sho_writer"
														id="sho_writer_type2" value="4" style="display: none;">
													<input type="number" name="sho_homeworktype"
														id="sho_homeworktype_type2"
														value="${data.getTho_homeworktype() }"
														style="display: none;"> <input type="number"
														name="sho_grade" id="sho_grade_type2" value="1"
														style="display: none;"> <input type="number"
														name="sho_class" id="sho_class_type2" value="2"
														style="display: none;"> <input type="date"
														name="sho_date" id="sho_date_type2" style="display: none;">
													<input type="hidden" name="sho_fileurl"
														id="sho_fileurl_type2">
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
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</footer>
	</div>
</body>
</html>