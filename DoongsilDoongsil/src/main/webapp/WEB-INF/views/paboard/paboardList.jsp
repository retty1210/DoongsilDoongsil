<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
  <style>
  a{
  	text-decoration : none;
  	color: black;
  }
  table{
 	border-collapse: collapse;
 	width: 1200px;    
 	margin-top : 20px;
 	text-align: center;
  }
  td, th{
  	border : 1px solid black;
  	height: 50px;
  }
  th{
  	font-size : 17px;
  }
  thead{
  	font-weight: 700;
  }
  .table_wrap{
  	margin : 50px 0 0 50px;
  }
  .bno_width{
  	width: 12%;
  }
  .writer_width{
  	width: 20%;
  }
  .regdate_width{
  	width: 15%;
  }
  .updatedate_width{
  	width: 15%;
  }
  .count_width{
  	width: 10%;
  }
  .top_btn{
  	font-size: 20px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
  }
  </style>
  <script type="text/javascript">
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="/paboardList?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<h1>학부모게시판</h1>
		
	
		<div style="float: right;">
			<select id="cntPerPage" name="sel" onchange="selChange();">
				<option value="5"
					<c:choose>
					<c:when test="${paging.cntPerPage == 5}">selected</c:when>
					<c:otherwise>disabled</c:otherwise>
					</c:choose>>5줄 보기</option>
				<option value="10"
					<c:choose>
					<c:when test="${paging.cntPerPage == 10}">selected</c:when>
					<c:otherwise>disabled</c:otherwise>
					</c:choose>>10줄 보기</option>
				<option value="15"
					<c:choose>
					<c:when test="${paging.cntPerPage == 15}">selected</c:when>
					<c:otherwise>disabled</c:otherwise>
					</c:choose>>15줄 보기</option>
				<option value="20"
					<c:choose>
					<c:when test="${paging.cntPerPage == 20}">selected</c:when>
					<c:otherwise>disabled</c:otherwise>
					</c:choose>>20줄 보기</option>
			</select>
		</div> <!-- 옵션선택 끝 -->
		<div class="table_wrap">
			<button type="button" class="btn btn-primary" onclick="location.href='/paboardWrite'">작성하기</button>
			<table>
				<thead>
					<tr>
						<th class="bno_width">번호</th>
						<th class="title_width">제목</th>
						<th class="writer_width">작성자</th>
						<th class="regdate_width">작성일</th>
						<th class="count_width">조회수</th>
					</tr>
				</thead>
		 		<c:forEach items="${list}" var="list">
		            <tr>
		                <td><c:out value="${list.pab_id}"/></td>
		               	<td><a href="/paboardView?pab_id=${list.pab_id}" class="titleLink"><span style="opacity:0.54;"> [ ${list.pac_category} ] </span><c:out value="${list.pab_title}" /></a></td>
		                <td><c:out value="${list.paa_UserName}"/></td>
						<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.pab_date}"/></td>
						<td><c:out value="${list.pab_Count}"/></td>
		            </tr>
		        </c:forEach>
			</table>
			<div style="display: block; text-align: center;">		
				<c:if test="${paging.startPage != 1 }">
					<a href="/paboardList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
				</c:if>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<a href="/paboardList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.endPage != paging.lastPage}">
					<a href="/paboardList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
				</c:if>
			</div>
		</div>
	</main>

	<footer>
		<div>
			<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false" />
		</div>
	</footer>
</body>
</html>