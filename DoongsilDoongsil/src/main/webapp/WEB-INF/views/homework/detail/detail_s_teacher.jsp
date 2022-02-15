<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<section class="bdr-1 bdr-r5">
	<!-- 교사용 숙제 확인 페이지 -->
	<c:choose>
		<c:when test="${sdatas != null }">
			<c:if test="${data.getTho_homeworktype() == 1 }">
				<c:forEach var="sdata" items="${sdatas }" varStatus="sdataIndex">
					<div class="row tmg10 flex">
						<c:if test="${sdata.getSho_fileurl() != null }">
							<c:set var="sho_id" value="${sdata.getSho_id() }"></c:set>
							<c:forEach items="${studentImages[sho_id] }" var="i" varStatus="IMGindex">
								<div class="col-md-4">
									<c:url var="imgURL" value="/stc/up/${i}" />
									<a href="${imgURL }" target="_blank">
										<img class="imgfull" src="${imgURL }">
									</a>
								</div>
							</c:forEach>
						</c:if>
					</div>
					<!-- sdata의 goodbad가 null이면 폼, 값이 있으면 테이블을 띄움 -->
					<c:choose>
						<c:when test="${sdata.getSho_goodbad() != null }">
							<div class="row tmg10">
								<div class="col-md-1 tmg10 tpd10">${studentNameArr[sdataIndex.index].getSta_name()}</div>
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
								<div class="form-group bdr-1 bdr-r5 tmg10" style="display: flex;">
									<div class="col-md-1 tmg10">${studentNameArr[sdataIndex.index].getSta_name()}</div>
									<div class="col-md-9 tmg10">${sdata.getSho_contents() }</div>
									<div class="col-md-1">
										<div name="ajax_good" id="ajax_good${sdata.getSho_id() }" class="mg10">
											<button class="btn btn-wht btn-sm" id="btn_ajaxGood${sdata.getSho_id() }" type="button"
												onclick="ajax_good(${sdata.getSho_id() })">잘했어요</button>
										</div>
										<input type="hidden" name="sho_goodbad" id="sho_good${sdata.getSho_id() }" value="G" disabled>
									</div>
									<div class="col-md-1">
										<div name="ajax_bad" id="ajax_bad${sdata.getSho_id() }" class="mg10">
											<button class="btn btn-wht btn-sm" id="btn_ajaxBad${sdata.getSho_id() }" type="button"
												onclick="ajax_bad(${sdata.getSho_id() })">아쉬워요</button>
										</div>
										<input type="hidden" name="sho_goodbad" id="sho_bad${sdata.getSho_id() }" value="N" disabled>
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
										<button class="btn btn-sbl" type="button" id="btn_submitcomm${sdata.getSho_id() }"
											onclick="submitAjaxComment(${sdata.getSho_id() })">채점결과와 숙제에 대한 평가 함께 제출하기</button>
									</div>
								</div>
								<div>
									<input type="number" name="sho_id" id="sho_comment_id${sdata.getSho_id() }"
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
						<form class="form-horizontal" action="/Type2ajaxComment" method="post" id="Type2ajaxComment${sdata.getSho_id() }">
							<c:choose>
								<c:when test="${sdata.getSho_goodbad() == null }">
									<!-- 아직 채점안됨 -->
									<div class="row"> 
										<div class="col-md-1 tmg10 tpd10">${studentNameArr[sdataIndex.index].getSta_name()}</div>
										<div class="col-md-2 tmg10 tpd10">${sdata.getSho_date() }</div>
										<div class="col-md-7 tmg10 tpd10">
											<div class="btn-group">
												<c:forEach var="t2answers" items="${type2answers.get(sdata.getSho_id()) }" varStatus="status">
													<button type="button" id="btn-${sdata.getSho_id() }type2GoodBad${status.count }" class="btn btn-secondary" 
														name="btn-${sdata.getSho_id() }type2GoodBad" data-bs-toggle="modal" 
														data-bs-target="#makeGoodbadSc_${sdata.getSho_id() }_${status.count}">
														<img src="/stc/img/question-lg.svg" class="ic20 filter-whtcream" />
													</button>
												</c:forEach>
											</div>
										</div>
										<div class="col-md-2 tmg10 tpd10" id="type2${sdata.getSho_id() }CompBtnArea">
											<button type="button" class="btn btn-sbl" onclick="type2MakeGoodBad(${sdata.getSho_id() })">채점완료하기</button>
										</div>
									</div>
									<div>
										<c:forEach var="t2answers" items="${type2answers.get(sdata.getSho_id()) }" varStatus="status">
											<input type="hidden" id="${sdata.getSho_id() }type2q${status.count}Goodbad" name="${sdata.getSho_id() }type2qAnswerInput">
											<div class="modal fade" id="makeGoodbadSc_${sdata.getSho_id() }_${status.count}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
																	<c:if test="${type2cont[2] == 'true' }">
																		<div class="row">
																			선생님의 안내문: ${type2cont[3] }
																		</div>
																	</c:if>
																	<div class="row">
																		학생이 쓴 답: ${t2answers}
																	</div>
																</c:when>
																<c:otherwise><span>arr[0]값 안읽힘</span></c:otherwise>
															</c:choose>
														</div>
													    <div class="modal-footer">
															<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															<button type="button" class="btn btn-success" data-bs-dismiss="modal" onclick="type2GoodMake(${sdata.getSho_id() }, ${status.count })">O</button>
															<button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="type2BadMake(${sdata.getSho_id() }, ${status.count })">X</button>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:when>
								<c:otherwise>
									<!-- 채점끝남 -->
									
										<div class="row"> 
											<div class="col-md-1 tmg10 tpd10">${studentNameArr[sdataIndex.index].getSta_name()}</div>
											<div class="col-md-2 tmg10 tpd10">${sdata.getSho_date() }</div>
											<div class="col-md-7 tmg10 tpd10">
												<div class="btn-group">
													<c:forEach var="t2GBforT" items="${type2GBforTeacher.get(sdata.getSho_id()) }" varStatus="status">
														<c:choose>
															<c:when test="${t2GBforT == 'o'}">
																<button type="button" id="btn-${sdata.getSho_id() }type2GB${status.count }forT" class="btn btn-success" 
																	name="btn-${sdata.getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/circle.svg" class="ic20 filter-whtcream" />
																</button>
															</c:when>
															<c:when test="${t2GBforT == 'x'}">
																<button type="button" id="btn-${sdata.getSho_id() }type2GB${status.count }forT" class="btn btn-danger" 
																	name="btn-${sdata.getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/x-lg.svg" class="ic20 filter-whtcream" />
																</button>
															</c:when>
															<c:otherwise>
																<button type="button" id="btn-${sdata.getSho_id() }type2GB${status.count }forT" class="btn btn-secondary" 
																	name="btn-${sdata.getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/question-lg.svg" class="ic20 filter-whtcream" />
																</button>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</div>
											</div>
										</div>
									
								</c:otherwise>
							</c:choose>
						</form>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${data.getTho_homeworktype() == 3 }">
				<c:forEach var="type3day" items="${type3DayArr }" varStatus="index">
					<fmt:parseDate var="type3date" value="${type3day }" pattern="yyyy-MM-dd" />
					<fmt:formatDate var="valueDate" value="${type3date }" pattern="yyyyMMdd" />
					<div class="col-md-12 tmg10 bdr-r5 bdr-1 flex btn" data-bs-toggle="modal" data-bs-target="#type3Toggle_${valueDate }_${index.index }">
						<div class="col-md-6">
							${type3day }
						</div>
						<div class="col-md-6">
							${sizeArr[index.index]}
							
						</div>
					</div>
					<!-- Modal -->
					<div class="modal fade" id="type3Toggle_${valueDate }_${index.index }" tabindex="-1">
					  <div class="modal-dialog modal-dialog-centered modal-lg">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="type3ToggleLabel_${valueDate }_${index.index }">${type3day }</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body flex">
					      	<c:forEach var="studentName" items="${nameArr[index.index] }" varStatus="nameindex">
					      		<c:choose>
					      			<c:when test="${sArrforT[index.index][nameindex.index].getSho_comment() != null }">
					      				<div class="col-md-3 bdr-1 bdr-r5 btn btn-secondary" id="nameBtn_${valueDate }_${studentName.getSta_id() }"
							      			data-bs-toggle="modal" data-bs-target="#type3_submodal_${valueDate }_${studentName.getSta_id() }">
							      			${studentName.getSta_name() }
							      		</div>
					      			</c:when>
					      			<c:otherwise>
					      				<div class="col-md-3 bdr-1 bdr-r5 btn btn-success" id="nameBtn_${valueDate }_${studentName.getSta_id() }"
							      			data-bs-toggle="modal" data-bs-target="#type3_submodal_${valueDate }_${studentName.getSta_id() }">
							      			${studentName.getSta_name() }
							      		</div>
					      			</c:otherwise>
					      		</c:choose>
					      	</c:forEach>
					      </div>
					      <div class="modal-footer">
					        <button class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">닫기</button>
					      </div>
					    </div>
					  </div>
					</div>
					<c:forEach var="sDiary" items="${sArrforT[index.index] }" varStatus="modalindex">
						<div class="modal fade" id="type3_submodal_${valueDate }_${sDiary.getSho_writer()}" tabindex="-1">
						  <div class="modal-dialog modal-dialog-centered modal-lg">
						    <div class="modal-content">
						      <div class="modal-body">
						        <jsp:include page="/WEB-INF/views/homework/detail/type3tNN.jsp" flush="false">
						        	<jsp:param value="${type3day }" name="type3date"/>
						      		<jsp:param value="${sDiary.getSho_fileurl() }" name="type3sWork"/>
						      		<jsp:param value="${weatherArr[index.index][modalindex.index] }" name="type3sWeather"/>
						      		<jsp:param value="${contentArr[index.index][modalindex.index] }" name="type3content"/>
						      		<jsp:param value="${sDiary.getSho_comment() }" name="type3comment"/>
						      		<jsp:param value="${sDiary.getSho_id() }" name="type3id" />
						      		<jsp:param value="${sDiary.getSho_writer() }" name="type3writer" />
						        </jsp:include>
						      </div>
						      <div class="modal-footer">
						        <button class="btn btn-primary" data-bs-target="#type3Toggle_${valueDate }_${index.index }" data-bs-toggle="modal">목록으로 돌아가기</button>
						        <button class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">닫기</button>
						      </div>
						    </div>
						  </div>
						</div>
					</c:forEach>
				</c:forEach>
			</c:if>
		</c:when>
		<c:otherwise>
			<div class="col-md-12 tmg10">
				<h4>아직 아무도 숙제를 제출하지 않았습니다.</h4>
			</div>
		</c:otherwise>
	</c:choose>
</section>