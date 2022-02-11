<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- ${type3date} -->

<div class="container type3Container flex">
	<fmt:parseDate var="type3date" value="${param.type3date }" pattern="yyyy-MM-dd" />
	<fmt:formatDate var="valueDate" value="${type3date }" pattern="yyyyMMdd" />
	<div id="type3area${valueDate }_${param.type3writer}" class="bdr-1 bdr-r5 type3_containerArea">
		<div class="row flex type3_titleArea">
			<div class="col-md-8 type3_titleAreaSub flex">
				<span>
					<strong><fmt:formatDate value="${type3date }" type="date" pattern="yyyy년 MM월 dd일"/></strong>
				</span>
			</div>
			<div class="col-md-4 type3_titleAreaSub flex">
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_sunny${valueDate }_${param.type3writer}" name="weatherIcon${valueDate }_${param.type3writer}">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'sunny'}">
							<img name="sunny_fill" src="/stc/img/brightness-high-fill.svg" class="ic20 filter-brlred" />
						</c:when>
						<c:otherwise>
							<img name="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_cloudy${valueDate }_${param.type3writer}" name="weatherIcon${valueDate }_${param.type3writer}">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'cloudy'}">
							<img name="cloudy_fill" src="/stc/img/cloudy-fill.svg" class="ic20 filter-grystone" />
						</c:when>
						<c:otherwise>
							<img name="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon" id="type3_weather_rainy${valueDate }_${param.type3writer}" name="weatherIcon${valueDate }_${param.type3writer}">
					<c:choose>
						<c:when test="${param.type3sWeather eq 'rainy'}">
							<img name="rainy_fill" src="/stc/img/cloud-rain-fill.svg" class="ic20 filter-lsrblue" />
						</c:when>
						<c:otherwise>
							<img name="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="fs-2 mb-3 col-md-3 weatherIcon bdr-r5" id="type3_weather_snowy${valueDate }_${param.type3writer}" name="weatherIcon${valueDate }_${param.type3writer}">
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
		<div id="type3formArea${valueDate }_${param.type3writer}">
			<div class="row vtc">
				
				<div id="type3imgArea${valueDate }_${param.type3writer}" class="type3_imgArea flex" >
					<div class="type3_img_inner">
						<img src="/stc/up/${param.type3sWork }" id="type3imgPreview${valueDate }_${param.type3writer}">
					</div>
				</div>
			</div>
			<div class="row vtc" id="type3TextArea${valueDate }_${param.type3writer}">
				<div class="type3_textArea flex">
					<textarea id="type3contentArea${valueDate }_${param.type3writer}" class="typingTextarea" style="overflow:hidden" readonly>${param.type3content }</textarea>
				</div>
			</div>
		</div>
		
		<div id="type3commentArea${valueDate }_${param.type3writer}" class="container row vtc flex">
			<form id="type3commentSubmit${valueDate }_${param.type3writer}" class="form-horizontal row" method="post" >
				<div class="row">
					<div class="col-md-3 inline-b commentTextLabel">
						<span>
							<strong>선생님의<br>한마디</strong>
						</span>
						<c:if test="${empty param.type3comment}">
							<div class="col-md-12" id="type3SubmitBtnArea${valueDate }_${param.type3writer}">
								<button type="button" onclick="type3comment(this)" id="type3commentSubmitbtn${valueDate }_${param.type3writer}" class="btn btn-ryl">등록</button>
							</div>
						</c:if>
					</div>
					<div class="col-md-9 inline-b" id="type3_commentArea_inner${valueDate }_${param.type3writer}">
						<c:choose>
							<c:when test="${!empty param.type3comment}">
								<textarea id="type3comment${valueDate }_${param.type3writer}" class="form-control commentTextarea" name="sho_comment" row="3" readonly>${param.type3comment}</textarea>
							</c:when>
							<c:otherwise>
								<textarea id="type3comment${valueDate }_${param.type3writer}" class="form-control commentTextarea" name="sho_comment" row="3"></textarea>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<input type="hidden" value="${param.type3id }" id="type3id${valueDate }_${param.type3writer}">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>