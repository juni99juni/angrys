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
						//�Ұ���
						$('#idlabel').text('��� �Ұ����� ���̵��Դϴ�.');
					}else{
						//����
						$('#idlabel').text('��� ������ ���̵��Դϴ�.');
						
					}
				}
			});
			
		});
		
		
		$('#password1').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("��й�ȣ�� ��ġ�մϴ�.");
				$('#subbutton').attr('disabled', false);
			} else {
				$('#tttt').text("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			}
		});
		
		$('#password2').keyup(function(){
			if($('#password1').val()==$('#password2').val()){
				$('#tttt').text("��й�ȣ�� ��ġ�մϴ�.");
				$('#subbutton').attr('disabled', false);
			} else {
				$('#tttt').text("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			}
		});
	})
</script>

<body>
	<form action="signup_action" method="POST" >
	
		���̵𿡿� : <input class="button" type="text" id="ID" name="ID"><br>
		<label id="idlabel"></label><br>
		����̿��� : <input type="password" id="password1" name="password"><br>
		���Ȯ���� : <input type="password" id="password2"><br>
		<label id="tttt">����</label><br>
		�̸����̿� : <input type="text" id="email" name="email"><br>
		
		<input type="submit" value="����" id="subbutton" disabled="disabled">
	</form>
</body>
</html>