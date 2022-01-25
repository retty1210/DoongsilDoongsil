<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false"/>
<link href="/stc/css/info.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
	function studentDel(href){
		window.open('/studentDel','','width=500,height=700');

	}
	function MyInfoUpdate(href){
		window.open('/infoUpdate','','width=500,height=700');
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	<div class="mainbodybox">
		<div>
			<div class="myInfoBox">
				<a href="#" class="myInfo_setting">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear-fill" viewBox="0 0 16 16">
				 	 	<path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"/>
					</svg>
				</a>
				<div class="myInfo_photo_box">
					<img src="#" alt="profilePhoto" class="myInfo_photo"/>
				</div>
				<table class="myInfo_text_tb">
					<tr class="myInfo_text_tr">
						<td class="myInfo_td">이종훈</td>
						<td class="myInfo_td">3학년 2반</td>
						<td class="myInfo_td">교사</td>
					</tr>
				</table>
			</div>
			<div class="subMenu_box">
				<ul>
					<li><a href="javascript:void(0);" onclick="studentDel(this)">학생관리</a></li>
					<li><a href="javascript:void(0);" onclick="MyInfoUpdate(this);">내 정보 수정</a></li>
				</ul>
			</div>
		</div>
		<div class="subMainBox">
			<div class="studentList_box">
				<div class="parentList_all_box">
					<a href="#" class="parentList_all">>전체보기</a>
				</div>
				<table border="1" class="studentList_tb">
					<tr class="studentList_tr">
						<th>No</th>
						<th width="60%">Name</th>
						<th>Birthday</th>
					</tr>
					<tr>
						<td>1</td>
						<td><a href="#">이종훈</a></td>
						<td>1994.03.11</td>
					</tr>
				</table>
			</div>
			<div class="noticeList_box">
				<div class="noticeList_all_box">
					<a href="#" class="noticeList_all">>전체보기</a>
				</div>
				<table border="1" class="noticeList_tb">
					<tr class="noticeList_tr">
						<th>No</th>
						<th width="70%">Title</th>
						<th>WriterDate</th>
					</tr>
					<tr>
						<td>1</td>
						<td>공지사항 입니다.</td>
						<td>2022.01.14</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>