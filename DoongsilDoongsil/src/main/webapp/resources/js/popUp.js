function ch_box() {
	var ck = document.getElementById('today_box');
	if(ck.checked == true) {
		console.log('ss');
	} else {
		console.log('ff');
	}
}
	
    // 쿠키 가져오기
    var getCookie = function (cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i=0; i<ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1);
            if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
        }
        return "";
    }

    // 24시간 기준 쿠키 설정하기  
    var setCookie = function (cname, cvalue, exdays) {
        var todayDate = new Date();
        todayDate.setTime(todayDate.getTime() + (exdays*24*60*60*1000));    
        var expires = "expires=" + todayDate.toUTCString(); // UTC기준의 시간에 exdays인자로 받은 값에 의해서 cookie가 설정 됩니다.
        document.cookie = cname + "=" + cvalue + "; " + expires;
    }

    $(document).ready(function(){
		let href="/mainPop";
        var cookiedata = document.cookie;
        if(cookiedata.indexOf("close=Y")>0){
			 window.close();
        }
        $("#close").click(function(){
            window.close();
        });

		$('#today_box').on('click',function(){
	        if($('#today_box')[0].checked == true){
	            setCookie("close","Y",1);   //기간( ex. 1은 하루, 7은 일주일)
	        	window.close();
	       }
		});
    });