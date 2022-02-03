<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<title>글작성</title>
	</head>
	<body>
	
		<div id="root">
			<header>
				<h1>글작성</h1>
			</header>
			
			<section id="container">
				<form role="form" method="post" action="/paboard/paboardWrite">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="title">제목</label><input type="text" id="pab_title" name="pab_title" />
								</td>
							</tr>	
							<tr>
								<td>
									<label for="contents">내용</label><textarea id="pab_contents" name="pab_contents" ></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">작성자</label><input type="text" id="pab_writer" name="pab_writer" />
								</td>
							<tr>
								<td>
										<div class="form-group form-check">
    										<input type="checkbox" class="form-check-input" id="exampleCheck1">
    										<label class="form-check-label" for="exampleCheck1">같은 학급만 읽기</label>
  										</div>				
									<button type="button" class="btn btn-primary" onclick="location.href='/paboard/paboardList'">취소</button>
									<button type="submit" class="btn btn-primary" >작성</button>
								</td>
							</tr>			
						</tbody>			
					</table>
				</form>
			</section>
			<hr />
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>

