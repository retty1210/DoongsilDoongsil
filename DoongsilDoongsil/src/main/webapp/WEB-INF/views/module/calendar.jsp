<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<script src="/stc/js/cal.js"></script>
<link href="/stc/css/doongmain.css" rel="stylesheet" type="text/css" />
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />


<form action="/mainpage" method="post" name="hiddenForm">
	<input type="hidden" name="cal_title"/>
	<input type="hidden" name="cal_start"/>
	<input type="hidden" name="cal_end"/>
</form>

<div id='calendar' class="calendar-area"></div>