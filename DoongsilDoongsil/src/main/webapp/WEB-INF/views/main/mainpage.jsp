<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<script src="/stc/js/cal.js"></script>
<link href="/stc/css/doongmain.css" rel="stylesheet" type="text/css" />
<link href="/stc/css/info.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
  	/* mainpage에서는 mainbodybox에 걸려있는 flex 불필요 제거함 */
	.mainbodybox {
		display : inline-block;
	}

</style>
<script type="text/javascript">
	function MyInfoUpdate(href){
		window.open('/infoUpdate?id=${sessionScope.accountNumber}','','width=500,height=700');
	}
	
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<div class="all-area">
		<div class="myInfo-area mainbodybox">
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
						<td class="myInfo_td" id="T_check">
							<c:if test="${sessionScope.account.sta_usertype eq 'T'}">
								교사
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			 
			 
			 <div class = "today-box">
			 	<h3>학사일정</h3>
			 	<ul class= "academic-list"></ul>
			 </div>
		</div>
		<div class="main-board-area">
			<div class="main-first-top">
				<div class="notice-area">
				<table class="notice-table, notice-only-table">
					<span><a href="/notice/noticeList?page=1" class="more-list-text">+ 더보기</a></span>
					<th class="notice-table, th-text-position">공지사항</th>
					<c:forEach var="notice" items="${noticeList}">
						<tr>
							<td class="notice-table">
								<span>
									<img src="https://img.icons8.com/ultraviolet/50/000000/airplane-mode-on.png" class="class-board-icon" />
								</span> 
								<span>
									<a href="/notice/noticeView?not_id=${notice.not_id }" class="nh-list-title">${notice.not_title }</a>
								</span>
							</td>
						</tr>
					</c:forEach>
					
				</table>
				</div>
				
				<div class="classBoard-area">
					<table class="classBoard-table, classBoard-only-table">
					<span><a href="/homework" class="more-list-text">+ 더보기</a></span>
					<th class="classBoard-table, th-text-position">학급게시판</th>
					<c:forEach var="homework" items="${homeworkList}">
						<tr>
							<td class="classBoard-table">
								<span><img src="https://img.icons8.com/dusk/50/000000/filled-circle.png" class="class-board-icon"/></span>
								<span>
									<a href="/homework/detail?tho_id=${homework.tho_id}" class="nh-list-title">
										${homework.tho_title }
									</a>
								</span>
							</td>
						</tr>
					</c:forEach>
					</table>
				</div>
			</div>
			
			<form action="/mainpage" method="post" name="hiddenForm">
				<input type="hidden" name="cal_title" value="${dto.getCal_title}" />
				<input type="hidden" name="cal_start"/>
				<input type="hidden" name="cal_end"/>
				
			</form>
			<div class="main-second-bottom">
				<div class="calendar-board">
					<div class="calendar-area">
						<jsp:include page="/WEB-INF/views/module/calendar.jsp" flush="false" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
	</footer>
</body>
</html>