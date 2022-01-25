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
					<div>
						<input type="number" name="tho_writer" value="5" style="display:none;">
						<input type="number" name="tho_grade" value="1" style="display:none;">
						<input type="number" name="tho_class" value="2" style="display:none;">
						<input type="number" name="tho_count" value="0" style="display:none;">
					</div>
					<div id="t_hw_write_type1">
						
						<table>
							<tr>
								<td>내용</td>
								<td colspan="3">
									<textarea name="tho_contents" id="tho_contents" placeholder="내용을 입력해주세요"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="hidden" id="tho_filelink" name="tho_filelink">
									<button type="button" onclick="formUp()">제출</button>
								</td>
							</tr>
							
						</table>
						
						
						
					</div>
					<div id="t_hw_write_type2">
						<p>type2</p>
						<div>
							<button type="button" onclick="formUp()">작성 완료</button>
						</div>
					</div>
				</form>
			</div>
			
		</section>
	</main>
</body>
</html>