<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	
<body>
	
	<c:set var="memID" value="${memID}" scope="session"/>
	<c:if test="${empty sessionScope.memID }">
		<script type="text/javascript">
			alert("서비스를 즐기시려면 로그인이 필요합니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=login">
	</c:if>
	
	
	
	
	
	<div align="center" style="margin:0 auto;height: 1000px;width: 900px;" >
		<div align="center" style="background-color: skyblue;font-size: 50px;">
			<div style="width:220px; color: white; cursor: pointer;" onclick="location.href='main'">ANGRY'S</div>
		</div>
		
		
		
		
		
		
		
		코드 들어간다<br>
		<b>안녕</b>
		
		
		
		
		
		
		
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px; width:100%; float:left;margin-top: 100px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
		
		
	</div>
	
	
</body>
</html>