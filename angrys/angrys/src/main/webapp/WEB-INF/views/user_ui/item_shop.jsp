<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	
	
	
	<script type="text/javascript">
		function buy(){
			//alert('buy!');
			var radio_btn = $(':input[name=shop_item]:radio:checked').val();
			var can_buy = false;
			
			
			if(${fn:length(user_list)} > 20){
				alert('인벤토리가 꽉찼습니다.');
				return;
			}
			/* 
			else if(){
				
			} */
			
			else if(radio_btn == null){
				alert("아이템이 선택되지 않았습니다.");
				return false;
	        }
			
			
			$.ajax({
				url : "shop_user_gold_check" ,
				type : "POST" ,
				data : {	"item_no": radio_btn	} ,
						
				success : function(data) {
					//consoles
					if(data=='true'){
						//가능
						//can_buy = true;
						document.getElementById('shop_form').submit();
					}else{
						//불가능
						alert("골드가 부족합니다.");
						
					}
				}
			});
			
		}
		
		
		
		
		
		
		
		
		function sell(){
			//alert('sell!');
			var radio_btn = $(':input[name=user_item]:radio:checked').val();
			
			
			if( radio_btn ){
				alert(radio_btn+"을 선택했습니다");
				document.getElementById('user_form').submit();
			}else{
				alert("아이템이 선택되지 않았습니다.");
				return false;
	        }
		}
	</script>
	
	
	
	
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
		
		
		
		<div style="height: 50px; width: 50%; float: left; margin-top: 50px; text-align: left;">
			<label style="margin-left: 30px"><b>상점 아이템</b></label>
		</div>
		
		<div style="height: 50px; width: 50%; float: left; margin-top: 50px; text-align: right;">
			<label style="margin-right: 30px"><b>인벤토리</b></label>
		</div>
		
		
			<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		
		<!-- 상점 -->
		
		<div style="float:left; width: 449px;height: 450px; position:relative;float: left">
			<form id="shop_form" action="item_shop_action" method="POST">
				<table class="table" style="text-align: center;width: 100%;float: left; font-size: 12px;">
					
					<tr><th style="width:70px;">선택</th>
					<th style="width:214px;">아이템 이름</th>
					<th style="width:118px;">가격</th></tr>
					
					
					
					<c:forEach var="item_list" items="${shop_list }">
						<tr><td>
						<input type="radio" name="shop_item" value="${item_list.item_no }">
						</td>
						<td>${item_list.item_name }</td><td>${item_list.price }</td></tr>
					</c:forEach>
					
				</table>
				
				
				<div style="position: absolute; bottom:20px; width:100%;float:left;">
					<input class="btn btn-outline-secondary" type="button" value="구매하기" size="20" onclick="buy()">
				</div>
			</form>
		</div>
		
		
			<hr style="width:0px;height:448px;border:1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		
		
		
		<!-- 유저 -->
		<div style="float:left; width: 449px;height: 450px; position:relative;">
			<form id="user_form" action="item_shop_action" method="POST">
				<table class="table" style="width: 100%; text-align: center; font-size: 12px;float: left;">
					<tr><th style="width:70px;">선택</th>
					<th style="width:214px;">아이템 이름</th>
					<th style="width:118px;">가격</th></tr>
					
					
					
					<c:forEach var="user_list" items="${user_list }">
						<tr><td>
						<input type="radio" name="user_item" value="${user_list.pk_no }">
						</td>
						<td>${user_list.item_name }</td><td>${user_list.price }</td></tr>
					</c:forEach>
				</table>
				
				<div style="position: absolute; bottom:20px; width:449px; margin-top: 50px; float: left">
					<input class="btn btn-outline-secondary" type="button" value="판매하기" size="20" onclick="sell()">
				</div>
			</form>
		</div>
		
		
		
		<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		
		<div style="margin-top: 75px;float: left;text-align: center;width: 100%">
			<input class="btn btn-outline-secondary" type="button" value="메인으로" size="20" onclick="location.href='main'">
		</div>
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px; width:100%; float:left;margin-top: 100px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
		
		
	</div>
	
	
	
	
	
</body>
</html>