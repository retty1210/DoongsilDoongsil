$(function() {
	var replaceChar = /[~@\#$%^&*\()\-=+_'\;<>\/\`:\"\\,\[\]|{}A-Za-z0-9]/gi;
	var replaceNotFullKoreans = /[ㄱ-ㅎㅏ-ㅣ]/gi;
	
	$("#type3contentArea").keyup(function(e) {
		var txt = $(this).val();
		if(txt.length > 0) {
			if(lengthCheck(txt, 100) == "false") {
				console.log("100 byte 미만");
				if(txt.match(replaceChar) || txt.match(replaceNotFullKoreans)) { //특수문자일때
					txt = txt.replace(replaceChar, "").replace(replaceNotFullKoreans, "");
					$(this).val(txt);
				} else { //글자수세기: 100byte로 하면 될거같음!
					console.log(e.which);
					if(e.which == 32) { //space일때
						var txtarr = txt.split('');
						if(txtarr[txtarr.length - 2] != '.' && txtarr[txtarr.length - 2] != '?' && txtarr[txtarr.length - 2] != '!') {
							if(!(txtarr[txtarr.length - 2] == ' ' && txtarr[txtarr.length - 1] == ' ')) {
								$(this).val(txt + " ");
							}
						}
					} else if (e.which == 16 || e.which == 190 || e.which == 191 || e.which == 49) { //shift키를 눌렀을 때/., ?, ! 일때
						var txtarr = txt.split('');
						if(txtarr[txtarr.length - 1] == '.' || txtarr[txtarr.length - 1] == '?' || txtarr[txtarr.length - 1] == '!') {
							$(this).val(txt + " ");
						}
					} 
				}
			} else {
				console.log("100byte 이상");
				$(this).val(lengthCheck(txt, 100));
			}
		}
	});
	
	$("#type3imgInput").change(function() {
		console.log("file 변경: " + $(this).val());
		setImageFromFile(this, '#type3imgPreview');
	});
});
/* 

space바를 한번 더 눌러야 하는 경우의 수
1. 한글이 끝난 후 space를 누를 때
2. .을 입력할 때
3. !을 입력할 때
4. ?을 입력할 때

*/

function lengthCheck(txt, maxByte) {
	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var txt2 = "";
	
	for(var i=0; i<txt.length; i++){
		one_char = txt.charAt(i);
		if(escape(one_char).length > 4){
		    rbyte += 2; //한글2Byte
		}else{
		    rbyte++; //영문 등 나머지 1Byte
		}
		
		if(rbyte <= maxByte){
		    rlen = i+1;  //문자열 갯수
		}
		console.log("바이트: " + rbyte);
	}
	
	if(rbyte > maxByte){
	    txt2 = txt.substr(0,rlen); //문자열 자르기
	    return txt2;
	}else{
	    return "false"; //안 잘라도 됨
	}

}

function setImageFromFile(input, expression) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(expression).attr('src', e.target.result);
			$("#type3imglink").val(e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function type3imgup() {
	$("#type3imgInput").click();
}

function type3Sunny() {
	$(".weatherIcon").empty();
	$("#type3_weather_sunny").append(
		'<img id="sunny_fill" src="/stc/img/brightness-high-fill.svg" class="ic20 filter-brlred" />'
	);
	$("#type3_weather_cloudy").append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy").append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	$("#type3_weather_snowy").append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue").val('sunny');
	console.log($("#type3weatherValue").val());
}

function type3Cloudy() {
	$(".weatherIcon").empty();
	$("#type3_weather_sunny").append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy").append(
		'<img id="cloudy_fill" src="/stc/img/cloudy-fill.svg" class="ic20 filter-grystone" />'
	);
	$("#type3_weather_rainy").append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	$("#type3_weather_snowy").append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue").val('cloudy');
	console.log($("#type3weatherValue").val());
}

function type3Rainy() {
	$(".weatherIcon").empty();
	$("#type3_weather_sunny").append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy").append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy").append(
		'<img id="rainy_fill" src="/stc/img/cloud-rain-fill.svg" class="ic20 filter-lsrblue" />'
	);
	$("#type3_weather_snowy").append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue").val('rainy');
	console.log($("#type3weatherValue").val());
}

function type3Snowy() {
	$(".weatherIcon").empty();
	$("#type3_weather_sunny").append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy").append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy").append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	//$("#type3_weather_snowy").attr('background-color', '#0E9BD1');
	$("#type3_weather_snowy").append(
		'<img id="snowy_fill" src="/stc/img/snow2.svg" class="ic20 filter-strblue" />'
	);
	$("#type3weatherValue").val('snowy');
	console.log($("#type3weatherValue").val());
}

function submitType3Student() {
	var img = $("#type3imglink").val();
	var cont = $("#type3contentArea").val();
	var weath = $("#type3weatherValue").val();
	if(isThisEmpty(img) != true && isThisEmpty(cont) != true && isThisEmpty(weath) != true) {
		$("#type3FinalContent").val(weath + "||" + cont);
		$("#type3diarySubmitButton").click();
	} else {
		alert("날씨, 그림, 글을 다 썼는지 확인해주세요!");
	}
	
}

function isThisEmpty(e) {
	if(e == "" || typeof e == "undefined" || e == null || e == 0 || e == NaN) {
		return true;
	} else {
		return false;
	}
}