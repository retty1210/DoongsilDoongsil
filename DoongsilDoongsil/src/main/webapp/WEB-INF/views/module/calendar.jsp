<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 캘린더API 따로 빼서 만든 파일입니다. 적용하려면 원하는 페이지에 밑에 코드 작성하면 됩니다.
	<jsp:include page="/WEB-INF/views/module/calendar.jsp" flush="false" /> 
--%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />

<div id='calendar' class="calendar-area"></div>