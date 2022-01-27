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
        var title = prompt('Event Title:');
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
					alert(data.cal_start);
				}
				
			});
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
        if (confirm('Are you sure you want to delete this event?')) {
          arg.event.remove()
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
	
		]

    });

    calendar.render();
  });
