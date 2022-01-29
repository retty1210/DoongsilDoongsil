<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function Del(){
		console.log('삭제!!');
		var del = document.getElementsByName('DelForm')[0];
		if(del != null){
			del.submit();	
		} else{
			alert("삭제할 데이터가 없습니다.");
		}
	}
	function DelCancel(){
		window.close();
		opener.location.reload("/admin/info");
	}
	function selAll(){
		var all = document.getElementsByName('selectAll')[0];
		var boxes = document.getElementsByName('selectStudent');
		if(all.checked == true){
			all.value = true;
			for(var i = 0;i < boxes.length;i++){
				boxes[i].checked = true;
				boxes[i].value=boxes[i].parentElement.nextElementSibling.innerText;
			}
		}
	}
	function selectBoxes(){
		var all = document.getElementsByName('selectAll')[0];
		var boxes = document.getElementsByName('selectStudent');
		for(var i = 0;i < boxes.length;i++){
			if(!boxes[i].checked){
				all.checked = false;
				all.value=false;
				break;
			}else{
				all.checked = true;
				all.value=true;
			}
		}
	}
</script>
<style type="text/css" rel="stylesheet">
	.delSuccess,
	.delFail{
		float:right;
		border-radius:5px;
		width:50px;
	}
	.delSuccess{
		background-color:#0476DE;
		border-color:#0476DE;
		color:white;
		margin-left:5px;
		margin-bottom: 10px;
	}
	.studentDelList_box{
		width:100%;
		height:100%;
		overflow-y:auto;
		white-space: nowrap;
	}
	.studentDelList_tb{
		width:100%;
		height:100%;
	}
</style>
<link href="/stc/css/info.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<h4>학생 목록 선택 삭제</h4>
	<form action="/studentDel" method="post" name="DelForm">
		<div class="studentDelList_box">
			<button type="button" onclick="Del();" class="delSuccess">삭제</button>
			<button type="button" onclick="DelCancel();" class="delFail">취소</button>
		</div>
		<div>
			<table border="1" class="studentDelList_tb">
				<tr class="studentDelList_tr">
					<td><input type="checkbox" name="selectAll" onchange="selAll();"/></td>
					<th>번호</th>
					<th width="60%">이름</th>
					<th>생일</th>
				</tr>
				<c:forEach var="studentList" items="${sessionScope.infoStudentList}">
					<tr class="studentDelList_tr">
						<td><input type="checkbox" name="selectStudent" onchange="selectBoxes();" value="${studentList.sta_id }"/></td>
						<td>${studentList.sta_id }</td>
						<td>${studentList.sta_name }</td>
						<td>${studentList.sta_birthday }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</form>

</body>
</html>