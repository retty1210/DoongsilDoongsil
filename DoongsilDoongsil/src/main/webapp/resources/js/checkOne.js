window.addEventListener("load", function() {
	
	$('input[type="checkbox"][name="sta_usertype"]').click(function(){
	 
	 if($(this).prop('checked')){
	 
	    $('input[type="checkbox"][name="sta_usertype"]').prop('checked',false);
	 
	    $(this).prop('checked',true);
	 
	    }
	  
	   });
   });