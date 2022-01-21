<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
<jsp:include page="/WEB-INF/views/module/default.jsp" flush="false" />
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<div>
	<h2>대략적인 폴더 경로 설명</h2>
	<p>
	main/resources/oracle: wallet과 doongsil_connect파일을 넣습니다.<br>
	참고로 oracle 폴더는 git에 안 올라가게 설정해두었기 때문에 각자 알아서 넣어야 합니다.<br>
	doongsil_connect 파일을 열어서 프로젝트 위치/src/main/resources/oracle/Wallet_laptopTestDB 경로를 각자 추가해줍니다. <br>
	oracle 폴더는 git에 업로드가 안 되기 때문에 각자 보관&관리하셔야 합니다. <br>
	<br>
	<hr>
	<br>
	main/webapp/resources: build path에서 여기를 classpath로 인식하게 설정해야합니다.<br>
	그 하위폴더들 설명)<br>
	css: css파일들을 넣는 곳입니다.<br>
	jquery: 제이쿼리 파일이 있습니다.<br>
	js: 자바스크립트 파일들을 넣는 곳입니다.<br>
	mybatis/mappers: 마이바티스 매퍼들을 넣는 곳입니다. namespace의 이름이 중복되지 않도록 주의해주세요.<br>
	sql: DB담당자가 만든 sql파일들을 보관하는 곳입니다.<br>
	staticimg: 아이콘 등 사이트의 구성에 필요한 정적 이미지들을 보관하는 곳입니다.<br>
	upload: 이용자가 업로드한 파일을 보관하는 곳입니다.(개발방향에 따라 삭제될 수 있습니다.)<br>
	<br>
	<hr>
	<br>
	main/webapp/WEB-INF/views/module: 여러 폴더의 jsp파일에서 공통적으로 사용하는 것들을 보관합니다.<br>
	module/default.jsp: 제이쿼리, 기본 css등 모든 jsp파일에 공통적으로 들어가는 script를 한번에 불러옵니다.<br>
	module/top.jsp: 사이트의 상단바 데이터를 넣습니다. 
	</p>
</div>

</body>
</html>
