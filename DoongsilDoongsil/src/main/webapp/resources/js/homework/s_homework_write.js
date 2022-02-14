$(document).ready(function() {
		var homeworktype = $("#Tho_homeworktype_conf").val();
		
		//날짜 관련 처리
		var date = new Date();
		var newday = date.toISOString().substring(0, 10);
		$('#sho_date_type'+homeworktype).attr('value', newday);
		
		//마감날짜 관련 처리
		var endday = $("#tho_deadline").val();
		if(typeof endday == "undefined" || endday == "" || endday == null) {
			console.log("마감일 없음");
		} else {
			var newdayArr = newday.split('-');
			var enddayArr = endday.split('-');
			var newDComp = new Date(newdayArr[0], parseInt(newdayArr[1])-1, newdayArr[2]); 
			var endDComp = new Date(enddayArr[0], parseInt(enddayArr[1])-1, enddayArr[2]);
			if(newDComp.getTime() > endDComp.getTime()) {
				$("#btn_up").attr('disabled', true);
				$("#btn_img_up").attr('disabled', true);
				$("#sho_contents").attr('disabled', true);
				$("#sho_contents").attr('placeholder', "마감이 지나서 숙제를 올릴 수 없어요.");
				$("#btn_submitsh").attr('disabled', true);
				$("#type2studentsmformbtnArea").empty();
				$("#type2studentsmformbtnArea").append('<strong>마감이 지나서 숙제를 올릴 수 없습니다.</strong>');
			}
		}
		
		//input hidden 관련 버튼 action 처리
		$("#btn_up").click(function(e){
			e.preventDefault();
			$("#picFile").click();
		});
		
		//input file 개수 관련 처리
		$("#picFile").on("change", fileCheck);
		
		//comment 안 보이게 처리
		$("div[name=commentArea]").hide();
		//$("#commentCont").attr('value', false);
		
		//마우스 커서 모양 처리
		$("div[name=ajax_good]").css("cursor", "pointer");
		$("div[name=ajax_bad]").css("cursor", "pointer");
		
		//type2 조회관련 처리
		console.log("숙제타입: " + homeworktype +"|| 숙제 안했는지: " + $("#sworksnull_conf").val());
		if(homeworktype == 1) {
			$("div[name=SHtype1update]").hide();
			//if($("#sworksnull_conf").val() == 'false') {
			//	$("#type2studentsmform input").attr('readonly', true);
			//	$("#type2studentsmform input").attr('disabled', true);
			//}
		} else if(homeworktype == 2) {
			$("div[name=type2-btnArea]").hide();
			if($("#sworksnull_conf").val() == 'false') {
				console.log("숙제타입2, 학생 숙제 끝낸상태");
				$("#type2studentsmform input").attr('readonly', true);
				$("#type2studentsmform input:radio").attr('disabled', true);
				$("#btn-updateSH2").show();
			} else {
				$("#btn-submitSH2").show();
			}
		} else if(homeworktype == 3) {
			$("div[name=type3DateList]").each(function(index, item) {
				var id = $(item).attr('id');
				if($("#"+id+"Label").val() == 'comment') {
					$(item).addClass('btn-success');
				} else if($("#"+id+"Label").val() == 'content') {
					$(item).addClass('btn-secondary');
				} else if($("#"+id+"Label").val() == 'notyet') {
					$(item).addClass('btn-danger');
				} else {
					$(item).addClass('btn-primary');
				}
			});
		}
});

// 파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 3;
// 파일 고유넘버
var fileNum = 0;
// 첨부파일 배열
var content_files = new Array();

