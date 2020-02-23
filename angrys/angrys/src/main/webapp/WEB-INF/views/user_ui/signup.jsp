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

<script type="text/javascript">
	
	
	
	$(document).ready(function(){
		
		var ID = false;
		var password = false;
		var nickname = false;
		
		
		
		$("#ID").keyup(function(){
			
			
			
			var query = $("#ID").val();
			
			
			$.ajax({
				url : "ID_overlap_check?" ,
				type : "get" ,
				data : {"userID": query } ,
				success : function(data) {
					if($('#ID').val()==""){
						$('#idlabel').text('');
						$('#subbutton').attr('disabled', true);
					}
					else if(data=='false'){
						//불가능
						$('#idlabel').text('사용 불가능한 아이디입니다.');
						ID = false;
						$('#subbutton').attr('disabled', true);
					}else{
						//가능
						$('#idlabel').text('사용 가능한 아이디입니다.');
						ID = true;
						if(ID==true && password==true && nickname==true){
							$('#subbutton').attr('disabled', false);
						}
						
					}
				}
			});
			
		});
		
		
		
		
		$("#nickname").keyup(function(){
			
			
			
			var query = $("#nickname").val();
			
			
			$.ajax({
				url : "nickname_overlap_check?" ,
				type : "get" ,
				data : {"nickname": query } ,
				success : function(data) {
					if($('#nickname').val()==""){
						$('#nicknamelabel').text('');
						$('#subbutton').attr('disabled', true);
					}
					else if(data=='false'){
						//불가능
						$('#nicknamelabel').text('사용 불가능한 닉네임입니다.');
						nickname = false;
						$('#subbutton').attr('disabled', true);
					}else{
						//가능
						$('#nicknamelabel').text('사용 가능한 닉네임입니다.');
						nickname = true;
						if(ID==true && password==true && nickname==true){
							$('#subbutton').attr('disabled', false);
						}
						
					}
				}
			});
			
		});
		
		
		$('#password1').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("비밀번호가 일치합니다.");
				//$('#subbutton').attr('disabled', false);
				password = true;
				if(ID==true && password==true && nickname==true){
					$('#subbutton').attr('disabled', false);
				}
			} else {
				$('#tttt').text("비밀번호가 일치하지 않습니다.");
				//$('#subbutton').attr('disabled', true);
				password = false;
				$('#subbutton').attr('disabled', true);
			}
		});
		
		$('#password2').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("비밀번호가 일치합니다.");
				//$('#subbutton').attr('disabled', false);
				password = true;
				if(ID==true && password==true && nickname==true){
					$('#subbutton').attr('disabled', false);
				}
			} else {
				$('#tttt').text("비밀번호가 일치하지 않습니다.");
				//$('#subbutton').attr('disabled', true);
				password = false;
				$('#subbutton').attr('disabled', true);
			}
		});
		
		
		
		/* var Stringgg = "비밀번호가 일치합니다.";
		$('#nickname').keyup(function(){
			if(ID==true && password==true){
				alert('nickname 들어옴!');
				$('#subbutton').attr('disabled', false);
			}
		}) */
		
		
	})
	//닉네임 정규식, 
</script>

<body>
	
	
	<div align="center" style="margin:0 auto;height: 1000px;width: 900px;" >
		<div align="center" style="background-color: skyblue;font-size: 50px;">
			<div style="width:220px; color: white; cursor: pointer;" onclick="location.href='login'">ANGRY'S</div>
		</div>
		
		
		
		
		
		
		
		<form action="signup_action" method="POST" style="margin-top: 100px">
			
			
			
			<input class="button" type="text" id="ID" name="ID" maxlength="15" placeholder="아이디"><br>
			<label id="idlabel"></label><br>
			<input type="password" id="password1" name="password" maxlength="15" placeholder="비밀번호"><br><br>
			<input type="password" id="password2" maxlength="15" placeholder="비밀번호 확인"><br>
			<label id="tttt"></label><br>
			<input type="text" id="nickname" name="nickname" maxlength="6" placeholder="닉네임"><br>
			<label id="nicknamelabel"></label><br>
			<br>
			
			<input type="submit" value="회원가입" id="subbutton" disabled="disabled" class="btn btn-outline-secondary">
			<input type="button" value="돌아가기" onclick="location.href='login'" class="btn btn-outline-secondary">
			
		</form>
		
		
		
		
		
		
		
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px; width:100%; float:left;margin-top: 100px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
		
		
	</div>
	
	
</body>
</html>