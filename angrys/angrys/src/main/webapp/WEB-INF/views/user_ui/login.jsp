<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript">
		
		$(document).ready(function(){
			$("#ID").focus();
			$("#login").click(function(){
				
				if($("#ID").val() != "" && $("#password").val() != ""){
					
					$.ajax({
						url : "login_action" ,
						type : "post" ,
						data : {
								"ID": $("#ID").val(),
								"password" : $("#password").val()
								} ,
								
						success : function(data) {
							if(data=='true'){
								//불가능
								location.href="main";
							}else{
								//가능
								alert("아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다.");
							}
						}
					});
				}
				
				
				else if($("#ID").val() == ""){
					alert("아이디를 입력해주세요.");
					$("#ID").focus();
					return;
				}
				else if($("#password").val() == ""){
					alert("비밀번호를 입력해주세요.");
					$("#password").focus();
					return
				}
				
			})
			
		});
		
		function enterkey(){
			if(window.event.keyCode == 13){
				login();
			}
		}
		
		
	</script>
	
	
<body>

<div align="center" style="margin:0 auto;background-color:skyblue;height: 300px;width: 300px;" >
	
	
	<c:if test="${not empty sessionScope.memID }">
		<script type="text/javascript">
			alert("이미 로그인이 되어있습니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=main">
	</c:if>
	
	
	
	
	<br>
	<label>
		<h2 style="color:white">Angry's</h2>
		<h2 style="color:white">LOGIN</h2>
	</label>
	<br>
	
	
	
	<form action="login_action" method="POST" name="login_form">
	
		<!-- &nbsp;&nbsp;<label style="color: white;">아이디</label>&nbsp;&nbsp; -->
		<input type="text" size="20" maxlength="20" placeholder="아이디" id="ID" name="ID">
		<br><br>
		<!-- &nbsp;<label style="color: white;">비밀번호</label>&nbsp; -->
		<input type="password" size="20" maxlength="20" placeholder="비밀번호" id="password" name="password" onkeyup="enterkey()">
		<br><br>
		
		
		<input class="btn btn-outline-secondary" style="background-color: white" type="button" value="로그인" id="login">&nbsp;
		<input class="btn btn-outline-secondary" style="background-color: white;" type="button" value="회원가입" onclick="location.href='signup'">
	</form>
	
	
</div>

</body>
</html>