<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
화면 위쪽의 네비게이션 바 페이지입니다.
html태그 필요없이 바로 div 가져다가 복사&붙여넣기 하시면 됩니다.
url은 경로로 인해 생기는 문제를 방지하기 위해 c:url을 사용하여 작성해 주세요.
 -->
 <header class="p-3 mb-3 border-bottom" style="background-color:#77B0BF;">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
          <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-clouds" viewBox="0 0 16 16">
			  <path d="M16 7.5a2.5 2.5 0 0 1-1.456 2.272 3.513 3.513 0 0 0-.65-.824 1.5 1.5 0 0 0-.789-2.896.5.5 0 0 1-.627-.421 3 3 0 0 0-5.22-1.625 5.587 5.587 0 0 0-1.276.088 4.002 4.002 0 0 1 7.392.91A2.5 2.5 0 0 1 16 7.5z"/>
			  <path d="M7 5a4.5 4.5 0 0 1 4.473 4h.027a2.5 2.5 0 0 1 0 5H3a3 3 0 0 1-.247-5.99A4.502 4.502 0 0 1 7 5zm3.5 4.5a3.5 3.5 0 0 0-6.89-.873.5.5 0 0 1-.51.375A2 2 0 1 0 3 13h8.5a1.5 1.5 0 1 0-.376-2.953.5.5 0 0 1-.624-.492V9.5z"/>
		</svg>
		<h4>둥실둥실</h4>
        </a>
        
        <c:url var="noticeURL" value="/notice/noticeList" />
        <c:url var="homeworkURL" value="/homework" />
        <c:url var="infoURL" value="/info">
        </c:url>

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="${noticeURL }" class="nav-link px-2 link-secondary">공지사항</a></li>
          <li><a href="${homeworkURL }" class="nav-link px-2 link-dark">학급게시판</a></li>
          <li><a href="/" class="nav-link px-2 link-dark">학부모 소통</a></li>
          <li><a href="${infoURL }" class="nav-link px-2 link-dark">내 정보</a></li>
        </ul>

        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
          <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
        </form>

        <div class="dropdown text-end">
	          <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
       			<c:if test="${sessionScope.logined }">
       			<c:choose>
       				<c:when test="${sessionScope.account.sta_profile ne null}">
	            		<img src="${sessionScope.account.sta_profile}" alt="mdo" width="32" height="32" class="rounded-circle">
	            	</c:when>
	            	<c:otherwise>
	            		<img src="${reqeust.getServletContext().getRealPath()}/stc/up/default.png" alt="mdo" width="32" height="32" class="rounded-circle">
	            	</c:otherwise>
            	</c:choose>
          		</c:if>
	          </a>
          <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1">
          	<c:choose>
          		<c:when test="${sessionScope.logined }">
		            <li><a class="dropdown-item" href="${infoURL }">내 정보</a></li>
		            <li><hr class="dropdown-divider"></li>
		            <li><a class="dropdown-item" href="/logout">로그아웃</a></li>
	            </c:when>
	            <c:otherwise>
	            	 <li><a class="dropdown-item" href="/join">회원가입</a></li>
		            <li><hr class="dropdown-divider"></li>
		            <li><a class="dropdown-item" href="/login">로그인</a></li>
	            </c:otherwise>
	        </c:choose>
          </ul>
        </div>
      </div>
    </div>
  </header>