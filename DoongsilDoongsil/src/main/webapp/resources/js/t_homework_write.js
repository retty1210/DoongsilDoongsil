$(document).ready(function() {
		//기본값 외의 입력창들 안 보이게 처리
		$("#t_hw_write_type2").attr('style', "display:none;");
		
		//deadline 기본적으로는 안 보이게 처리
		$("#tho_deadline").attr('style', "display:none;");
		$('#tho_deadline').attr('disabled', true);
		
		//날짜 관련 처리
		var date = new Date();
		var newday = date.toISOString().substring(0, 10);
		$('#tho_writedate').attr('value', newday);
		//document.getElementById('tho_writedate').value=newday;
		
		//input hidden 관련 버튼 action 처리
		$("#btn_up").click(function(e){
			e.preventDefault();
			$("#picFile").click();
		});
		
		//input file 개수 관련 처리
		$("#picFile").on("change", fileCheck);
});

//숙제타입이 바뀌면 input창이 바뀌는 함수
$(function(){
	$("#tho_homeworktype").change(function() {
			
			if($(this).val() == 1) {
				$("#t_hw_write_type1").attr('style', "display:;");
				$("#t_hw_write_type2").attr('style', "display:none;");
			} else if($(this).val() == 2) {
				$("#t_hw_write_type1").attr('style', "display:none;");
				$("#t_hw_write_type2").attr('style', "display:;");
			}
		});
});

//deadline관련
$(function() {
	$("#deadlineCheck").change(function() {
		if($("#deadlineCheck").is(":checked")) {
			$("#tho_deadline").attr('style', "display:;");
			$('#tho_deadline').attr('disabled', false);
			var date = new Date();
			var newday = date.toISOString().substring(0, 10);
			document.getElementById('tho_deadline').value=newday;
			document.getElementById('tho_deadline').min=newday;
			var maxday = new Date(date);
			maxday.setDate(date.getDate() + 7);
			document.getElementById('tho_deadline').max=maxday.toISOString().substring(0, 10);
		} else {
			$("#tho_deadline").attr('style', "display:none;");
			$('#tho_deadline').attr('disabled', true);
		}
	});
});

//여기부터 아래는 다 파일업로드 관련

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
			$('#tho_filelink').attr('value', data);
			$('#btn_up').attr('disabled', true);
			}
		},
		error: function() {
			alert("error");
		}
	});
}

function formUp() {
	$('#hw_write_form').submit();
}

//form submit
function registerAction(){
	alert("registerAction start" + content_files.length);
	var form = $("form")[0];        
	var formData = new FormData(form);
	/*
	var stringdata = JSON.stringify({
		tho_homeworktype:$('#tho_homeworktype').val(),
		tho_writedate:$('#tho_writedate').val(),
		tho_deadline:$('#tho_deadline').val(),
		tho_title:$('#tho_title').val(),
		tho_writer:$('#tho_writer').val(),
		tho_grade:$('#tho_grade').val(),
		tho_class:$('#tho_class').val(),
		tho_count:$('#tho_count').val(),
		tho_contents:$('#tho_contents').val()
		});
	*/
	for (var x = 0; x < content_files.length; x++) {
		alert("for문, " + x + "회째");
		// 삭제 안한것만 담아 준다. 
		if(!content_files[x].is_delete){
			formData.append("article_file", content_files[x]);
			alert("업로드파일: " + content_files[x]);
			//$('#tho_filelink').append(
			//	filename
			//);
		}
	}
	formData.append("tho_homeworktype",$('#tho_homeworktype').val());
	formData.append("tho_writedate",$('#tho_writedate').val());
	//formData.append("tho_deadline",$('#tho_deadline').val())
	formData.append("tho_title",('#tho_title').val());
	formData.append("tho_writer",$('#tho_writer').val());
	formData.append("tho_grade",$('#tho_grade').val());
	formData.append("tho_class",$('#tho_class').val());
	formData.append("tho_count",$('#tho_count').val());
	formData.append("tho_contents",$('#tho_contents').val());
	
	alert("formData append 끝<br>" + formData);
	//ajax 서버 업로드 로직
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "/file-upload",
		data : formData,
		processData: false,
		contentType: false,
		success: function (data) {
			if(JSON.parse(data)['result'] == "OK"){
				alert("파일업로드 성공");
				
				alert("파일 경로 모음: " + filename);
			} else
				alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
				alert("파일 경로 모음: " + filename);
			},
		error: function (xhr, status, error) {
			alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
			return false;
		}
	});
	return false;
}

