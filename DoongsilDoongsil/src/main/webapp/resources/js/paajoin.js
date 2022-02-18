   // 아이디 유효성 검사
   $('input[name=paa_username]').focusout(function() {
      var userId = $('input[name=paa_username]').val();
      var ckid = /^[a-z0-9_-]{4,20}$/;
      if(!ckid.test(userId)) {
            $('#must-id').text("필수 입력 항목 입니다.");
        } else if(ckid.test(userId)) {
            $('#must-id').text("");
        }
   });

   // 비밀번호 유효성 검사
   $('input[name=paa_password]').focusout(function() {
      var userPw = $('input[name=paa_password]').val();
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
   $('input[name=paa_password_chk]').focusout(function(){
      var userPw = $('input[name=paa_password]').val();
      var userPwCk = $('input[name=paa_password_chk]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;

      if(!ckpw.test(userPwCk)) {
         $('#must-pw-ck').text("비밀번호가 일치 하지 않습니다.");
         } else if(userPw == userPwCk){
            $('#must-pw-ck').text("");
         }
   });
   
   // 전화번호 유효성 검사
    $('input[name=paa_phonenumber]').focusout(function(){
      var userPh = $('input[name=paa_phonenumber]').val();
      var ckph = /(\d{3}).*(\d{3}).*(\d{4})/;

      if(!ckph.test(userPh)) {
         $('#must-ph-ck').text("필수 입력 항목입니다.");
         } else if(ckph.test(userPh)){
            $('#must-ph-ck').text("");
         }
   });
   

// input 비어있으면 가입하기 버튼을 누를 수 없음
$('#sign-btn').hover(function() {
   var a = document.getElementsByTagName("input");

   for(var i = 0; i < 6; i++){
       if(a[i].value != ""){
         $('#sign-btn').css({"background-color": "gray", "color": "white"});
       } else if(a[i].value == "") {
         $('#sign-btn').css({"background-color": "white", "color": "gray"});
       }
   }
});

// 로그인 실패
$('input[name=paa_username]').focusin(function(){
   var a = $('input[name=paa_username]').val();

   if(a != ""){
      $('.sign-id-check').css('display', 'hidden');
   }
});