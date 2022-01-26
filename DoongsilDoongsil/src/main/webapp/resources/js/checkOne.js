window.addEventListener("load", function() {
	
	$('input[type="checkbox"][name="check1"]').click(function(){
	 
	 if($(this).prop('checked')){
	 
	    $('input[type="checkbox"][name="check1"]').prop('checked',false);
	 
	    $(this).prop('checked',true);
	 
	    }
	  
	   });
   });