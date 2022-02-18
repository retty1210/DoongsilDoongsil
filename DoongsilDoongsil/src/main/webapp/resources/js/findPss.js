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
   $('input[name=confirmpwd]').focusout(function(){
      var userPw = $('input[name=sta_password]').val();
      var userPwCk = $('input[name=confirmpwd]').val();
      var ckpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;

      if(!ckpw.test(userPwCk)) {
         $('#must-pw-ck').text("비밀번호가 일치 하지 않습니다.");
         } else if(userPw == userPwCk){
            $('#must-pw-ck').text("");
         }
   });
   
   // 비밀번호 유효성 검사
   $('input[name=paa_password]').focusout(function() {
    var paaPw = $('input[name=paa_password]').val();
    var ckhpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
    if(!ckhpw.test(paaPw)) {
          $('#must-pw2').text("필수 입력 항목 입니다.");
      } else if(ckhpw.test(paaPw)){
          $('#must-pw2').text("");
      }
      if(!ckhpw.test(paaPw)){
          $('#must-pw2').text("숫자와 영문자, 특수문자 조합으로 8~16 자리를 사용해야 합니다.");
      }
 });

 // 비밀번호 일치 확인
 $('input[name=confirmpwd2]').focusout(function(){
    var paaPw = $('input[name=paa_password]').val();
    var paaPwCk = $('input[name=confirmpwd2]').val();
    var ckhpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;

    if(!ckhpw.test(paaPwCk)) {
       $('#must-pw-ckh2').text("비밀번호가 일치 하지 않습니다.");
       } else if(paaPw == paaPwCk){
          $('#must-pw-ckh2').text("");
       }
 });