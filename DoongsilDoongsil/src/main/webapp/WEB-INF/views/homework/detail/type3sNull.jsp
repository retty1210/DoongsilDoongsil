<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- ${type3date} -->

<div class="container type3Container flex">
	<fmt:parseDate var="type3date" value="${param.type3date }" pattern="yyyy-MM-dd" />
	<fmt:formatDate var="valueDate" value="${type3date }" pattern="yyyyMMdd" />
	<div id="type3area${valueDate }" class="bdr-1 bdr-r5 type3_containerArea">
		<div class="row flex type3_titleArea">
			<div class="col-md-8 type3_titleAreaSub flex">
				<span>
					<strong><fmt:formatDate value="${type3date }" type="date" pattern="yyyy년 MM월 dd일"/></strong>
				</span>
			</div>
			<div class="col-md-4 type3_titleAreaSub flex">
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_sunny${valueDate }" name="weatherIcon${valueDate }" onclick="type3Sunny(${valueDate })">
					<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_cloudy${valueDate }" name="weatherIcon${valueDate }" onclick="type3Cloudy(${valueDate })">
					<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_rainy${valueDate }" name="weatherIcon${valueDate }" onclick="type3Rainy(${valueDate })">
					<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon bdr-r5" id="type3_weather_snowy${valueDate }" name="weatherIcon${valueDate }" onclick="type3Snowy(${valueDate })">
					<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />
				</div>
			</div>
		</div>
		<div id="type3formArea${valueDate }">
			<form id="type3diarySubmit${valueDate }" class="form-horizontal" method="post" action="/studentup3" enctype="multipart/form-data">
				<div class="row vtc">
					<div>
						<input type="file" id="type3imgInput${valueDate }" name="uploadFile" style="display:none;">
					</div>
					<div id="type3imgArea${valueDate }" class="type3_imgArea flex" onclick="type3imgup(${valueDate })">
						<div class="type3_img_inner">
							<img src="/stc/img/type3defaultimg.png" id="type3imgPreview${valueDate }">
						</div>
					</div>
				</div>
				<div class="row vtc" id="type3TextArea${valueDate }">
					<div class="type3_textArea flex">
						<textarea id="type3contentArea${valueDate }" name="type3contentArea" class="typingTextarea" style="overflow:hidden"></textarea>
					</div>
				</div>
				<div>
					<input type="hidden" id="type3weatherValue${valueDate }">
					<input type="date" id="type3date${valueDate }" name="sho_date" value="${param.type3date }" style="display:none;">
					<input type="number" name="sho_tid" id="sho_tid_type3${valueDate }" value="${data.getTho_id() }" style="display:none;">
					<input type="number" name="sho_writer" id="sho_writer_type3${valueDate }" value="${sessionScope.accountNumber }" style="display:none;">
					<input type="number" name="sho_homeworktype" id="sho_homeworktype_type3${valueDate }" value="3" style="display:none;"> 
					<textarea id="type3FinalContent${valueDate }" name="sho_contents" style="display:none;"></textarea>
					<input type="number" name="sho_grade" id="sho_grade_type3${valueDate }" value="${sessionScope.account.getSta_grade()}" style="display:none;"> 
					<input type="number" name="sho_class" id="sho_class_type3${valueDate }" value="${sessionScope.account.getSta_class() }" style="display:none;">
				</div>
				<div>
					<button type="submit" style="display:none;" id="type3diarySubmitButton${valueDate }"></button>
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