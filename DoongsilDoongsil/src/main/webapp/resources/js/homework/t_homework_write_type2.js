$(document).ready(function() {
	
	//$("#btn_type2submit").prop('disabled', true);
});

//document.ready때 할것: 업로드버튼 disabled, mcArea/scArea none, 
function type2mc(a) {
	if($("#type2_mcArea"+a+"_q").css("display") === 'none') {
		$("#type2_mcArea"+a+"_q").show();
		$("#type2_scArea"+a+"_q").hide();
		$("#type2_noArea"+a+"_q").hide();
		$("#btn_mc"+a).removeClass('btn-rwh');
		$("#btn_mc"+a).addClass('btn-ryl');
		$("#btn_sc"+a).removeClass('btn-ryl');
		$("#btn_sc"+a).addClass('btn-rwh');
	} else {
		alert("이미 객관식을 선택하셨습니다.");
	}
}

function type2sc(a) {
	if($("#type2_scArea"+a+"_q").css("display") === 'none') {
		$("#type2_scArea"+a+"_q").show();
		$("#type2_mcArea"+a+"_q").hide();
		$("#type2_noArea"+a+"_q").hide();
		$("#btn_sc"+a).removeClass('btn-rwh');
		$("#btn_sc"+a).addClass('btn-ryl');
		$("#btn_mc"+a).removeClass('btn-ryl');
		$("#btn_mc"+a).addClass('btn-rwh');
	} else {
		alert("이미 주관식을 선택하셨습니다.");
	}
}

function type2mcplus(a, e) {
	if(e >= 5) {
		alert("객관식 문항은 5개까지만 입력할 수 있습니다.");
		return false;
	} else {
		var numb = 1;
		var name = "type2_mcArea" + a;
		var length = $("input[name="+name+"_mc_input]").length;
		if(length >= 5) { //총 번호 개수가 5개 이상
			alert("객관식 답은 5번까지만 입력 가능합니다.");
			return false;
		} else  {
			if(e == length) { //마지막 번호에서 추가 누름
				numb = e + 1;
			} else {//중간번호에서 추가 누름
				numb = length + 1;
			}
			$("#"+name+"_mc"+numb+"_q").show();
			$("#"+name+"_mc"+numb+"_q").append(
				'<div class="col-md-1"><span><strong>('+numb+')</strong></span></div>'
				+'<div class="col-md-8">'
				+'<input type="text" id="'+name+'_mc'+numb+'" class="form-control" name="'+name+'_mc_input">'
				+'</div>'
				+'<div class="col-md-1" style="padding-top:6px;">'
				+'정답 '
				+'<input type="radio" class="form-check-input" id="'+name+'_ans'+numb+'" name="'+name+'_ans" value="'+numb+'">'
				+'</div>'
				+'<div class="col-md-1" id="'+name+'_mc'+numb+'_plus'+numb+'" name="'+name+'" onclick="type2mcplus('+a+', '+numb+')">'
				+'<img src="/stc/img/plus-circle-dotted.svg" class="ic30 filter-lsrblue filter-skyblue-hover" />'
				+'</div>'
				+'<div class="col-md-1" id="'+name+'_mc'+numb+'_minus'+numb+'" onclick="type2mcminus('+a+', '+numb+')">'
				+'<img src="/stc/img/dash-circle-dotted.svg" class="ic30 filter-lsrblue filter-skyblue-hover" />'
				+'</div>'
			);
		}
	}
}

function type2mcminus(a, e) {
	if(e == 1) {
		alert("1번 항목은 삭제할 수 없습니다.");
		return false;
	} else {
		var name = "type2_mcArea"+a;
		var length = $("input[name="+name+"_mc_input]").length;
		console.log("length: " + length);
		if(e == length) {
			//정상. 삭제 로직 작동
			$("#"+name+"_mc"+e+"_q").empty();
			$("#"+name+"_mc"+e+"_q").hide();
			alert(a+"번 문제의 "+e+"번 답안을 삭제하였습니다.");
		} else {
			alert("해당 문제의 가장 마지막 번호부터 삭제해주세요.");
			return false;
		}
	}
}

