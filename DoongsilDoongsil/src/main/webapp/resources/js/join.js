   // 아이디 유효성 검사
   $('input[name=sta_username]').focusout(function() {
      var userId = $('input[name=sta_username]').val();
      var ckid = /^[a-z0-9_-]{4,20}$/;
      if(!ckid.test(userId)) {
            $('#must-id').text("필수 입력 항목 입니다.");
        } else if(ckid.test(userId)) {
            $('#must-id').text("");
        }
   });

   // 비밀번호 유효성 검사
   $('input[name=sta_password]').focusout(function() {
      var userPw = $('input[name=sta_password]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
      if(!ckpw.test(userPw)) {
            $('#must-pw').text("필수 입력 항목 입니다.");
        } else if(ckpw.test(userPw)){
            $('#must-pw').text("");
        }
        if(!ckpw.test(userPw)){
            $('#must-pw').text("숫자와 영문자, 특수문자 조합으로 8~16 자리를 사용해야 합니다.");
        }
   });

   // 비밀번호 일치 확인
   $('input[name=password_chk]').focusout(function(){
      var userPw = $('input[name=sta_password]').val();
      var userPwCk = $('input[name=password_chk]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;

      if(!ckpw.test(userPwCk)) {
         $('#must-pw-ck').text("비밀번호가 일치 하지 않습니다.");
         } else if(userPw == userPwCk){
            $('#must-pw-ck').text("");
         }
   });

   // 이름 유효성 검사
   /*
   $('input[name=sta_name]').focusout(function() {
      var userName = $('input[name=sta_name]').val();
      var ckName = /^[가-힣a-zA-Z]{2,4}$/;

      if(!ckName.test(userName)) {
         $('#must-name').text("필수 입력 항목 입니다.");
      } else if(ckName.test(userName)){
         $('#must-name').text("");
      }
      */
     $('input[name=sta_name]').focusout(function() {
    	var name = $('input[name=sta_name]').val();
    	var nameChk = /^[가-힣]{2,15}$/;

    	if(name == ""){
    		$('#must-name').text("필수 입력 항목 입니다.");
        	return;
    	}
    	if(name.match(/[0-9]|[a-z]|[A-Z]/)) { 
    		$('#must-name').text("이름을 정확히 입력해주세요.");
        	return;
   	 	}
   		if(name.match(/([^가-힣\x20])/i)){
   			$('#must-name').text("이름을 정확히 입력해주세요.");
        	return;
    	}
    	if(nameChk.test(name)){
			$('#must-name').text("");
		}
   });

   // 이메일 유효성 검사 
   $('input[name=sta_email]').focusout(function() {
      var userEmail = $('input[name=sta_email]').val();
      var ckEmail = /^[a-z0-9_+.-]+@([a-z0-9]+\.)+[a-z0-9]{2,4}$/;

      if(userEmail == "") {
         $('#must-email').text("필수 입력 항목 입니다.");
      } 
      if(!ckEmail.test(userEmail)) {
		$('#must-email').text("이메일을 정확하게 입력해주세요.");
	  }
      if(ckEmail.test(userEmail)){
         $('#must-email').text("");
      }
   });
   
   // 전화번호 유효성 검사
    $('input[name=sta_phonenumber]').focusout(function(){
      var userPh = $('input[name=sta_phonenumber]').val();
      var ckph = /(\d{3}).*(\d{3}).*(\d{4})/;

	  if(userPh == "") {
         $('#must-ph-ck').text("필수 입력 항목입니다.");
	  }
      if(!ckph.test(userPh)) {
		 $('#must-ph-ck').text("전화번호를 정확하게 입력해주세요.");
      }
      if(ckph.test(userPh)){
         $('#must-ph-ck').text("");
      }
   });

// input 비어있으면 가입하기 버튼을 누를 수 없음
$('#sign-btn').hover(function() {
   var a = document.getElementsByTagName("input");

   for(var i = 0; i < 6; i++){
       if(a[i].value != ""){
         $('#sign-btn').css({"background-color": "#77B0BF", "color": "#fff7e3", "cursor":"pointer"});
       } else if(a[i].value == "") {
         $('#sign-btn').css({"background-color": "lightblue", "color": "gray"});
       }
   }
});

// 로그인 실패
$('input[name=id]').focusin(function(){
   var a = $('input[name=id]').val();

   if(a != ""){
      $('.sign-id-check').css('display', 'hidden');
   }
});