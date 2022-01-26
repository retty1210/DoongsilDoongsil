<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false"/>
<link href="/stc/css/info.css" rel="stylesheet" type="text/css"/>
</head>
<script type="text/javascript">
	function MyInfoUpdate(href){
		window.open('/infoUpdate','','width=500,height=700');
	}
</script>
<body>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	<div class="mainbodybox">
		<div>
			<div class="myInfoBox">
				<a href="javascript:void(0);" onclick="MyInfoUpdate(this);" class="myInfo_setting">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear-fill" viewBox="0 0 16 16">
				 	 	<path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"/>
					</svg>
				</a>
				<div class="myInfo_photo_box">
					<img src="#" alt="profilePhoto" class="myInfo_photo"/>
				</div>
				<table class="myInfo_text_tb">
					<tr class="myInfo_text_tr">
						<td class="myInfo_td"><strong>이종훈</strong></td>
						<td class="myInfo_td"><strong>3학년 2반</strong></td>
						<td class="myInfo_td"><strong>학생</strong></td>
					</tr>
				</table>
			</div>
			<div class="subMenu_box">
				<ul>
					<li><a href="javascript:void(0);" onclick="MyInfoUpdate(this);">내 정보 수정</a></li>
				</ul>
			</div>
		</div>
		<div>
		<div class="subMainBox">
			<div class="homework_list_box">
				<h5>채점 안된 숙제목록</h5>
				<ul>
					<li></li>
				</ul>
			</div>
			<div class="schoolEvent_list_S_box">
				<h5>학사일정</h5>
				<ul>
					<li></li>
				</ul>
			</div>
		</div>
			<div class="calendar_box">
				<h5>캘린더</h5>
					<!-- 캘린더 API 불러오기. -->
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>