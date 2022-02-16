<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>공지사항 상세보기</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<c:url var="updateUrl" value="/notice/updateView">
	<c:param name="not_id" value="${read.not_id}"/>
</c:url>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='readForm']");
		// 수정 
		$("#update_btn").on("click", function(){
			location.href="${updateUrl}";	
		})
			
		// 삭제
		$("#delete_btn").on("click", function(){
			var deleteYN = confirm("삭제하시겠습니가?");
			if(deleteYN == true){
				formObj.attr("action", "/notice/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
		})
			
		// 취소
		$("#list_btn").on("click", function(){	
			location.href = "/notice/noticeList";
		})
			
		//댓글작성
			$("#replyWrite_btn").on("click", function() {
				var formObj = $("form[name='replyForm']");
				formObj.attr("action", "/notice/replyWrite");
				formObj.submit();
			})
			
		//댓글 수정 view
			$("#replyUpdateBtn").on("click", function(){
				location.href = "/notice/replyUpdateView?not_id=${read.not_id}"						
								+ "&reply_id="+$(this).attr("data-rno");
				
			});
			
		//댓글 삭제 view
			$("#replyDeleteBtn").on("click", function(){
				location.href = "/notice/replyDeleteView?not_id=${read.not_id}"
					+ "&reply_id="+$(this).attr("data-rno");
			});	
		})
</script>
<body>
<div id="root">
	<header>
		<jsp:include page="/WEB-INF/views/module/top.jsp" flush="false"/>
	</header>
<div class="container">
<section id="container">
	<h1>공지사항</h1>
	<hr />
	<form name="readForm" role="form" method="post">
		<table class="table">
		<thead>
		   	<tr>
		   	 <th style="display:none;" scope="col">${read.not_id}</th> 
		   	 <c:choose>
		   	 	<c:when test="${read.not_permit eq 'P'}">
		   		 <th scope="col" >[학부모님]&nbsp;${read.not_title}</th></c:when>
		   		 <c:when test="${read.not_permit eq 'A'}">
		   		 <th scope="col" >[학생과 학부모님]&nbsp;${read.not_title}</th></c:when>
		   		 <c:otherwise>
		   		 <th scope="col" >[학생]&nbsp;${read.not_title}</th></c:otherwise>
		   	 </c:choose>
		   	 <th scope="col" style="text-align:right"><fmt:formatDate value="${read.not_writedate}" pattern="yyyy-MM-dd"/></th>
		  	</tr>
		 </thead>
		 <tbody>	
			<tr>
				<td colspan="3" style="border:none;">
					<textarea readonly class="form-control-plaintext" id="not_contents" name="not_contents"  style="height:300px" ><c:out value="${read.not_contents}" /> </textarea>	
				</td>
			</tr>
			<!-- 글 제목에 "지도"라는 단어가 포함되면 map.jsp를 불러옴 -->
			 <tr>
				<td colspan="3">
				<c:set var="text" value="${read.not_title}" />
				<c:if test="${fn:contains(text, '지도')}">
				<jsp:include page="/WEB-INF/views/notice/map.jsp" flush="false" />
				</c:if>
				</td>
			</tr>
		</tbody>
		<tr style="background-color: #f2f5fa;border-bottom: hidden;">
         <c:if test="${read.not_file_name ne null}">
            <td colspan="3" >첨부파일&nbsp;<a href="fileDownload.do?fileName=${read.not_file_name}" style="text-decoration:none;">${read.not_file_name}</a>
            &nbsp;<span class="badge rounded-pill bg-primary">download</span></td>
         </c:if>
      </tr>			
		</table>
	
	<!-- 댓글보기 -->
	<div id="reply">
		<ol class="replyList">
			<c:forEach items="${replyList}" var="replyList">
			    <li>
	              <p>${replyList.reply_contents}</p>
			      <p>
			      작성자 : ${replyList.reply_writer}
			      (<fmt:formatDate value="${replyList.reply_date}" pattern="yyyy-MM-dd"/>)
	              </p>
			      <div class="btn-group" role="group" aria-label="Basic outlined example">
		       	  <button type="button" class="btn btn-outline-secondary" id="replyUpdateBtn" data-rno="${replyList.reply_id}">수정</button>  
 				  <button type="button" class="btn btn-outline-secondary" id="replyDeleteBtn" data-rno="${replyList.reply_id}">삭제</button> 
 				  </div><hr>
	               <div>
		      </div>
			  </li>
			 </c:forEach>  
		</ol>
	</div>
</form>
	
	<!-- 댓글 작성 칸-->
<form name="replyForm" method="post">
		<input type="hidden" id="n_id" name="n_id" value="${read.not_id }" />
	<!--(수정하기)로그인 한 사용자를 작성자에 넣기 & 숨기기  -->
	<p><strong>댓글달기</strong> &nbsp;&nbsp;<span>작성자: <input type="text" id="reply_writer" name="reply_writer" style="border:none;"/></span>
	<div class="input-group">	
		<textarea class="form-control" placeholder="댓글 내용을 작성해주세요." aria-label="reply_contents" aria-describedby="button-addon2" id="reply_contents" name="reply_contents" /></textarea>&nbsp;&nbsp;
		<button type="button" class="btn btn-outline-primary" id="replyWrite_btn">등 록</button>
	</div>	
</form>	
	
		<!-- 버튼들 ~~  -->
		<br><br>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<!-- 교사만 수정 삭제 버튼 보이기( 나중에 수정하기 )  
		<c:if test="${userid eq NoticeVO.not_writer}">-->
			<button type="button" class="btn btn-primary" id="update_btn">수정</button>
			<a href="/notice/delete?not_id=${read.not_id }" role="button" class="btn btn-primary" id="delete_btn">삭제</a>
			<!--</c:if>-->

			<button type="button" class="btn btn-outline-secondary" id="list_btn">목록으로</button>
		</div>	
		
	<br>
	<jsp:include page="/WEB-INF/views/module/footer.jsp" flush="false"/>
	</section>
	</div>
</div>
</body>
</html>