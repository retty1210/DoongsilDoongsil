<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 	<title>상세보기</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			
			// 수정 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/paboard/pabupdate");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			
			// 삭제
			$(".delete_btn").on("click", function(){
				formObj.attr("action", "/paboard/delete");
				formObj.attr("method", "post");
				formObj.submit();
			})
			
			// 취소
			$(".list_btn").on("click", function(){
				
				location.href = "/paboard/paboardList";
			})
		})
	</script>
	<body>
	
		<div id="root">
			<header>
				<h1>학부모 게시판</h1>
			</header>
			
			<section id="container">
				<form role="form" method="post">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="pab_id">글 번호</label><input type="text" id="pab_id" name="pab_id" value="${view.pab_id}"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_title">제목</label><input type="text" id="pab_title" name="pab_title" value="${view.pab_title}"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_contents">내용</label><textarea id="pab_contents" name="pab_contents"><c:out value="${view.pab_contents}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_writer">작성자</label><input type="text" id="pab_writer" name="pab_writer" value="${view.pab_writer}" />
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_date">작성날짜</label>
									<fmt:formatDate value="${view.pab_date}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>		
						</tbody>			
					</table>
					<div>
					<button type="submit" class="update_btn">수정</button>
					<button type="submit" class="delete_btn">삭제</button>
					<button type="submit" class="list_btn">목록</button>
					</div>
				</form>
			</section>
			<hr/>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>