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
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_sunny${valueDate }" name="weatherIcon${valueDate }">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'sunny'}">
							<img name="sunny_fill" src="/stc/img/brightness-high-fill.svg" class="ic20 filter-brlred" />
						</c:when>
						<c:otherwise>
							<img name="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_cloudy${valueDate }" name="weatherIcon${valueDate }">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'cloudy'}">
							<img name="cloudy_fill" src="/stc/img/cloudy-fill.svg" class="ic20 filter-grystone" />
						</c:when>
						<c:otherwise>
							<img name="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_rainy${valueDate }" name="weatherIcon${valueDate }">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'rainy'}">
							<img name="rainy_fill" src="/stc/img/cloud-rain-fill.svg" class="ic20 filter-lsrblue" />
						</c:when>
						<c:otherwise>
							<img name="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon bdr-r5" id="type3_weather_snowy${valueDate }" name="weatherIcon${valueDate }">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'snowy'}">
							<img name="snowy_fill" src="/stc/img/snow2.svg" class="ic20 filter-strblue" />
						</c:when>
						<c:otherwise>
							<img name="snowy_outline" src="/stc/img/snow.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div id="type3formArea">
			<form id="type3diarySubmit${valueDate }" class="form-horizontal">
				<div class="row vtc">
					<div>
						<input type="file" id="type3imgInput${valueDate }" name="sho_fileurl" style="display:none;">
					</div>
					<div id="type3imgArea${valueDate }" class="type3_imgArea flex" >
						<div class="type3_img_inner">
							<img src="/stc/up/${param.type3sWork }" id="type3imgPreview${valueDate }">
						</div>
					</div>
				</div>
				<div class="row vtc" id="type3TextArea${valueDate }">
					<div class="type3_textArea flex">
						<textarea id="type3contentArea${valueDate }" class="typingTextarea" style="overflow:hidden" readonly>${param.type3content }</textarea>
					</div>
				</div>
				<div>
					<input type="hidden" id="type3weatherValue${valueDate }" value="${param.type3sWeather }">
					<input type="hidden" id="type3imglink${valueDate }" value="${param.type3sWork }">
					<input type="date" id="type3date${valueDate }" style="display:none;" value="${type3date }">
				</div>
			</form>
		</div>
		
		<div id="type3commentArea${valueDate }" class="row vtc flex">
			<form id="type3commentSubmit${valueDate }" class="form-horizontal row">
				<div class="col-md-3 inline-b commentTextLabel">
					<span>
						<strong>선생님의<br>한마디</strong>
					</span>
				</div>
				<div class="col-md-9 inline-b" id="type3_commentArea_inner${valueDate }">
					<textarea id="type3comment${valueDate }" class="form-control commentTextarea" row="2" disabled></textarea>
				</div>
			</form>
		</div>
	</div>
</div>