document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
	var dateFormat = new Date();
	var teacher = $('#T_check').text();
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth'
      },
	  locale: 'ko',
	  fixedWeekCount : false, // 월마다 나오는 주 수정할 수 있음 true면 무조건 6주
      navLinks: false, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
		if(teacher.trim() == "교사"){
	        var title = prompt('일정 추가:');
			console.log("title1: " + title); // 일정 제목이 담김
		        if (title) {
				console.log("title2: " + title);
		          calendar.addEvent({
		            title: title,
		            start: arg.start,
		            end:arg.end,
					allDay: true,
					backgroundColor: '#77b0bf'
		          })
			//console.log('start = >' + moment(arg.start).format('YYYY-MM-DD'));
			//console.log('end = >'+ moment(arg.end).format('YYYY-MM-DD'));
					$.ajax({
						url:"/insertDate",
						type:"post",
						data:{
							cal_title:title,
							cal_start: moment(arg.start).format('YYYY-MM-DD'),
							cal_end: moment(arg.end).format('YYYY-MM-DD'),
						},
						success: function(response){ 
							alert('일정이 추가 되었습니다.');
							location.reload();
						},
						error: function(response){
							alert('일정이 추가 되지않았습니다.');
						}
						
					});
			
		}
			}
        calendar.unselect()
      },
      eventClick: function(arg) {
		//console.log(arg.event.title);
		if(teacher.trim() == "교사"){
	        if (confirm('일정을 삭제하시겠습니까?') ) {
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
							 location.reload();
						},
						error: function(response) {
							alert('일정이 삭제 되지 않았습니다.');
						}
				 });
	        }
		}
      },
      editable: false,
      dayMaxEvents: true, // allow "more" link when too many events
      events: function(arg, successCallback) {
			$.ajax({
				url: "/getEvent",
				type: "GET",
				dataType: "json",
				success: function(response) {
					//console.log(response);
					var events = [];
					$.each(response, function(index, data) {
						events.push({
							title: data.cal_title,
							start: moment(data.cal_start).format('YYYY-MM-DD'),
							end : moment(data.cal_end).format('YYYY-MM-DD'),
							backgroundColor : data.cal_bgc
						});
					});
				successCallback(events);
				}
			});
		}

    });
    calendar.render();
  });


var res;
var aTag = document.getElementsByTagName('a');
window.onload = function() {
	let href="/mainPop";
	var cookiedata = document.cookie;
    if(cookiedata.indexOf("close=Y")<0){
		window.open(href, 'pop', 'width=300, height=350');
    }
	
	
	
	var mon = $('h2').text().replace("년", "-").replace("월", "").replace(" ", "");
	$.ajax({
		url: "/getList",
		type: "GET",
		dataType: 'json',
		data: {
			date : mon
		},
		success: function(response) {
			console.log(response);
			res = response;
			var listArr = [];
			
			$.each(response, function(index, data){
				listArr.push(data['cal_title']);
			});
			//console.log(listArr);
			
			for(var a=0; a < listArr.length; a++){
				$('.academic-list').append("<li>" + listArr[a] + "</li>");
			}
		},
		error: function(response) {
			alert('error');
		},
	})
	$('.fc-next-button, .fc-prev-button, .fc-today-button').on('click', function() {
		$('.academic-list').children().remove();
		var mon = $('h2').text().replace("년", "-").replace("월", "").replace(" ", "");
			$.ajax({
			url: "/getList",
			type: "GET",
			dataType: 'json',
			data: {
				date : mon
			},
			success: function(response) {
				console.log(response);
				res = response;
				var listArr = [];
				
				$.each(response, function(index, data){
					listArr.push(data['cal_title']);
				});
				//console.log(listArr);
				
				for(var a=0; a < listArr.length; a++){
					$('.academic-list').append("<li>" + listArr[a] + "</li>");
				}
			},
			error: function(response) {
				alert('error');
			}
		})
	})
}

