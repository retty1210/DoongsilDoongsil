$(function() {
	var replaceChar = /[~@\#$%^&*\()\-=+_'\;<>\/\`:\"\\,\[\]|{}A-Za-z0-9]/gi;
	var replaceNotFullKoreans = /[ㄱ-ㅎㅏ-ㅣ]/gi;
	
	$("textarea[name=type3contentArea]").keyup(function(e) {
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
	
	$("input[name=uploadFile]").change(function() {
		console.log("file 변경: " + $(this).val());
		var imgDay = $(this).attr('id').substring(13,21);
		console.log("imgDay: " + imgDay);
		setImageFromFile(this, imgDay);
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
            $("#type3imgPreview" + expression).attr('src', e.target.result);
			//$("#type3imgLink" + expression).val(e.target.readAsDataURL);
        }
        reader.readAsDataURL(input.files[0]);
		//$("#type3imgLink" + expression).val(reader.readAsDataURL(input.files[0]));
    }
}

function type3imgup(e) {
	$("#type3imgInput"+e).click();
}

function type3Sunny(e) {
	var name = e + "";
	$("div[name=weatherIcon"+name+"]").empty();
	$("#type3_weather_sunny"+name).append(
		'<img id="sunny_fill" src="/stc/img/brightness-high-fill.svg" class="ic20 filter-brlred" />'
	);
	$("#type3_weather_cloudy"+name).append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy"+name).append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	$("#type3_weather_snowy"+name).append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue"+name).val('sunny');
	console.log($("#type3weatherValue"+name).val());
}

function type3Cloudy(e) {
	var name = e + "";
	$("div[name=weatherIcon"+name+"]").empty();
	$("#type3_weather_sunny"+name).append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy"+name).append(
		'<img id="cloudy_fill" src="/stc/img/cloudy-fill.svg" class="ic20 filter-grystone" />'
	);
	$("#type3_weather_rainy"+name).append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	$("#type3_weather_snowy"+name).append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue"+name).val('cloudy');
	console.log($("#type3weatherValue"+name).val());
}

function type3Rainy(e) {
	$("div[name=weatherIcon"+e+"]").empty();
	$("#type3_weather_sunny"+e).append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy"+e).append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy"+e).append(
		'<img id="rainy_fill" src="/stc/img/cloud-rain-fill.svg" class="ic20 filter-lsrblue" />'
	);
	$("#type3_weather_snowy"+e).append(
		'<img id="snowy_outline" src="/stc/img/snow.svg" class="ic20" />'
	);
	$("#type3weatherValue"+e).val('rainy');
	console.log($("#type3weatherValue"+e).val());
}

function type3Snowy(e) {
	$("div[name=weatherIcon"+e+"]").empty();
	$("#type3_weather_sunny"+e).append(
		'<img id="sunny_outline" src="/stc/img/brightness-high.svg" class="ic20" />'
	);
	$("#type3_weather_cloudy"+e).append(
		'<img id="cloudy_outline" src="/stc/img/cloudy.svg" class="ic20" />'
	);
	$("#type3_weather_rainy"+e).append(
		'<img id="rainy_outline" src="/stc/img/cloud-rain.svg" class="ic20" />'
	);
	//$("#type3_weather_snowy").attr('background-color', '#0E9BD1');
	$("#type3_weather_snowy"+e).append(
		'<img id="snowy_fill" src="/stc/img/snow2.svg" class="ic20 filter-strblue" />'
	);
	$("#type3weatherValue"+e).val('snowy');
	console.log($("#type3weatherValue"+e).val());
}

function submitType3Student(e) {
	console.log("입력값: " + e);
	var img = $("#type3imgInput"+e).val();
	var cont = $("#type3contentArea"+e).val();
	var weath = $("#type3weatherValue"+e).val();
	console.log("img: " + img + ", cont: " + cont + ", weath: " + weath);
	if(isThisEmpty(img) != true && isThisEmpty(cont) != true && isThisEmpty(weath) != true) {
		$("#type3FinalContent"+e).val(weath + "||" + cont);
		$("#type3diarySubmitButton"+e).click();
	} else {
		alert("날씨, 그림, 글을 다 썼는지 확인해주세요!");
	}
	
}

function type3comment(elem) {
	var id = $(elem).attr('id').substring(21,33);
	console.log("id: " + id);
	var comment = $("#type3comment" + id).val();
	console.log("내용: " + comment);
	if(isThisEmpty(comment)) {
		alert("내용을 입력해주세요.");
		return false;
	} else {
		var shoid = $("#type3id"+id).val();
		console.log("SHO_ID: " + shoid);
		$.ajax({
			url: '/type3comment',
			type: 'POST',
			cache: false,
			data: {
				sho_id: shoid,
				sho_comment: comment
			},
			success: function(data) {
				alert(data);
				$("#type3comment"+id).attr('readonly', true);
				$("#type3SubmitBtnArea"+id).hide();
			}
		});
	}
}

function isThisEmpty(e) {
	if(e == "" || typeof e == "undefined" || e == null || e == 0 || e == NaN) {
		return true;
	} else {
		return false;
	}
}