function fileCheck(e) {
    var files = e.target.files;
    
    // 파일 배열 담기
    var filesArr = Array.prototype.slice.call(files);
    
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > totalCount) {
      alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
      return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }
    
    // 각각의 파일 배열담기 및 기타
    filesArr.forEach(function (f) {
      var reader = new FileReader();
      reader.onload = function (e) {
        content_files.push(f);
        $('#uploadFileName').append(
       		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
       		+ '<font style="font-size:12px">' + f.name + '</font>'  
       		+ '<img src="/stc/img/dash-circle-dotted.svg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
       		+ '<div/>'
		);
        fileNum ++;
      };
      reader.readAsDataURL(f);
    });
    console.log(content_files + " " + fileNum);
    //초기화 한다.
    $("#picFile").val("");
}

// 파일 부분 삭제 함수
function fileDelete(fileNum){
    var no = fileNum.replace(/[^0-9]/g, "");
    content_files[no].is_delete = true;
	$('#' + fileNum).remove();
	fileCount --;
    console.log(content_files + " " + fileNum);
}

function fileUp() {
	var formData = new FormData();
	var inputFile = content_files;//$('#picFile');
	//var files = inputFile[0].files;
	var files = content_files;
	var j = 0;
	
	for(var i = 0; i < files.length; i++) {
		if(files[i].is_delete != true) {
			formData.append("uploadFile", files[i]);
			j++;
		}
	}
	
	$.ajax({
		url: '/homework/write/up/file',
		processData : false,
		contentType: false,
		data: formData,
		type: "POST",
		success: function(data) {
			if(j == 0) {
				alert("업로드할 파일이 없어 업로드기 진행되지 않았습니다.");
			} else {
				alert(j + " 개의 파일 업로드에 성공하였습니다.");
				var homeworktype = $("#sho_homeworktype_type1").val()*1;
			$('#sho_fileurl_type'+homeworktype).attr('value', data);
			$('#btn_up').attr('disabled', true);
			}
		},
		error: function() {
			alert("error");
		}
	});
}

//comment 보였다 안 보였다 하기
function commentCheck(e) {
	if($("#commentArea"+e).css("display") === 'none') {
		//$("#commentCont").attr('value', true);
		$("#commentArea"+e).show();
	} else {
		$("#commentArea"+e).hide();
	}
}

