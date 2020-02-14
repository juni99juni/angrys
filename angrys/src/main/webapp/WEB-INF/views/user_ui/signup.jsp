<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		
		
		
		
		$("#ID").keyup(function(){
			
			
			
			var query = $("#ID").val();
			
			$.ajax({
				url : "overlap_check?" ,
				type : "get" ,
				data : {"userID": query } ,
				success : function(data) {
					if($('#ID').val()==""){
						$('#idlabel').text('');
					}
					else if(data=='false'){
						//불가능
						$('#idlabel').text('사용 불가능한 아이디입니다.');
					}else{
						//가능
						$('#idlabel').text('사용 가능한 아이디입니다.');
						
					}
				}
			});
			
		});
		
		
		$('#password1').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("비밀번호가 일치합니다.");
				$('#subbutton').attr('disabled', false);
			} else {
				$('#tttt').text("비밀번호가 일치하지 않습니다.");
			}
		});
		
		$('#password2').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("비밀번호가 일치합니다.");
				$('#subbutton').attr('disabled', false);
			} else {
				$('#tttt').text("비밀번호가 일치하지 않습니다.");
			}
		});
	})
</script>

<body>
	<form action="signup_action" method="POST" >
	
		아이디에요 : <input class="button" type="text" id="ID" name="ID"><br>
		<label id="idlabel"></label><br>
		비번이에요 : <input type="password" id="password1" name="password"><br>
		비번확인좀 : <input type="password" id="password2"><br>
		<label id="tttt">이힝</label><br>
		이메일이요 : <input type="text" id="email" name="email"><br>
		
		<input type="submit" value="보내" id="subbutton" disabled="disabled">
	</form>
</body>
</html>