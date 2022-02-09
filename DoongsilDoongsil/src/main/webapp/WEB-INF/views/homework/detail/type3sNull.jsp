<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url var="hwr_css3_url" value="/stc/css/homework_type3.css" />
<link href="${hwr_css3_url}" rel="stylesheet" type="text/css" />
<c:url var="hwr_t3_url" value="/stc/js/homework/homework_type3.js" />
<script type="text/javascript" src="${hwr_t3_url}" ></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic-coding.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumJungHagSaeng.css" rel="stylesheet">
<!-- ${type3date} -->

<div class="container type3Container flex">
	<div id="type3area" class="bdr-1 bdr-r5 type3_containerArea">
		<div class="row flex type3_titleArea">
			<div class="col-md-8 type3_titleAreaSub flex">
				<fmt:parseDate var="type3date" value="${param.type3date }" pattern="yyyy-MM-dd" />
				<span>
					<strong><fmt:formatDate value="${type3date }" type="date" pattern="yyyy년 MM월 dd일"/></strong>
				</span>
			</div>
			<div class="col-md-4 type3_titleAreaSub flex">
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_sunny" onclick="type3Sunny()">
					<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_cloudy" onclick="type3Cloudy()">
					<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_rainy" onclick="type3Rainy()">
					<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon bdr-r5" id="type3_weather_snowy" onclick="type3Snowy()">
					<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />
				</div>
			</div>
		</div>
		<div id="type3formArea">
			<form id="type3imgSubmit" class="form-horizontal">
				<div class="row vtc">
					<div>
						<input type="file" id="type3imgInput" style="display:none;">
					</div>
					<div id="type3imgArea" class="type3_imgArea flex" onclick="type3imgup()">
						<div class="type3_img_inner">
							<img src="/stc/img/type3defaultimg.png" id="type3imgPreview">
						</div>
					</div>
				</div>
			</form>
			<form id="type3diarySubmit" class="form-horizontal" method="post" action="/studentup3">
				<div class="row vtc" id="type3TextArea">
					<div class="type3_textArea flex">
						<textarea id="type3contentArea" class="typingTextarea" style="overflow:hidden"></textarea>
					</div>
				</div>
				<div>
					<input type="hidden" id="type3weatherValue">
					<input type="hidden" id="type3imglink" name="sho_fileurl">
					<label for="type3date">Date</label>
					<input type="date" id="type3date" name="sho_date" value="${param.type3date }">
					<label for="sho_tid_type3">TID</label>
					<input type="number" name="sho_tid" id="sho_tid_type3" value="${data.getTho_id() }" readonly>
					<label for="sho_writer_type3">Writer</label>
					<input type="number" name="sho_writer" id="sho_writer_type3" value="${sessionScope.accountNumber }" readonly>
					<label for="sho_homeworktype_type3">HWtype</label>
					<input type="number" name="sho_homeworktype" id="sho_homeworktype_type3" value="3" readonly> 
					<label for="type3FinalContent">Content</label>
					<textarea id="type3FinalContent" name="sho_contents" readonly></textarea>
					<label for="sho_grade_type3">Grade</label>
					<input type="number" name="sho_grade" id="sho_grade_type3" value="${sessionScope.account.getSta_grade()}" readonly> 
					<label for="sho_class_type3">Class</label>
					<input type="number" name="sho_class" id="sho_class_type3" value="${sessionScope.account.getSta_class() }" readonly>
				</div>
				<div>
					<button type="submit" style="display:none;" id="type3diarySubmitButton"></button>
				</div>
			</form>
		</div>
		
		<!-- <div id="type3commentArea" class="container row vtc flex">
			<form id="type3commentSubmit" class="form-horizontal row">
				<div class="col-md-2 inline-b">
					<span>
						<strong>선생님의<br>한마디</strong>
					</span>
				</div>
				<div class="col-md-9 inline-b" id="type3_commentArea_inner">
					<textarea id="type3comment" class="form-control commentTextarea" row="2"></textarea>
				</div>
			</form>
		</div>  -->
	</div>
</div>