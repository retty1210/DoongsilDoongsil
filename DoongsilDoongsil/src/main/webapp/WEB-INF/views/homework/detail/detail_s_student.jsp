<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
										id="sho_writer_type1" value="20" style="display: none;">
									<input type="number" name="sho_homeworktype" id="sho_homeworktype_type1"
										value="${data.getTho_homeworktype() }" style="display: none;"> 
									<input type="number" name="sho_grade" id="sho_grade_type1" 
										value="2" style="display: none;"> 
									<input type="number" name="sho_class" id="sho_class_type1" 
										value="4" style="display: none;"> 
									<input type="date" name="sho_date" id="sho_date_type1" style="display: none;"> 
									<input type="hidden" name="sho_fileurl" id="sho_fileurl_type1">
								</div>
							</div>
						</c:when>
						<c:otherwise>
						<!-- 숙제 있음 -->
							<div class="form-group">
								<c:forEach var="swork" items="${sworks }" varStatus="index">
									<c:if test="${swork.getSho_fileurl() != null }">
										<div class="row tmg10 flex">
											<c:forEach items="${studentImagesForS.get(swork.getSho_id()) }" var="i" varStatus="index">
												<div class="col-md-4">
													<c:url var="imgURL" value="/stc/up/${i}" />
													<a href="${imgURL }" target="_blank">
														<img class="imgfull" src="${imgURL }">
													</a>
												</div>
											</c:forEach>
										</div>
									</c:if>
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
													<button type="button" class="btn btn-rwh btn-sm" onclick="deleteSH(${swork.getSho_id()})">삭제</button>
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
												<textarea class="form-control" row="1" readonly disabled>${swork.getSho_comment() }</textarea>
											</div>
										</c:if>
									</div>
									<div>
										<input type="number" name="sho_id" id="sho_id_type1_${index }" value="${swork.getSho_id() }" 
											style="display: none;">
										<input type="number" name="sho_tid" id="sho_tid_type1" value="${data.getTho_id() }" 
											style="display: none;">
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
								<div class="row tmg10" id="type2questionArea${t2q.key }" name="type2questionArea">
									<div class="col-md-2">
										<strong>${t2q.key }번 문제</strong>
									</div>
									<div class="col-md-10 left">${t2q.value[1] }</div>
									<input type="hidden" id="type2questionType${t2q.key }" value="${t2q.value[0]}">
								</div>
								<c:if test="${t2q.value[0] == 'mc' }">
									<!-- 객관식 -->
									<c:forEach var="mc" begin="3" end="${t2q.value[2] +2}">
										<div class="row tmg10" name="type2SHquestion${t2q.key }mcArea">
											<div class="col-md-2 right form-checked" name="type2SHquestionmc">
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
											<input type="text" id="type2SHquestion${t2q.key }sca" name="type2SHquestionsc" class="form-control"
												<c:if test="${sworksnull == false}"> value="${sanswer[t2q.key - 1]}" </c:if> >
										</div>
									</div>
								</c:if>
								<!-- 주관식 -->
							</div>
						</c:forEach>
						<!-- type2contents -->
						<div class="row flex tmg20" id="type2studentsmformbtnArea">
							<c:choose>
								<c:when test="${sworks[0].getSho_goodbad() != null }"> <!-- 채점끝남 -->
									<div class="col-md-12">
										<div class="row"> 
											<div class="col-md-1 tmg10 tpd10"><strong>채점결과</strong></div>
											<div class="col-md-2 tmg10 tpd10">${sworks[0].getSho_date() }</div>
											<div class="col-md-7 tmg10 tpd10">
												<div class="btn-group">
													<c:forEach var="t2GBforS" items="${type2GBforStudent}" varStatus="status">
														<c:choose>
															<c:when test="${t2GBforS == 'o'}">
																<button type="button" id="btn-${sworks[0].getSho_id() }type2GB${status.count }forT" 
																	class="btn btn-success" name="btn-${sworks[0].getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/circle.svg" class="ic20 filter-whtcream" />
																</button>
															</c:when>
															<c:when test="${t2GBforS == 'x'}">
																<button type="button" id="btn-${sworks[0].getSho_id() }type2GB${status.count }forT" 
																	class="btn btn-danger" name="btn-${sworks[0].getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/x-lg.svg" class="ic20 filter-whtcream" />
																</button>
															</c:when>
															<c:otherwise>
																<button type="button" id="btn-${sworks[0].getSho_id() }type2GB${status.count }forT" 
																	class="btn btn-secondary" name="btn-${sworks[0].getSho_id() }type2GoodBadforT">
																	<img src="/stc/img/question-lg.svg" class="ic20 filter-whtcream" />
																</button>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
								</c:when>
								<c:otherwise> <!-- 아직 채점중 -->
									<div class="col-md-12">
										<div name="type2-btnArea" id="btn-cancelSH2">
											<button type="button" class="btn btn-wht" onclick="cancleupdateSH2()">취소</button>
										</div>
										<div name="type2-btnArea" id="btn-submitSH2">
											<button type="button" class="btn btn-sbl" onclick="submitSH2()">숙제 내기</button>
										</div>
										<div name="type2-btnArea" id="btn-updateSH2">
											<button type="button" class="btn btn-sbl" onclick="updateSH2()">수정하기</button>
										</div>
										<div name="type2-btnArea" id="btn-updateCompSH2">
											<button type="button" class="btn btn-sbl" onclick="updateCompSH2()">수정한 답 제출하기</button>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
							<div>
								<c:if test="${sworksnull == false}">
									<input type="number" name="sho_id" id="sho_id_type2"
										value="${sworks[0].getSho_id() }" style="display: none;">
								</c:if>
								<textarea name="sho_contents" id="sho_contents_type2" style="display: none;"></textarea>
								<input type="number" name="sho_tid" id="sho_tid_type2" value="${data.getTho_id() }" style="display: none;">
								<input type="number" name="sho_writer" id="sho_writer_type2" value="7" style="display: none;">
								<input type="number" name="sho_homeworktype" id="sho_homeworktype_type2"
									value="${data.getTho_homeworktype() }" style="display: none;"> 
								<input type="number" name="sho_grade" id="sho_grade_type2" value="2" style="display: none;"> 
								<input type="number" name="sho_class" id="sho_class_type2" value="4" style="display: none;"> 
								<input type="date" name="sho_date" id="sho_date_type2" style="display: none;">
								<input type="hidden" name="sho_fileurl" id="sho_fileurl_type2">
							</div>
						</div>
					</div>
				</form>
			</div>
		</c:when>
		<c:when test="${data.getTho_homeworktype()  == 3}">
			<c:forEach var="type3date" items="${type3DayArr }">
				<div class="col-md-12 tmg10 bdr-r5 bdr-1 flex btn" data-bs-toggle="modal" data-bs-target="#type3ModalS${type3date }">
					<div class="col-md-10">
						${type3date }
					</div>
					<div class="col-md-2">
						<c:choose>
							<c:when test="${type3comment.get(type3date) != null}">
								${type3comment.get(type3date) }
							</c:when>
							<c:otherwise>
								아직 일기를 안 썼어요.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				 <!-- Modal -->
				<div class="modal fade" id="type3ModalS${type3date }" tabindex="-1">
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				      <!-- <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">${type3day }의 일기</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div> -->
				      <c:choose>
				      	<c:when test="${type3sWorks.get(type3date) != null}">
				      		 <div class="modal-body">
						      	<jsp:include page="/WEB-INF/views/homework/detail/type3sNN.jsp" flush="false">
						      		<jsp:param value="${type3date }" name="type3date"/>
						      		<jsp:param value="${type3sWorks.get(type3date) }" name="type3sWork"/>
						      		<jsp:param value="${type3sWC.get(type3date) }" name="type3sWC"/>
						      		<jsp:param value="${type3comment.get(type3date) }" name="type3comment"/>
						      	</jsp:include>
						      </div>
				      	</c:when>
				      	<c:otherwise>
				      		 <div class="modal-body">
						      	<jsp:include page="/WEB-INF/views/homework/detail/type3sNull.jsp" flush="false">
						      		<jsp:param value="${type3date }" name="type3date"/>
						      	</jsp:include>
						      </div>
				      	</c:otherwise>
				      </c:choose>
				     
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <c:if test="${type3sWorks.get(type3date) != null}">
				        	<button type="button" class="btn btn-primary" onclick="submitType3Student()">Save changes</button>
				        </c:if>
				      </div>
				    </div>
				  </div>
				</div>
			</c:forEach>
		</c:when>
	</c:choose>
</section>