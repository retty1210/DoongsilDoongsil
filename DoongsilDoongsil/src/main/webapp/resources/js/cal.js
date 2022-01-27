  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
	var dateFormat = new Date();
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
        var title = prompt('일정 추가:');
        if (title) {
          calendar.addEvent({
            title: title,
            start: arg.start,
            end:arg.end,
			allDay: true
          })
		console.log('start = >' + moment(arg.start).format('YYYY-MM-DD hh:mm:ss'));
		console.log('end = >'+ moment(arg.end).format('YYYY-MM-DD hh:mm:ss'));
			$.ajax({
				url:"/cal",
				type:"post",
				data:{
					cal_title:title,
					cal_start: moment(arg.start).format('YYYY-MM-DD hh:mm:ss'),
					cal_end: moment(arg.end).format('YYYY-MM-DD hh:mm:ss')
				},
				success: function(response){
					alert('일정이 추가 되었습니다.');
				},
				error: function(data){
					alert('일정이 추가 되지않았습니다.');
				}
				
			});
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
        if (confirm('일정을 삭제하시겠습니까?')) {
          arg.event.remove();
		  alert("삭제 되었습니다.");
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
	
		]

    });

    calendar.render();
  });
