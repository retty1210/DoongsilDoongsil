<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src="/stc/js/cal.js"></script>
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<link href="/stc/css/doongmain.css" rel="stylesheet">
</head>
<body>
<form action="/cal" method="post" name="hiddenForm">
<input type="hidden" name="cal_title"/>
<input type="hidden" name="cal_start"/>
<input type="hidden" name="cal_end"/>
</form>
	<div class="main-first-top">
		<div class="notice-area">
		<table class="notice-table, notice-only-table">
			<th class="notice-table, th-text-position">공지사항</th>
			<tr>
				<td class="notice-table">s</td>
			</tr>
			<tr>
				<td class="notice-table">s</td>
			</tr>
		</table>
		</div>
		<div class="classBoard-area">
			<table class="classBoard-table, classBoard-only-table">
			<th class="classBoard-table, th-text-position">학급게시판</th>
			<tr>
				<td class="classBoard-table">b</td>
			</tr>
			<tr>
				<td class="classBoard-table">b</td>
			</tr>
		</table>
		</div>
	</div>
	
	<div class="main-second-bottom">
			<div id='calendar'></div>
			<div class="school-events-area">
				<div class="school-events"></div>
			</div>
	    </div>
</body>
</html>