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
			location.href="/paboardList?nowPage=${paging.nowPage}&cntPerPage="+sel;			
		}else{
			location.href="/paboardList?nowPage=1&cntPerPage="+sel;
		}
		
	}
	$(document).ready(function(){
		$("b").parent().css("backgroundColor","#59b1eb");		
	})
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false" />
	</header>
	<main role="main" class="container">
		<h1>학부모 게시판</h1>
		
	
		<div style="float: right;margin-right:50px; margin-top:50px;">
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
		</div> <!-- 옵션선택 끝 -->
		<div class="table_wrap">
			<c:if test="${sessionScope.account.paa_id ne null }">
				<button type="button" class="btn btn-primary" onclick="location.href='/paboardWrite'">작성하기</button>
			</c:if>
			<table>
				<tr>
					<th class="bno_width">번호</th>
					<th class="title_width">제목</th>
					<th class="writer_width">작성자</th>
					<th class="regdate_width">작성일</th>
					<th class="count_width">조회수</th>
				</tr>
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
			<div class="pagingAllBox">
				<div class="prevBox">
					<c:if test="${paging.startPage != 1 }">
						<a class="prev" href="/paboardList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
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
								<a class="linkNumber" href="/paboardList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
							</c:when>
						</c:choose>
					</div>
				</c:forEach>
				<div class="nextBox">
					<c:if test="${paging.endPage != paging.lastPage}">
						<a class="next" href="/paboardList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
						<script type="text/javascript">
							$(".nextBox").css("display","block");
						</script>						
					</c:if>
				</div>
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