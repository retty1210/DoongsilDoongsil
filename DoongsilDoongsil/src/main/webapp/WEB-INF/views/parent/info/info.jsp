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
	function MyInfoUpdate(href){
		window.open('/popuppassword?type="P"','','width=400,height=150');
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
					<img src="${reqeust.getServletContext().getRealPath() }/stc/img/default.png" alt="profilePhoto" class="myInfo_photo"/>
				</div>
				<table class="myInfo_text_tb">
					<tr class="myInfo_text_tr">
						<td class="myInfo_td"><strong>${sessionScope.account.sta_name } 의 학부모</strong></td>
					</tr>
				</table>
			</div>
			<div class="subMenu_box">
				<ul>
					<li><a href="javascript:void(0);" onclick="MyInfoUpdate(this);"><strong>내 정보 수정</strong></a></li>
				</ul>
			</div>
		</div>
		<div class="subMainBox">
			<div class="parentBoardList_box">
				<div>
					<h3>나의 게시글</h3>
				</div>
				<div class="parentList_all_box">
					<a href="/paboardList" class="parentList_all">>전체보기</a>
				</div>
				<table class="parentBoardList_tb">
					<tr>
						<th>No</th>
						<th width="70%">Title</th>
						<th>WriterDate</th>
						<th>viewCnt</th>
					</tr>
					<c:choose>
					<c:when test="${paboardListError == null }">
					<c:forEach var="paboard" items="${paboardList }">
						<tr>
							<td>${paboard.pab_id }</td>
							<td><a href="/paboardView?pab_id=${paboard.pab_id }"><span style="opacity:0.54;"> [ ${list.pac_category} ] </span>${paboard.pab_title }</a></td>
							<td>${paboard.pab_date }</td>
							<td>${paboard.pab_Count }</td>
						</tr>
					</c:forEach>
					</c:when>
					<c:when test="${paboardListError != null }">
						<tr>
							<td colspan="4">
								<span style="opacity:0.54;">${paboardListError }</span>
							</td>
						</tr>
					</c:when>
					</c:choose>
				</table>
			</div>
			<div class="schoolEvent_list_P_box">
				<h5>학사일정</h5>
				<ul>
					<c:choose>
						<c:when test="${schoolCalError eq null}">
							<c:forEach var="cal" items="${schoolCal }">
								<li>${cal.cal_title }</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li>${schoolCalError }</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
</body>
</html>