
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
	var dateFormat = new Date();
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth'
      },
      navLinks: false, // can click day/week names to navigate views
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
		//console.log('start = >' + moment(arg.start).format('YYYY-MM-DD'));
		//console.log('end = >'+ moment(arg.end).format('YYYY-MM-DD'));
			$.ajax({
				url:"/mainpage",
				type:"post",
				data:{
					cal_title:title,
					cal_start: moment(arg.start).format('YYYY-MM-DD'),
					cal_end: moment(arg.end).format('YYYY-MM-DD')
				},
				success: function(response){
					alert('일정이 추가 되었습니다.');
				},
				error: function(response){
					alert('일정이 추가 되지않았습니다.');
				}
				
			});
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
		console.log(arg.event.title);
        if (confirm('일정을 삭제하시겠습니까?')) {
			$.ajax({
					url: '/deleteEvents',
					type: 'POST',
					data: {
						cal_title: arg.event.title,
						cal_start: moment(arg.event.start).format('YYYY-MM-DD'),
						cal_end: moment(arg.event.end).format('YYYY-MM-DD')
					}, 
					success: function(response) {
						 arg.event.remove();
			  			 alert("일정이 삭제 되었습니다.");
					},
					error: function(response) {
						alert('일정이 삭제 되지 않았습니다.');
					}
			 });
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
		function(arg) {
			console.log(arg);
			var e = "<c:out value='${calendarList}'/>";
			$.ajax({
				url: '/mainpage',
				type: 'GET',
				success: function(e) {
					console.log(data.calendarList.cal_title);
					},
					error: function(e){
						console.log(e);
						}
			});
		 },
		 {
			title: 'aaaa',
			start: '2022-02-05',
			end: '2022-02-06'
		}
	  ]

    });
    calendar.render();
  });
