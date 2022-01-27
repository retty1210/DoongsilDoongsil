$(document).ready(function() {
		
		//날짜 관련 처리
		var date = new Date();
		var newday = date.toISOString().substring(0, 10);
		$('#sho_date').attr('value', newday);
		
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
		
		//조회수 관련 처리
		
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
			$('#sho_fileurl').attr('value', data);
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
				alert(data.result);
				alert(data.GoodBad);
				$("#sho_good"+e).attr('disabled', true);
				$("#sho_bad"+e).attr('disabled', true);
				$("#btn_ajaxGood"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				$("#sho_bad"+e).hide();
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
				alert(data.result);
				alert(data.GoodBad);
				$("#sho_bad"+e).attr('disabled', true);
				$("#sho_good"+e).attr('disabled', true);
				$("#btn_ajaxBad"+e).css({ background: "#87CEEB", color: "#FCFBF4"});
				$("#sho_good"+e).hide();
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
		var goodbad = $("#sho_good"+e).attr('disabled', false) ? 'G' : 'N';
		alert("goodbad: " + goodbad);
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
				alert(data.GBresult);
				alert(data.Comresult);
				alert(data.GoodBad);
				$("#sho_bad"+e).attr('disabled', true);
				$("#sho_good"+e).attr('disabled', true);
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

function submitSH() {
	$("#s_homework_input").submit();
}
