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
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_sunny">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'sunny'}">
							<img id="sunny_fill" src="/stc/img/brightness-high-fill.svg" class="ic20 filter-brlred" />
						</c:when>
						<c:otherwise>
							<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_cloudy">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'cloudy'}">
							<img id="cloudy_fill" src="/stc/img/cloudy-fill.svg" class="ic20 filter-grystone" />
						</c:when>
						<c:otherwise>
							<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_rainy">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'rainy'}">
							<img id="rainy_fill" src="/stc/img/cloud-rain-fill.svg" class="ic20 filter-lsrblue" />
						</c:when>
						<c:otherwise>
							<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon bdr-r5" id="type3_weather_snowy">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'snowy'}">
							<img id="snowy_fill" src="/stc/img/snow2.svg" class="ic20 filter-strblue" />s
						</c:when>
						<c:otherwise>
							<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div id="type3formArea">
			<form id="type3imgSubmit" class="form-horizontal">
				<div class="row vtc">
					<div>
						<input type="file" id="type3imgInput" style="display:none;">
					</div>
					<div id="type3imgArea" class="type3_imgArea flex" >
						<div class="type3_img_inner">
							<img src="${param.type3sWork }" id="type3imgPreview">
						</div>
					</div>
				</div>
			</form>
			<form id="type3diarySubmit" class="form-horizontal">
				<div class="row vtc" id="type3TextArea">
					<div class="type3_textArea flex">
						<textarea id="type3contentArea" class="typingTextarea" style="overflow:hidden" value="${param.type3sContent }"></textarea>
					</div>
				</div>
				<div>
					<input type="hidden" id="type3weatherValue" value="${param.type3sWeather }">
					<input type="hidden" id="type3imglink" value="${param.type3sWork }">
					<input type="date" id="type3date" style="display:none;" value="${type3date }">
				</div>
			</form>
		</div>
		
		<div id="type3commentArea" class="container row vtc flex">
			<form id="type3commentSubmit" class="form-horizontal row">
				<div class="col-md-2 inline-b">
					<span>
						<strong>선생님의<br>한마디</strong>
					</span>
				</div>
				<div class="col-md-9 inline-b" id="type3_commentArea_inner">
					<textarea id="type3comment" class="form-control commentTextarea" row="2" disabled></textarea>
				</div>
			</form>
		</div>
	</div>
</div>