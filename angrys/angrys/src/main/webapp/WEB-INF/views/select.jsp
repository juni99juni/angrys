<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	야호 <br><br>
	<c:forEach var="user" items="${user }">
		
		아이디 : ${user.ID }<br>
		비번요 : ${user.password }<br>
		이메일 : ${user.nickname }<br>
		
		<br><br>
		
	</c:forEach>
	
</body>
</html>