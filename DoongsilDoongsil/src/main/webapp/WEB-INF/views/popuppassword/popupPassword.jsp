<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false"/>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		function gotoinfo(){
			let password = $(".passwordInfo")[0].value;
		
			if(password == '${sessionScope.account.sta_password}'){
					window.close();
					window.open('/infoUpdate?id=${sessionScope.account.sta_id}','','width=500,height=700');
			}else{
					alert('패스워드가 일치하지 않습니다.');
			}
		}
		function outinfo(){
			window.close();
		}
	</script>
</head>
<body>
	<h6>패스워드를 입력해주세요 !</h6>
	
		<div>
			<input type="password" name="goToInfo" class="passwordInfo"/>
		</div>
		<div>
			<button type="button" class="gotoinfo" onclick="gotoinfo();">확인</button>
			<button type="button" class="outinfo" onclick="outinfo();">취소</button>
		</div>
	
</body>
</html>