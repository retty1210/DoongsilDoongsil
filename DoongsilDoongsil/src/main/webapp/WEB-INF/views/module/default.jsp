<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
	모든 jsp파일에 공통적으로 넣어야 하는 css/script를 쓰는 페이지입니다. 
	경로 문제로 생기는 에러를 방지하기 위해 주소는 c:url을 이용하여 작성해주세요.
	jsp파일을 새로 만드실 때마다 head의 title 아래에 <> 쓰시고 그 안에
	jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" /
	를 복사&붙여넣기하여 include합니다.
-->

<!-- c:url -->
<c:url var="jq_url" value="/stc/jq" />
<c:url var="css_url" value="/stc/css" />
<c:url var="js_url" value="/stc/js" />
<c:url var="stimg_url" value="/stc/img" />
<c:url var="up_url" value="/stc/up" />

<!-- text/script -->
<script type="text/javascript" src="${jq_url}/jquery-3.6.0.min.js"></script>