<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${request.getServletContext().getRealPath() }/stc/js/popUp.js"></script>
<link type="text/css" href="/stc/css/mainPopUp.css" rel="stylesheet">
</head>
<body>
	<div class="popup-area">
		<h2 class="popup-header">둥실팝업존</h2>
		<div class="popup_list_area">
			<div class="popup_list">
				<div class="popup_list_box">
					<div class="ed-icons">교육청</div>
					<a href="https://www.sen.go.kr/" target='_blank'>서울시교육청</a>
				</div>
				<div class="popup_list_box">
					<div class="ed-icons">교육청</div>
					<a href="https://hcs.eduro.go.kr/#/loginHome" target='_blank'>건강상태자가진단</a></div>
				<div class="popup_list_box">
					<div class="ed-icons">교육청</div>
					<a href="https://www.sen.go.kr/schoolwithyou/" target='_blank'>스쿨위드유</a></div>
				<div class="popup_list_box">
					<div class="ed-icons">교육청</div>
					<a href="https://www.simpan.go.kr/nsph/index.do" target='_blank'>온라인행정심판</a></div>
			</div>
		</div>
	</div>
	<div class="ck_box">
		<div class="first-box">
				<input type="checkbox" id="today_box">
				<label for="today_box">오늘 그만보기</label>
			</div>
			<div class="second-box">
				<button type="button" id="close">닫기</button>
			</div>
		</div>
</body>
</html>