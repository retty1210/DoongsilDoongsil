<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>둥실둥실 - 검색!</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false"/>
<style type="text/css" rel="stylesheet">
  .tableBox{
	display:flex;
	justify-content:center;
  }
  a{
  	text-decoration : none;
  	color: black;
  }
  table{
 	border-collapse: collapse;
 	width: 1200px;    
 	margin : 20px 0px;
 	text-align: center;
 	border:none;
 	
  }
  td, th{
  	height: 50px;
  }
  th{
  	font-size : 17px;
  }
  tr{
  	border-bottom : 1px solid black;
  }
  tr:not(:first-child):hover {
	background-color: #F0F5F6 !important;
  }
 
  tr:first-child{
  	border-bottom : 2px solid black;
  	font-weight: 700;
  	background-color:#CEF4FC;
  }
   .pagingAllBox{
  	display:flex;
  	justify-content: center;
  }
  .prevBox,.nextBox,.pagingBox{
  	border:1px solid rgba(0,0,0,0.4);
  	text-align: center;
  	display:flex;
  	justify-content: center;
  	border-radius:5px;
  }
  .prevBox,.nextBox{
  	display: none;
  }
  .pagingBox{
  	margin:0px 2.5px;
  }
  b,.linkNumber,.prev,.next{
  	display:inline-block;
  	width:50px;
  	height:50px;
  	position:relative;
  	top:12px;
  }
</style>
<script type="text/javascript">
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		if(${paging.nowPage == 1}){
			location.href="/search?search=${paging.searchText }&nowPage=${paging.nowPage}&cntPerPage="+sel;			
		}else{
			location.href="/search?search=${paging.searchText }&nowPage=1&cntPerPage="+sel;
		}
	}
	$(document).ready(function(){
		$("b").parent().css("backgroundColor","#59b1eb");		
	})
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	<div style=" width:auto;display:flex; justify-content:space-between; padding: 0 120px;">
		<h1> 검색 결과 </h1>
		<div style="float: right; margin-top:40px;">
			<select id="cntPerPage" name="sel" onchange="selChange();">
				<option value="5"
					<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
				<option value="10"
					<c:choose>
						<c:when test="${paging.cntPerPage == 10}">selected</c:when>
						<c:when test="${total < 10 }">disabled</c:when>
					</c:choose>>10줄 보기</option>
				<option value="15"
					<c:choose>
						<c:when test="${paging.cntPerPage == 15}">selected</c:when>
						<c:when test="${total < 15 }">disabled</c:when>
					</c:choose>>15줄 보기</option>
				<option value="20"
					<c:choose>
					<c:when test="${paging.cntPerPage == 20}">selected</c:when>
					<c:when test="${total < 20 }">disabled</c:when>
					</c:choose>>20줄 보기</option>
			</select>
		</div>
	</div>
	<div class="tableBox">
		<table align="center" style="text-align:center;">
			<tr>
				<th>번호</th>
				<th width="70%">제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
				<th>조회수</th>
			</tr>
			<c:choose>
				<c:when test="${searchError != null}">
					<tr>
						<td colspan="5">${searchError }</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:set var="st" value="공지사항"/>
					<c:set var="nt" value="숙제"/>
					<c:forEach var="search" items="${searchList }">
						<tr>
							<td>${search.searchId }</td>
							<c:choose>
								<c:when test="${fn:contains(search.searchTitle,st)}">
									<td><a href="/notice/noticeView?not_id=${search.searchId }">${search.searchTitle}</a></td>
								</c:when>
								<c:when test="${fn:contains(search.searchTitle,nt)}">
									<td><a href="/homework/detail?tho_id=${search.searchId }">${search.searchTitle}</a></td>
								</c:when>
								<c:otherwise>
									<td><a href="/paboardView?pab_id=${search.searchId }">${search.searchTitle}</a></td>
								</c:otherwise>
							</c:choose>
							<td>${search.searchUserName}</td>
							<td>${search.searchDate}</td>
							<td>${search.searchCount}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<div class="pagingAllBox">
		<div class="prevBox">
			<c:if test="${paging.startPage != 1 }">
				<a class="prev" href="/search?search=${paging.searchText }&nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
				<script type="text/javascript">
					$(".prevBox").css("display","block");
				</script>
			</c:if>
		</div>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<div class="pagingBox">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a class="linkNumber" href="/search?search=${paging.searchText }&nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</div>
		</c:forEach>
		<div class="nextBox">
			<c:if test="${paging.endPage != paging.lastPage}">
				<a class="next" href="/search?search=${paging.searchText }&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
				<script type="text/javascript">
					$(".nextBox").css("display","block");
				</script>						
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"></jsp:include>
</body>
</html>