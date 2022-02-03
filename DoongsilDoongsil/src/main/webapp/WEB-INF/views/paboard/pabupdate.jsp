<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
	<meta charset="utf-8">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/paboard/paboardList";
			})
		})
	
	</script>
	<body>
		<div id="root">
			<header>
				<h1>수정</h1>
			</header>
			<hr/>
			
			<section id="container">
				<form name="updateForm" role="form" method="post" action="/paboard/update">
					<input type="hidden" name="pab_id" value="${update.pab_id}" readonly="readonly"/>
					<table>
						<tbody>
							<tr>
								<td>
									<label for="pab_title">제목</label><input type="text" id="pab_title" name="pab_title" value="${update.pab_title}"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="pab_contents">내용</label><textarea id="pab_contents" name="pab_contents"><c:out value="${update.pab_contents}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_writer">작성자</label><input type="text" id="pab_writer" name="pab_writer" value="${update.writer}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="pab_date">작성날짜</label>
									<fmt:formatDate value="${update.pab_date}" pattern="yyyy-MM-dd"/>					
								</td>
							</tr>		
						</tbody>			
					</table>
					<div>
						<button type="submit" class="btn-primary">저장</button>
						<button type="submit" class="cancel_btn" onclick="location.href='/paboard/paboardList'">취소</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>