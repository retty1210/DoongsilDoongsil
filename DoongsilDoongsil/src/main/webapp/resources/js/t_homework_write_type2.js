$(document).ready(function() {
	
	//$("#btn_type2submit").prop('disabled', true);
});

//document.ready때 할것: 업로드버튼 disabled, mcArea/scArea none, 
function type2mc(a) {
	if($("#type2_mcArea"+a+"_q").css("display") === 'none') {
		$("#type2_mcArea"+a+"_q").show();
		$("#type2_scArea"+a+"_q").hide();
		$("#type2_noArea"+a+"_q").hide();
		$("#btn_mc"+a).css({ background: "#87CEEB", color: "#FCFBF4"});
		$("#btn_sc"+a).css({ background: "#FCFBF4", color: "#87CEEB"});
	} else {
		alert("이미 객관식을 선택하셨습니다.");
	}
}

function type2sc(a) {
	if($("#type2_scArea"+a+"_q").css("display") === 'none') {
		$("#type2_scArea"+a+"_q").show();
		$("#type2_mcArea"+a+"_q").hide();
		$("#type2_noArea"+a+"_q").hide();
		$("#btn_sc"+a).css({ background: "#87CEEB", color: "#FCFBF4"});
		$("#btn_mc"+a).css({ background: "#FCFBF4", color: "#87CEEB"});
	} else {
		alert("이미 주관식을 선택하셨습니다.");
	}
}

function type2mcplus(a, e) {
	if(e >= 5) {
		alert("객관식 문항은 5개까지만 입력할 수 있습니다.");
	} else {
		var numb = 1;
		var name = "type2_mcArea" + a;
		var length = $("input[name="+name+"_mc_input]").length;
		if(length >= 5) { //총 번호 개수가 5개 이상
			alert("객관식 답은 5번까지만 입력 가능합니다.");
		} else  {
			if(e == length) { //마지막 번호에서 추가 누름
				numb = e + 1;
			} else {//중간번호에서 추가 누름
				numb = length + 1;
			}
			$("#"+name+"_mc"+numb+"_q").append(
				'<div>'
				+ '<label for="'+name+'_mc'+numb+'">('+numb+')</label>'
				+ '<input type="text" id="'+name+'_mc'+numb+'" name="'+name+'_mc_input">'
				+ '</div>'
				+ '<div id="'+name+'_mc'+numb+'_plus'+numb+'" name="'+name+'" onclick="type2mcplus('+a+', '+numb+')">'
				+ '<img src="/stc/img/plus-circle-dotted.svg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />'
				+ '</div>'
				+ '<div id="'+name+'_mc'+numb+'_minus'+numb+'" onclick="type2mcminus('+a+', '+numb+')">'
				+ '<img src="/stc/img/dash-circle-dotted.svg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />'
				+ '</div>'
			);
		}
	}
}

function type2mcminus(a, e) {
	if(e == 1) {
		alert("1번 항목은 삭제할 수 없습니다.");
	} else {
		var name = "type2_mcArea"+a;
		var length = $("input[name="+name+"_mc_input]").length;
		console.log("length: " + length);
		if(e == length) {
			//정상. 삭제 로직 작동
			$("#"+name+"_mc"+e+"_q").empty();
			alert(a+"번 문제의 "+e+"번 답안을 삭제하였습니다.");
		} else {
			alert("해당 문제의 가장 마지막 번호부터 삭제해주세요.");
		}
	}
}

function type2qplus(a) {
	var length = $("div[name=type2_q_no]").length;
	if(length >= 10) {
		alert("문제는 10번까지만 추가할 수 있습니다.");
	} else {
		var numb = 1;
		if(a == length) { //마지막 문제에서 추가 누름
			numb = a + 1;
		} else { //중간 번호에서 추가 누름
			numb = length + 1;
		}
		$("#t_hw_2_question_"+numb).append(
			'<div name="type2_q_no"><p>문제 잘 추가되는지 확인</p><br>'
			+ '<p>'+numb+'번문제</p><br>'
			+'<p>실제 문제는 css 끝나고 추가할것!</p></div>'
			+'<div id="type2_q_plusArea'+numb+'" name="type2_q_plusArea" onclick="type2qplus('+numb+')">'
			+'<img src="/stc/img/plus-circle-fill.svg" style="width:50px; height:auto; vertical-align: middle; cursor: pointer;" />'
			+'</div>'
			+'<div id="type2_q_minusArea'+numb+'" name="type2_q_minusArea" onclick="type2qminus('+numb+')">'
			+'<img src="/stc/img/dash-circle-fill.svg" style="width:50px; height:auto; vertical-align: middle; cursor: pointer;" />'
			+'</div>'
		);
	}
}

function type2qminus(a) {
	if(a == 1) {
		alert("1번 문제는 삭제할 수 없습니다.");
	} else {
		var length = $("div[name=type2_q_no]").length;
		if(a==length) {
			$("#t_hw_2_question_"+a).empty();
		} else {
			alert("마지막 문제부터 삭제해주세요.");
		}
	}
}

function type2completeForm() {
	var res = false;
	$("div[name=type2_q_noArea]").each(function (i, e) {
		if($(e).css("display") === 'none') {
			res = true;
		}
	});
	if(res) {
		alert("form 넘길수있음");
		//
	} else {
		alert("form 못넘김");
	}
}