function type2qplus(a) {
	var length = $("div[name=type2_q_no]").length;
	if(length >= 10) {
		alert("문제는 10번까지만 추가할 수 있습니다.");
		return false;
	} else {
		var numb = 1;
		if(a == length) { //마지막 문제에서 추가 누름
			numb = a + 1;
		} else { //중간 번호에서 추가 누름
			numb = length + 1;
		}
		$("#t_hw_2_question_"+numb).show();
		$("#t_hw_2_question_"+numb).append(
			'<div class="row tmg10">'
			+'<div id="type2_q_no'+numb+'" name="type2_q_no" class="col-md-2"><span><strong>'+numb+'번 문제</strong></span></div>'
			+'<div id="type2_q_qArea'+numb+'" name="type2_q_qArea" class="col-md-8">'
			+'<input type="text" id="type2_q'+numb+'" name="type2_q'+numb+'" class="form-control" placeholder="학생에게 낼 문제를 입력하세요.">'
			+'</div>'
			+'<div id="type2_q_bArea'+numb+'" name="type2_q_bArea" class="col-md-2">'
			+'<button type="button" id="btn_mc'+numb+'" name="btn_mc" onclick="type2mc('+numb+')" class="btn btn-rwh btn-sm">객관식</button>'
			+' '
			+'<button type="button" id="btn_sc'+numb+'" name="btn_sc" onclick="type2sc('+numb+')" class="btn btn-rwh btn-sm">주관식</button>'
			+'</div>'
			+'</div>'
			+'<div id="type2_mcArea'+numb+'_q" name="type2_mcArea_q" style="display:none;" class="row tmg10">'
			+'<span class="help-block tmg10 small"><strong>객관식 문제의 답을 입력하세요.(최대 5개까지 입력할 수 있습니다.)</strong></span>'
			+'<div id="type2_mcArea'+numb+'_mc1_q" name="type2_mcArea'+numb+'_q" class="row flex tmg10">'
			+'<div class="col-md-1"><span><strong>(1)</strong></span></div>'
			+'<div class="col-md-8">'
			+'<input type="text" id="type2_mcArea'+numb+'_mc1" class="form-control" name="type2_mcArea'+numb+'_mc_input">'
			+'</div>'
			+'<div class="col-md-1" style="padding-top:6px;">'
			+'정답 '
			+'<input type="radio" class="form-check-input" id="type2_mcArea'+numb+'_ans1" name="type2_mcArea'+numb+'_ans" value="1">'
			+'</div>'
			+'<div class="col-md-1" id="type2_mcArea'+numb+'_mc1_plus1" name="type2_mcArea'+numb+'" onclick="type2mcplus('+numb+', 1)">'
			+'<img src="/stc/img/plus-circle-dotted.svg" class="ic30 filter-rylblue filter-drtblue-hover" />'
			+'</div>'
			+'<div class="col-md-1" id="type2_mcArea'+numb+'_mc1_minus1" onclick="type2mcminus('+numb+', 1)">'
			+'<img src="/stc/img/dash-circle-dotted.svg" class="ic30 filter-rylblue filter-drtblue-hover" />'
			+'</div>'
			+'</div>'
			+'<div id="type2_mcArea'+numb+'_mc2_q" name="type2_mcArea'+numb+'_q" class="row flex tmg10" style="display:none;"></div>'
			+'<div id="type2_mcArea'+numb+'_mc3_q" name="type2_mcArea'+numb+'_q" class="row flex tmg10" style="display:none;"></div>'
			+'<div id="type2_mcArea'+numb+'_mc4_q" name="type2_mcArea'+numb+'_q" class="row flex tmg10" style="display:none;"></div>'
			+'<div id="type2_mcArea'+numb+'_mc5_q" name="type2_mcArea'+numb+'_q" class="row flex tmg10" style="display:none;"></div>'
			+'</div>'
			+'<div id="type2_scArea'+numb+'_q" name="type2_q_scArea" style="display:none;" class="row tmg10">'
			+'<span class="help-block tmg10 small"><strong>주관식 - 학생의 문제풀이에 도움이 될 안내문을 입력하세요(선택)</strong></span>'
			+'<div class="col-md-1"></div>'
			+'<div class="col-md-10">'
			+'<input type="text" id="type2_scArea'+numb+'_sc" name="type2_scArea_sc" class="form-control" >'
			+'</div>'
			+'</div>'
			+'<div id="type2_noArea'+numb+'_q" name="type2_q_noArea" class="row tmg40">'
			+'<span class="help-block rylblue"><strong>객관식이나 주관식 중 하나를 반드시 선택해야만 합니다.</strong></span>'
			+'</div>'
			+'<hr>'
			+'<div class="row flex tmg10">'
			+'<div id="type2_q_plusArea'+numb+'" name="type2_q_plusArea" onclick="type2qplus('+numb+')" class="col-md-1">'
			+'<img src="/stc/img/plus-circle-fill.svg" class="ic40 filter-lsrblue filter-skyblue-hover" />'
			+'</div>'
			+'<div id="type2_q_minusArea'+numb+'" name="type2_q_minusArea" onclick="type2qminus('+numb+')" class="col-md-1">'
			+'<img src="/stc/img/dash-circle-fill.svg" class="ic40 filter-lsrblue filter-skyblue-hover" />'
			+'</div>'
			+'</div>'
			//
			//+'<div name="type2_q_no"><p>문제 잘 추가되는지 확인</p><br>'
			//+ '<p>'+numb+'번문제</p><br>'
			//+'<p>실제 문제는 css 끝나고 추가할것!</p></div>'
			//+'<div id="type2_q_plusArea'+numb+'" name="type2_q_plusArea" onclick="type2qplus('+numb+')">'
			//+'<img src="/stc/img/plus-circle-fill.svg" class="ic40 strblue" />'
			//+'</div>'
			//+'<div id="type2_q_minusArea'+numb+'" name="type2_q_minusArea" onclick="type2qminus('+numb+')">'
			//+'<img src="/stc/img/dash-circle-fill.svg" class="ic40 strblue" />'
			//+'</div>'
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
			$("#t_hw_2_question_"+a).hide();
		} else {
			alert("마지막 문제부터 삭제해주세요.");
		}
	}
}


