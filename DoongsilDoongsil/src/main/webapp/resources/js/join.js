   // 아이디 유효성 검사
   $('input[name=id]').focusout(function() {
      var userId = $('input[name=id]').val();
      var ckid = /^[a-z0-9_-]{4,20}$/;
      if(!ckid.test(userId)) {
            $('#must-id').text("필수 입력 항목 입니다.");
        } else if(ckid.test(userId)) {
            $('#must-id').text("");
        }
   });

   // 비밀번호 유효성 검사
   $('input[name=password]').focusout(function() {
      var userPw = $('input[name=password]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
      if(!ckpw.test(userPw)) {
            $('#must-pw').text("필수 입력 항목 입니다.");
        } else if(ckpw.test(userPw)){
            $('#must-pw').text("");
        }
   });

   // 비밀번호 일치 확인
   $('input[name=password_chk]').focusout(function(){
      var userPw = $('input[name=password]').val();
      var userPwCk = $('input[name=password_chk]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;

      if(!ckpw.test(userPwCk)) {
         $('#must-pw-ck').text("비밀번호가 일치 하지 않습니다.");
         } else if(userPw == userPwCk){
            $('#must-pw-ck').text("");
         }
   });

   // 이름 유효성 검사
   $('input[name=username]').focusout(function() {
      var userName = $('input[name=username]').val();
      var ckName = /^[가-힣a-zA-Z]{2,4}$/;

      if(!ckName.test(userName)) {
         $('#must-name').text("필수 입력 항목 입니다.");
      } else if(ckName.test(userName)){
         $('#must-name').text("");
      }
   });

   // 이메일 유효성 검사 
   $('input[name=email]').focusout(function() {
      var userEmail = $('input[name=email]').val();
      var ckEmail = /^[a-z0-9_+.-]+@([a-z0-9]+\.)+[a-z0-9]{2,4}$/;

      if(!ckEmail.test(userEmail)) {
         $('#must-email').text("필수 입력 항목 입니다.");
      } else if(ckEmail.test(userEmail)){
         $('#must-email').text("");
      }
   });

// input 비어있으면 가입하기 버튼을 누를 수 없음
$('#sign-btn').hover(function() {
   var a = document.getElementsByTagName("input");

   for(var i=0; i < 6; i++){
       if(a[i].value != ""){
         $('#sign-btn').css({"background-color": "gray", "color": "white"});
       } else if(a[i].value == "") {
         $('#sign-btn').css({"background-color": "white", "color": "gray"});
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