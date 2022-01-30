<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새로운 숙제 올리기</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="hwr_url" value="/stc/js/t_homework_write.js" />
<c:url var="hwr_url2" value="/stc/js/t_homework_write_type2.js" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<script type="text/javascript" src="${hwr_url}" ></script>
<script type="text/javascript" src="${hwr_url2}" ></script>
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
	<main role="main" class="container">
		<section class="bdr-1">
			<div class="bdr-1 bdr-r5 strblue pd10">
				<h3>새로운 숙제 올리기</h3><!-- 사진은 따로 업로드한 후 주소를 받아서 textarea에 뿌릴 수 있으면 좋겠는데 -->		
			</div>
			<div class="bloc80 bdr-1 bdr-r9 pd20 tmg20">
				<form id="hw_up_form" name="hw_up_form" class="form-horizontal" action="/homework/write/up/file" method="post" enctype="multipart/form-data">
					<div class="form-group pd10">
						<button id="btn_up" name="btn_up" type="button" class="btn btn-wht btn-sm">업로드할 사진 선택하기</button>
						<span class="text-muted">사진 업로드는 3장까지 가능합니다.</span>
					</div>
					<div id="uploadFileName"  class="form-group pd10">
						
					</div>
					<input multiple="multiple" type="file" name="picFile" id="picFile" style="display:none;">
					<div class="form-group pd10">
						<button type="button" onclick="fileUp()" class="btn btn-wht btn-sm">사진 업로드</button>
					</div>
				</form>
			</div>
			
			<div id="hw_write tmg20">
				<form id="hw_write_form" name="hw_write_form" class="form-horizontal" action="/homework/write/up" method="post" enctype="multipart/form-data">
					<div id="t_hw_write_t" class="col-md-12 tmg10">
						<div class="form-group pd10 flex">
							<div class="col-md-2"><strong>숙제 유형</strong></div>
							<div class="col-md-3">
								<select name="tho_homeworktype" id="tho_homeworktype" class="form-select">
									<option value="0" disabled selected>카테고리 선택하기</option>
									<c:forEach var="data" items="${datas }">
										<option value="${data.getTca_id() }">${data.getTca_category() } 선택하기</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-2"><strong>숙제 작성일</strong></div>
							<div class="col-md-4">
								<input type="date" name="tho_writedate" id="tho_writedate" class="form-control whtcream-b" readonly>
							</div>
						</div>
						
						<div class="form-group pd10 flex">
							<div class="col-md-2 checkbox-inline tmg10"><strong>숙제 제출 기한</strong>
							<input type="checkbox" id="deadlineCheck" name="deadlineCheck"></div>
							<div class="col-md-7">
								<input type="date" name="tho_deadline" id="tho_deadline" class="form-control">
							</div>
						</div>
						<div class="form-group pd10 flex">
							<div class="col-md-2"><strong>제목</strong></div>
							<div class="col-md-10">
								<input type="text" name="tho_title" id="tho_title" class="form-control" placeholder="제목을 입력해주세요" required>
							</div>
						</div>
					</div>
					<div class="none">
						<input type="number" name="tho_writer" value="5" style="display:none;">
						<input type="number" name="tho_grade" value="1" style="display:none;">
						<input type="number" name="tho_class" value="2" style="display:none;">
						<input type="number" name="tho_count" value="0" style="display:none;">
						<input type="hidden" id="tho_filelink" name="tho_filelink">
					</div>
					<div id="t_hw_write_type1" class="col-md-12 tmg10">
						<p>기본: '|'는 금칙어로 자동으로 입력 내용에서 삭제된 후 업로드되니 주의 바랍니다.</p>
						<div class="form-group pd10 col-md-12 tmg10">
							<label for="tho_contents" class="col-md-2 control-label">내용</label>
							<textarea name="tho_contents" id="tho_contents" class="form-control" rows="10" placeholder="내용을 입력해주세요"></textarea>
						</div>
						<div class="tmg20">
							<button type="button" class="btn btn-wht btn-lg" style="width: 200px;" onclick="location='/homework'">취소</button>
							<button type="button" onclick="formUp()" style="width: 200px;" class="btn btn-sbl btn-lg">제출</button>
						</div>
					</div>
					<div id="t_hw_write_type2" class="col-md-12 tmg20">
						<p>객관식/주관식: 한번에 10문제까지 업로드할 수 있습니다. '|'는 금칙어로 자동으로 삭제 후 업로드됩니다.</p>
						<div id="t_hw_write_type2_container">
							<div id="t_hw_2_question_1" class="mg20 bdr-1 bdr-r5">
								<div class="row tmg10">
									<div id="type2_q_no1" name="type2_q_no" class="col-md-2"><span><strong>1번 문제</strong></span></div>
									<div id="type2_q_qArea1" name="type2_q_qArea" class="col-md-8">
										<input type="text" id="type2_q1" name="type2_q1" class="form-control" placeholder="학생에게 낼 문제를 입력하세요.">
									</div>
									<div id="type2_q_bArea1" name="type2_q_bArea" class="col-md-2">
										<button type="button" id="btn_mc1" name="btn_mc" onclick="type2mc(1)" class="btn btn-rwh btn-sm">객관식</button>
										<button type="button" id="btn_sc1" name="btn_sc" onclick="type2sc(1)" class="btn btn-rwh btn-sm">주관식</button>
									</div>
								</div>
								<div id="type2_mcArea1_q" name="type2_mcArea_q" style="display:none;" class="row tmg10">
									<span class="help-block tmg10 small"><strong>객관식 문제의 답을 입력하세요.(최대 5개까지 입력할 수 있습니다.)</strong></span>
									<div id="type2_mcArea1_mc1_q" name="type2_mcArea1_q" class="row flex tmg10">
										<div class="col-md-1"><span><strong>(1)</strong></span></div>
										<div class="col-md-9">
											<input type="text" id="type2_mcArea1_mc1" class="form-control" name="type2_mcArea1_mc_input">
										</div>
										<div class="col-md-1" id="type2_mcArea1_mc1_plus1" name="type2_mcArea1" onclick="type2mcplus(1, 1)">
											<img src="/stc/img/plus-circle-dotted.svg" class="ic30 filter-rylblue filter-drtblue-hover" />
										</div>
										<div class="col-md-1" id="type2_mcArea1_mc1_minus1" onclick="type2mcminus(1, 1)">
											<img src="/stc/img/dash-circle-dotted.svg" class="ic30 filter-rylblue filter-drtblue-hover" />
										</div>
									</div>
									<div id="type2_mcArea1_mc2_q" name="type2_mcArea1_q" class="row flex tmg10" style="display:none;"></div>
									<div id="type2_mcArea1_mc3_q" name="type2_mcArea1_q" class="row flex tmg10" style="display:none;"></div>
									<div id="type2_mcArea1_mc4_q" name="type2_mcArea1_q" class="row flex tmg10" style="display:none;"></div>
									<div id="type2_mcArea1_mc5_q" name="type2_mcArea1_q" class="row flex tmg10" style="display:none;"></div>
								</div>
								<div id="type2_scArea1_q" name="type2_q_scArea" style="display:none;" class="row tmg10">
									<span class="help-block tmg10 small"><strong>주관식 - 학생의 문제풀이에 도움이 될 안내문을 입력하세요(선택)</strong></span>
									<div class="col-md-1"></div>
									<div class="col-md-10">
										<input type="text" id="type2_scArea1_sc" name="type2_scArea_sc" class="form-control" >
									</div>
								</div>
								<div id="type2_noArea1_q" name="type2_q_noArea" class="row tmg40">
									<span class="help-block rylblue"><strong>객관식이나 주관식 중 하나를 반드시 선택해야만 합니다.</strong></span>
								</div>
								<hr>
								<div class="row flex tmg10">
									<div class="col-md-5"></div>
									<div id="type2_q_plusArea1" name="type2_q_plusArea" onclick="type2qplus(1)" class="col-md-1">
										<img src="/stc/img/plus-circle-fill.svg" class="ic40 filter-lsrblue filter-skyblue-hover" />
									</div>
									<div id="type2_q_minusArea1" name="type2_q_minusArea" onclick="type2qminus(1)" class="col-md-1">
										<img src="/stc/img/dash-circle-fill.svg" class="ic40 filter-lsrblue filter-skyblue-hover" />
									</div>
								</div>
							</div>
							<div id="t_hw_2_question_2" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_3" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_4" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_5" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_6" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_7" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_8" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_9" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
							<div id="t_hw_2_question_10" class="mg20 bdr-1 bdr-r5" style="display:none;"></div>
						</div>
						<div class="tmg20">
							<button type="button" class="btn btn-wht btn-lg" style="width: 200px;" onclick="location='/homework'">취소</button>
							<button id="btn_type2submit" type="button" style="width: 200px;" onclick="type2makeContents()" class="btn btn-lsr btn-lg btn-block">작성 완료</button>
						</div>
						<div class="none">
							<textarea id="type2_q_textarea" name="tho_contents" style="display:none;"></textarea>
						</div>
					</div>
				</form>
			</div>
			
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
	</footer>
</body>
</html>