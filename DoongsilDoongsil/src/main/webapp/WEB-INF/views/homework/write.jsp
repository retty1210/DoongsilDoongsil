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
<script type="text/javascript" src="${hwr_url}" ></script>
</head>
<body>
	<header></header>
	<main role="main">
		<section>
			<div>
				<h3>새로운 숙제 올리기</h3><!-- 사진은 따로 업로드한 후 주소를 받아서 textarea에 뿌릴 수 있으면 좋겠는데 -->		
			</div>
			<div id="hw_write">
				<form id="hw_write_form" onsubmit="return registerAction()">
					<table id="t_hw_write_t">
						<tr>
							<td>숙제 유형</td>
							<td colspan="3">
								<select name="tho_homeworktype" id="tho_homeworktype">
									<option value="1">1번</option>
									<option value="2">2번</option>
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
					<div id="t_hw_write_type1">
						<table>
							<tr>
								<td>내용</td>
								<td colspan="3">
									<textarea name="tho_contents" id="tho_contents" placeholder="내용을 입력해주세요"></textarea>
								</td>
							</tr>
							<tr>
								<td>파일 업로드</td>
								<td colspan="3">
									<button id="btn_upload" type="button">파일 추가</button>
									<input id="input_file" multiple="multiple" type="file" style="display:none;">
									<span>첨부파일은 최대 3개까지 첨부 가능합니다.</span>
								</td>
							</tr>
							<tr>
								<td>첨부 파일</td>
								<td colspan="3">
									<div id="fileChange"></div>
								</td>
							</tr>
						</table>
						<div>
							<input type="hidden" name="tho_writer" value="1">
							<input type="hidden" name="tho_grade" value="1">
							<input type="hidden" name="tho_class" value="1">
							<input type="hidden" name="tho_count" value="0">
						</div>
					</div>
					<div id="t_hw_write_type2">
						<p>type2</p>
					</div>
					<div>
						<button type="submit">작성 완료</button>
					</div>
				</form>
			</div>
		</section>
	</main>
</body>
</html>