function type2makeContents() {
	//답 넣을 array 만듬
	var type2contents = [];
	//빈칸이 있는지 확인하는 용의 값 만듬
	var isquestionblank = true;
	//문제가 몇번까지 있는지 확인
	var questionlength = $("div[name=type2_q_no]").length;
	//있는 번호까지 for문 돌림
	outer: for(question = 0; question < questionlength; question++) {
		//문제의 값 받을 array 만듬
		var type2qarr = [];
		var index = question + 1;//문제번호
		console.log("outer for문 시작: " + index + "번 문제 시작");
		//1. 학생에게 낼 문제입력하기
		questiontext = $("#type2_q"+index).val().replace('|','');//구분자를 사용하기 위해서 사용자가 입력한 |를 없애줌
		if(questiontext == "" || typeof questiontext == "undefined" || questiontext == null || questiontext.length == 0) {
			alert("문제는 빈칸으로 남겨둘 수 없습니다.");
			console.log("빈칸: " + index+ "번");
			$("#type2_q"+index).focus();
			return false;
		}
		type2qarr.push(index+"||" + $("#type2_q"+index).val().replace('|',''));
		//2. 객관식인지 주관식인지, 혹은 비어있는지 확인
		if($("#type2_mcArea"+index+"_q").is(':visible')) {//객관식
			type2qarr.push("||mc");
			//객관식 번호가 몇번까지 있는지 확인
			var multichoice = $("input[name=type2_mcArea"+index+"_mc_input]").length;
			console.log(index + "번 문제 객관식 답 개수: " + multichoice + " 개");
			if(multichoice < 2) {
				alert(index + "번 문제의 객관식 답 수가 너무 적습니다.\n객관식의 답은 반드시 2개 이상이어야 합니다.");
				console.log("객관식 문제수 에러: " + index + "번");
				return false;
			}
			var answer = $("input[name=type2_mcArea"+index+"_ans]:checked").val();
			if(answer == "" || typeof answer == "undefined" || answer == null || answer == 0) {
				alert("객관식 " + index + "번 문제의 정답을 지정하지 않았습니다.");
				return false;
			}
			inner: for(multi = 0; multi < multichoice; multi++) {//있는 번호까지 값을 넣어준다
				var mcindex = multi + 1;
				console.log("inner for문 시작: " + index + "번 문제의 " + mcindex + "번");
				//input이 입력되어 있는지 확인
				var mcval = $("#type2_mcArea"+index+"_mc"+mcindex).val().replace('|','');
				if(typeof mcval == "undefined" || mcval == "" || mcval == null || mcval.length == 0) {//빈칸<-제대로 작동안함
					let mctext = index+"번 문제의 "+mcindex+" 번 칸이 빈칸입니다.\n이대로 업로드하시겠습니까?";
					if(confirm(mctext) == false) { //해당 input으로 커서 옮겨주고 작업중단
						$("#type2_mcArea"+index+"_mc"+mcindex).focus();
						isquestionblank = false;
						//break outer;
						return false;
					} else { 
						//null값으로 업로드를 해도 되나?
					}
				}
				type2qarr.push("||mc"+mcindex+"||"+mcval);
			}
			type2qarr.push("||" + $("input[name=type2_mcArea"+index+"_ans]:checked").val());
			type2qarr.push("||end||");
		} else if($("#type2_scArea"+index+"_q").is(':visible')) {//주관식
			type2qarr.push("||sc||");
			//설명이 입력되었는지 확인
			var scval = $("#type2_scArea"+index+"_sc").val().replace('|','');
			if(typeof scval == "undefined" || scval == "" || scval == null) {//빈칸
				
			} else {
				type2qarr.push(scval);
			}
			type2qarr.push("||end||");
		} else {//객관/주관식 설정안함: break;
			alert("객관식/주관식을 설정하지 않은 문제가 있어서 글을 올릴 수 없습니다.");
			isquestionblank = false;
			//break outer;
			return false;
		}
		var cont = type2qarr.join('');
		console.log(index + "번 문제: " + cont);
		type2contents.push(cont);
	}
	//form을 올려도 되는지 판단
	if(isquestionblank) {//업로드 가능
		var contents = type2contents.join('');
		console.log("전체 입력값: " + contents);
		//$("#tho_contents_type1").attr('disabled', true);
		//textarea hidden으로 만들어서 거기에 값 input
		$("#tho_contents_type1").val('');
		$("#tho_contents_type1").val(contents);
		//$("#type2_q_textarea").attr('value', contents);
		$('#hw_write_form').submit();
	} else {//업로드 못함
		return false;
	}
}