<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<link href="/stc/css/doongmain.css" / rel="stylesheet">
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script>

		document.addEventListener('DOMContentLoaded', function() {
		  var calendarEl = document.getElementById('calendar');
		
		  var calendar = new FullCalendar.Calendar(calendarEl, {
			  // initialDate: '2020-09-12' 페이지 켰을 때 보여지는 날짜 지정할 수 있고 
			  // initialDate사용안하면 현재 날짜로 표시
		    editable: false, // calendar의 일정바?를 옮길 수 있게 하는 기능 
		    selectable: true, // claendar의 날짜박스를 클릭할 수 있게 하는 기능
		    businessHours: true, // 월~금 09~17시까지 업무시간으로 이 시간대 이벤트는 모두 강조됨
		    dayMaxEvents: true, // allow "more" link when too many events
		    events: [
		    	{
		    		title: 'OT',
		    		start: '2022-01-24',
		    		backgroundColor: 'red'
		    	}
		    ]
		  });
		
		  calendar.render();
		});

</script>
<style>

</style>
</head>
<body>
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