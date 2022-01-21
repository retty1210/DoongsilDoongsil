$(document).ready(function() {
		$("#t_hw_write_type2").attr('style', "display:none;");
		
		var date = new Date();
		var newday = date.toISOString().substring(0, 10);
		document.getElementById('tho_deadline').value=newday;
		document.getElementById('tho_deadline').min=newday;
		
		alert("지금: " + newday.toLocaleString());
		var maxday = new Date(date);
		maxday.setDate(date.getDate() + 7);
		alert("max날짜: " + maxday);
		document.getElementById('tho_deadline').max=maxday.toISOString().substring(0, 10);
})

$(function(){
	$("#tho_homeworktype").change(function() {
			alert("change");
			if($(this).val() == 1) {
				$("#t_hw_write_type1").attr('style', "display:;");
				$("#t_hw_write_type2").attr('style', "display:none;");
			} else if($(this).val() == 2) {
				$("#t_hw_write_type1").attr('style', "display:none;");
				$("#t_hw_write_type2").attr('style', "display:;");
			}
		});
})
