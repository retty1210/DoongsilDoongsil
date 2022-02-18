
$(document).ready(function(){ 
      $("#btn").click(function(){
            if($("#permit").val() == 0) { 
               alert("열람대상을 선택하세요."); 
               return false; 
            }
            if($("#title").val().length==0){ 
               alert("제목을 입력하세요."); 
               $("#title").focus(); 
               return false; 
            }
            if($("#contents").val().length==0){ 
               alert("내용을 작성해주세요."); 
               $("#contents").focus(); 
               return false; 
            }
            
      });      
});

