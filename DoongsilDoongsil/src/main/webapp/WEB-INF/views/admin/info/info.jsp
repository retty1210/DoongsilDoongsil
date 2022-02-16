<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		window.open('/popuppassword?type=${sessionScope.account.sta_usertype}','','width=400,height=150');
	}
	function studentUpdate(href,id){
		
		window.open('/infoUpdate?id='+id,'','width=500,height=700');
		
	}
	
</script>
</head>
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
					<img src="${sessionScope.account.sta_profile }" alt="profilePhoto" class="myInfo_photo"/>
				</div>
				<table class="myInfo_text_tb">
					<tr class="myInfo_text_tr">
							<td class="myInfo_td">${sessionScope.account.sta_name }</td>
							<td class="myInfo_td">${sessionScope.account.sta_grade }학년 ${sessionScope.account.sta_class }반</td>
							<td class="myInfo_td">
								<c:if test="${sessionScope.account.sta_usertype eq 'T'}">
									교사
								</c:if>
							</td>
					</tr>
				</table>
			</div>
			<div class="subMenu_box">
				<ul>
					<li><a href="javascript:void(0);" onclick="studentDel(this);">학생관리</a></li>
					<li><a href="javascript:void(0);" onclick="MyInfoUpdate(this);">내 정보 수정</a></li>
				</ul>
			</div>
		</div>
		<div class="subMainBox">
			<div class="studentList_box">
				<div class="parentList_all_box">
					<a href="javascript:void(0)" onclick="studentDel(this);" class="parentList_all">>전체보기</a>
				</div>
				<table border="1" class="studentList_tb">
					<tr class="studentList_tr">
						<th>No</th>
						<th width="60%">Name</th>
						<th>Birthday</th>
					</tr>
					<c:forEach var="studentList" items="${sessionScope.infoStudentList}">
						<tr>
							<td>${studentList.sta_id }</td>
							<td><a href="javascript:void(0);" onclick="studentUpdate(this,${studentList.sta_id});">${studentList.sta_name }</a></td>
							<td>${studentList.sta_birthday }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="noticeList_box">
				<div class="noticeList_all_box">
					<a href="/notice/noticeList" class="noticeList_all">>전체보기</a>
				</div>
				<table border="1" class="noticeList_tb">
					<tr class="noticeList_tr">
						<th>No</th>
						<th width="70%">Title</th>
						<th>WriterDate</th>
					</tr>
					<c:forEach var="myNoticeList" items="${sessionScope.myNoticeList }">
						<c:choose>
							<c:when test="${myNoticeList != null }">
								<tr>
									<td>${myNoticeList.not_id }</td>
									<td><a href="/notice/noticeView?not_id=${myNoticeList.not_id }">${myNoticeList.not_title }</a></td>
									<td>${myNoticeList.not_writedate }</td>
								</tr>
							</c:when>
							<c:when test="${myNoticeList == null }">
								<th colspan="3">${myNoticeListError }</th>
							</c:when>
						</c:choose>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>