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
		
		
		<div style="margin-top: 100px;height: 200px;">
			<label>저희 여관은 숙박 시 HP와 MP를 모두 회복시켜드립니다.<br>하룻 밤 묵는데 <b>${user_gold } 골드</b> 입니다.<br></label>
			<c:if test="${user_gold < 1 }">골드가 없으시군요. 공짜로 묵으셔도 좋습니다.<br></c:if>
			<div style="margin-top: 20px;">
				<input class="btn btn-outline-secondary" type="button" value="회복하기" size="20" onclick="location.href='heal'">
				<input class="btn btn-outline-secondary" type="button" value="메인으로" size="20" onclick="location.href='main'">
			</div>
		</div>
		
		
		
		
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
	</div>
	
	
</body>
</html>