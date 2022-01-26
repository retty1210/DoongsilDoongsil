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
<script type="text/javascript" src="${hwr_url}" ></script>
<script type="text/javascript" src="${hwr_url2}" ></script>
</head>
<body>
	<header></header>
	<main role="main">
		<section>
			<div>
				<h3>새로운 숙제 올리기</h3><!-- 사진은 따로 업로드한 후 주소를 받아서 textarea에 뿌릴 수 있으면 좋겠는데 -->		
			</div>
			<div>
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
			<div id="hw_write">
				<form id="hw_write_form" name="hw_write_form" action="/homework/write/up" method="post" enctype="multipart/form-data">
					<table id="t_hw_write_t">
						<tr>
							<td>숙제 유형</td>
							<td colspan="3">
								<select name="tho_homeworktype" id="tho_homeworktype">
									<option value="0" disabled>카테고리 선택하기</option>
									<c:forEach var="data" items="${datas }">
										<option value="${data.getTca_id() }">${data.getTca_category() } 선택하기</option>
									</c:forEach>
								</select>
							</td>
						</tr>	
						<tr>
							<td>숙제 작성일</td>
							<td>
								<input type="date" name="tho_writedate" id="tho_writedate" readonly>
							</td>
							<td>
								숙제 제출 기한
								<input type="checkbox" id="deadlineCheck" name="deadlineCheck">
							</td>
							<td>
								<input type="date" name="tho_deadline" id="tho_deadline">
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td colspan="3">
								<input type="text" name="tho_title" id="tho_title" placeholder="제목을 입력해주세요">
							</td>
						</tr>
					</table>
					<div>
						<input type="number" name="tho_writer" value="5" style="display:none;">
						<input type="number" name="tho_grade" value="1" style="display:none;">
						<input type="number" name="tho_class" value="2" style="display:none;">
						<input type="number" name="tho_count" value="0" style="display:none;">
						<input type="hidden" id="tho_filelink" name="tho_filelink">
					</div>
					<div id="t_hw_write_type1">
						<p>type1</p>
						<table>
							<tr>
								<td>내용</td>
								<td colspan="3">
									<textarea name="tho_contents" id="tho_contents" placeholder="내용을 입력해주세요"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									
									<button type="button" onclick="formUp()">제출</button>
								</td>
							</tr>
							
						</table>
						
					</div>
					<div id="t_hw_write_type2">
						<p>type2</p>
						<div id="t_hw_write_type2_container">
							<div id="t_hw_2_question_1">
								<div id="type2_q_no1" name="type2_q_no"><span>1번 문제</span></div>
								<div id="type2_q_qArea1" name="type2_q_qArea">
									<input type="text" id="type2_q1" name="type2_q1" placeholder="학생에게 낼 문제를 입력하세요.">
								</div>
								<div id="type2_q_bArea1" name="type2_q_bArea">
									<button type="button" id="btn_mc1" name="btn_mc" onclick="type2mc(1)">객관식</button>
									<button type="button" id="btn_sc1" name="btn_sc" onclick="type2sc(1)">주관식</button>
								</div>
								<div id="type2_mcArea1_q" name="type2_mcArea_q" style="display:none;">
									<span>객관식 - 답을 입력하세요.(최대 5개)</span>
									<div id="type2_mcArea1_mc1_q" name="type2_mcArea1_q">
										<div>
											<label for="type2_mcArea1_mc1">(1)</label>
											<input type="text" id="type2_mcArea1_mc1" name="type2_mcArea1_mc_input">
										</div>
										<div id="type2_mcArea1_mc1_plus1" name="type2_mcArea1" onclick="type2mcplus(1, 1)">
											<img src="/stc/img/plus-circle-dotted.svg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />
										</div>
										<div id="type2_mcArea1_mc1_minus1" onclick="type2mcminus(1, 1)">
											<img src="/stc/img/dash-circle-dotted.svg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />
										</div>
									</div>
									<div id="type2_mcArea1_mc2_q" name="type2_mcArea1_q"></div>
									<div id="type2_mcArea1_mc3_q" name="type2_mcArea1_q"></div>
									<div id="type2_mcArea1_mc4_q" name="type2_mcArea1_q"></div>
									<div id="type2_mcArea1_mc5_q" name="type2_mcArea1_q"></div>
								</div>
								<div id="type2_scArea1_q" name="type2_q_scArea" style="display:none;">
									<span>주관식 - 학생의 문제풀이에 도움이 될 안내문을 입력하세요(선택)</span>
									<input type="text" id="type2_scArea1_sc" name="type2_scArea_sc">
								</div>
								<div id="type2_noArea1_q" name="type2_q_noArea">
									<span>객관식이나 주관식 중 하나를 반드시 선택해야만 합니다.</span>
								</div>
								<hr>
								<div id="type2_q_plusArea1" name="type2_q_plusArea" onclick="type2qplus(1)">
									<img src="/stc/img/plus-circle-fill.svg" style="width:50px; height:auto; vertical-align: middle; cursor: pointer;" />
								</div>
								<div id="type2_q_minusArea1" name="type2_q_minusArea" onclick="type2qminus(1)">
									<img src="/stc/img/dash-circle-fill.svg" style="width:50px; height:auto; vertical-align: middle; cursor: pointer;" />
								</div>
							</div>
							<div id="t_hw_2_question_2"></div>
							<div id="t_hw_2_question_3"></div>
							<div id="t_hw_2_question_4"></div>
							<div id="t_hw_2_question_5"></div>
							<div id="t_hw_2_question_6"></div>
							<div id="t_hw_2_question_7"></div>
							<div id="t_hw_2_question_8"></div>
							<div id="t_hw_2_question_9"></div>
							<div id="t_hw_2_question_10"></div>
						</div>
						<div>
							<button id="btn_type2submit" type="button" onclick="type2completeForm()">작성 완료</button>
						</div>
					</div>
				</form>
			</div>
			
		</section>
	</main>
</body>
</html>