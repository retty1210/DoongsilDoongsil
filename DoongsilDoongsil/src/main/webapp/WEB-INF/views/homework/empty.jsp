<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EMPTY</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
<c:url var="hwr_css_url" value="/stc/css/homework.css" />
<link href="${hwr_css_url}" rel="stylesheet" type="text/css" />
</head>
<body>
EMPTY
<div>
	<button type="button" onclick="window.open('/homework/write')">새로운 숙제 올리기</button>
</div>

<div class="container">
	<div class="row flex">
		<div class="row tmg10"><button type="button" class="btn btn-sbl">하늘색버튼</button></div>
		<div class="row tmg10"><button type="button" class="btn btn-wht">하얀색버튼</button></div>
		<div class="row tmg10"><button type="button" class="btn btn-rwh">흰+로얄블루색버튼</button></div>
		<div class="row tmg10"><button type="button" class="btn btn-drt">dirty blue 버튼</button></div>
		<div class="row tmg10"><button type="button" class="btn btn-ryl">royal blue 버튼</button></div>
		<div class="row tmg10"><button type="button" class="btn btn-lsr">laser blue버튼</button></div>
	</div>
</div>
</body>
</html>