//학생숙제 채점-Good
function ajax_good(e) {
	if($("#commentArea"+e).css("display") === 'none') {
		
		$("#sho_good"+e).attr('disabled', false);
		
		$.ajax({
			url: '/ajaxComment',
			type: 'POST',
			cache: false,
			data: {
				sho_id: e,
				sho_goodbad: 'G',
			},
			success: function(data) {
				alert("'잘했어요' 로 채점에 성공했습니다.");
				$("#sho_good"+e).attr('disabled', true);
				$("#sho_bad"+e).attr('disabled', true);
				$("#btn_ajaxGood"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				$("#sho_bad"+e).hide();
				$("#btn_ajaxGood"+e).attr('disabled', true);
			},
			error: function() {
				alert("ajax error 발생");
			}
		});
	} else {
		$("#sho_good"+e).attr('disabled', false);
		$("#btn_ajaxGood"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
	}
}

//학생숙제 채점-Bad
function ajax_bad(e) {
	if($("#commentArea"+e).css("display") === 'none') {
		$("#sho_bad"+e).attr('disabled', false);
		var goodbad = $('#sho_bad'+e).val();
		$.ajax({
			url: '/ajaxComment',
			type: 'POST',
			cache: false,
			data: {
				sho_id: e,
				sho_goodbad: goodbad,
			},
			success: function(data) {
				alert("'아쉬워요'로 채점에 성공하였습니다.");
				$("#sho_bad"+e).attr('disabled', true);
				$("#sho_good"+e).attr('disabled', true);
				$("#btn_ajaxBad"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				$("#sho_good"+e).hide();
				$("#btn_ajaxBad"+e).attr('disabled', true);
			},
			error: function() {
				alert("ajax error 발생");
			}
		});
	} else {
		$("#sho_bad"+e).attr('disabled', false);
		$("#btn_ajaxBad"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
	}
}

//학생숙제 채점 전체
function submitAjaxComment(e) {
	
	if($("#ajax_good"+e).attr("disabled") && $("#ajax_bad"+e).attr("disabled")) {
		alert("숙제 채점이 되지 않았습니다.");
	} else {
		var goodbad = 'G';
		if($("#sho_good"+e).attr('disabled')) {
			goodbad = 'N';
		}
		var comment = $("#sho_comment"+e).val();
		$.ajax({
			url: '/ajaxComment',
			type: 'POST',
			cache: false,
			data: {
				sho_id: e,
				sho_goodbad: goodbad,
				sho_comment: comment
			},
			success: function(data) {
				var resultText = "";
				if(data.GoodBad == 'G') {
					resultText = "잘했어요";
				} else if(data.GoodBad == 'N') {
					resultText = "아쉬워요";
				}
				alert(data.GoodBad + "으로 채점, " + resultText+ "으로 채점에 성공했습니다.");
				$("#sho_bad"+e).attr('disabled', true);
				$("#sho_good"+e).attr('disabled', true);
				$("#btn_ajaxBad"+e).attr('disabled', true);
				$("#btn_ajaxGood"+e).attr('disabled', true);
				$("#btn_comment"+e).hide();
				$("#sho_comment"+e).attr('disabled', true);
				$("#btn_submitcomm"+e).hide();
				if(goodbad == 'G') {
					$("#sho_bad"+e).hide();
					$("#btn_ajaxGood"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				} else {
					$("#sho_good"+e).hide();
					$("#btn_ajaxBad"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				}
			},
			error: function() {
				alert("ajax error 발생");
			}
		});
	}
}

//type2. 답이 맞았다고 채점
function type2GoodMake(a, e) {//sdata.getSho_id(), type2cont.key나 status.count
	$("#"+a+"type2q"+e+"Goodbad").val('o');
	$("#btn-"+a+"type2GoodBad"+e).removeClass('btn-secondary');
	$("#btn-"+a+"type2GoodBad"+e).addClass('btn-success');
	$("#btn-"+a+"type2GoodBad"+e).html('<img src="/stc/img/circle.svg" class="ic20 filter-whtcream" />');
	$("#btn-"+a+"type2GoodBad"+e).attr('data-bs-toggle', '');
	$("#makeGoodbadSc_"+a+"_"+e).empty();
}

//type2. 답이 틀렸다고 채점
function type2BadMake(a, e) {//sdata.getSho_id(), type2cont.key나 status.count
	$("#"+a+"type2q"+e+"Goodbad").val('x');
	$("#btn-"+a+"type2GoodBad"+e).removeClass('btn-secondary');
	$("#btn-"+a+"type2GoodBad"+e).addClass('btn-danger');
	$("#btn-"+a+"type2GoodBad"+e).html('<img src="/stc/img/x-lg.svg" class="ic20 filter-whtcream" />');
	$("#btn-"+a+"type2GoodBad"+e).attr('data-bs-toggle', '');
	$("#makeGoodbadSc_"+a+"_"+e).empty();
}

function type2MakeGoodBad(a) {//sdata.getSho_id()
	var ansarr = [];
	var isblank = false;
	$("input[name="+a+"type2qAnswerInput]").each(function(index, item) {
		var v = $(this).val();
		var num = index + 1;
		if(v == "" || typeof v == "undefined" || v == null || v == 0 || v == NaN) {
			alert(num + "번 문제를 채점하지 않았습니다.");
			isblank=true;
			return false;
		} else {
			console.log(num+"번 문제: " + v);
			ansarr.push(v);
		}
	});
	if(isblank) {
		console.log("빈칸있음, 중단");
		return false;
	} else {
		console.log("빈칸없음, 진행");
	}
	var answer = ansarr.join('');
	console.log("answer: " + answer);
	$.ajax({
			url: '/ajaxComment',
			type: 'POST',
			cache: false,
			data: {
				sho_id: a,
				sho_goodbad: answer
			},
			success: function(data) {
				$("button[name=btn-"+a+"type2GoodBad]").attr('disabled', true);
				$("#type2"+a+"CompBtnArea").hide();
				
			},
			error: function() {
				alert("ajax error 발생");
			}
		});
}



function maketype2answer() {
	var type2answers = [];
	var questionlength = $("div[name=type2questionArea]").length;
	for(question = 1; question <= questionlength; question++) {
		type2answers.push(question+"||");
		var questionType = $("#type2questionType"+question).val();
		console.log("문제타입: " + questionType);
		if(questionType == 'mc') {
			
			var answer = parseInt($("input[name=type2SHquestion"+question+"mc]:checked").val());
			console.log(question+"번 문제 답: " + answer);
			if(answer == "" || typeof answer == "undefined" || answer == null || answer == 0 || isNaN(answer)) {
				alert(question+ "번 문제의 답을 입력하지 않았습니다.");
				return false;
			}
			type2answers.push(answer+"||end||");
		} else if(questionType == 'sc') {
			
			var answer = $("#type2SHquestion"+question+"sca").val();
			console.log(question+"번 문제 답: " + answer);
			if(answer == "" || typeof answer == "undefined" || answer == null || answer == 0 || answer == NaN) {
				alert(question+ "번 문제의 답을 입력하지 않았습니다.");
				$("#type2SHquestion"+question+"sca").focus();
				return false;
			}
			type2answers.push(answer+"||end||");
		} else {
			alert("예상치 못한 오류가 발생하였습니다.");
			return false;
		}
	}
	var type2contents = type2answers.join('');
	$("#sho_contents_type2").val(type2contents);
}

function submitSH1() { //초기 type1 제출하는 함수
	$("#s_homework_input").attr("action","/studentup");
	$("#s_homework_input").submit();
}

function submitSH2() {
	//초기 type2 숙제 제출하는 함수
	maketype2answer();
	$("#type2studentsmform").attr("action","/studentup2");
	$("#type2studentsmform").submit();
}

function updateSH1(e) {
	$("#SHtype1basic"+e).hide();
	$("#SHtype1update"+e).show();
	$("#sho_contents_type1_"+e).attr('readonly', false);
	$("#sho_contents_type1_"+e).attr('disabled', false);
}

function updateSH2() {
	//업데이트 폼 띄우는 함수
	$("#type2studentsmform input").attr('readonly', false);
	$("#type2studentsmform input:radio").attr('disabled', false);
	$("div[name=type2-btnArea]").hide();
	$("#btn-updateCompSH2").show();
	$("#btn-cancelSH2").show();
}

function cancelupdateSH1(e) {
	$("#SHtype1basic"+e).show();
	$("#SHtype1update"+e).hide();
	$("#sho_contents_type1_"+e).attr('readonly', true);
	$("#sho_contents_type1_"+e).attr('disabled', true);
}

function cancelupdateSH2() {
	//업데이트 폼 가리는 함수
	$("#type2studentsmform input").attr('readonly', true);
	$("#type2studentsmform input:radio").attr('disabled', true);
	$("div[name=type2-btnArea]").hide();
	$("#btn-updateSH2").show();
}

function updateCompSH1(e) {
	$("#s_homework_input").attr("action","/studentupdate1");
	$("#sho_id_type1_"+e).attr('readonly', false);
	$("#sho_id_type1_"+e).attr('disabled', false);
	$("#s_homework_input").submit();
}

function updateCompSH2() {
	//수정한 답 제출하는 함수
	maketype2answer();
	$("#type2studentsmform").attr("action","/studentupdate2");
	$("#type2studentsmform").submit();
}

function deleteHW(e) {
	window.location.replace("/deleteHW?tho_id="+e);
}

function deleteSH(e) {
	window.location.replace("/deleteSH?sho_id="+e);
}
