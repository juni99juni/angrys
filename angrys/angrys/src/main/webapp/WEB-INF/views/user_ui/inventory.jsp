<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<script type="text/javascript">
		
	function equip(){
		
		//pk_no을 가져옴
		var radio_btn = $(':input[name=user_item]:radio:checked').val();
		
		
		if( radio_btn ){
			alert(radio_btn+"을 선택했습니다");
			
		}
		else if(radio_btn == null){
			alert("아이템이 선택되지 않았습니다.");
			return false;
        }
		
		
		
		$.ajax({
			url : "item_category_check" ,
			type : "POST" ,
			data : {	"pk_no": radio_btn	} ,
					
			success : function(data) {
				//consoles
				if(data=='true'){
					//가능
					document.getElementById('user_item_form').submit();
				}else{
					//불가능
					alert("장착할 수 없는 유형의 아이템입니다.");
					
				}
			}
		});
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
			<label style="margin-left: 30px"><b>캐릭터 장비</b></label>
		</div>
		
		
		
		
		
		<div style="height: 50px; width: 50%; float: left; margin-top: 50px; text-align: right;">
			<label style="margin-right: 30px"><b>인벤토리</b></label>
		</div>
		
		
			<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		
		<!-- 캐릭터 스탯 -->
		<div style="float:left; width: 449px;height: 295px">
			
			<table class="table" style="width: 100%; margin-top: 49px;text-align: center;">
				<tr><th style="width:90px;"></th>
					<th style="width:199px;">이름</th>
					<th style="width:80px;">위력</th>
					<th style="width:80px;">무게</th></tr>
				<tr><th>무기류</th>	<td>${user_weapon.item_name }</td>	<td>${user_weapon.item_att }</td>	<td>${user_weapon.item_wei }</td></tr>
				<tr><th>방어구</th>	<td>${user_armor.item_name }</td>	<td>${user_armor.item_att }</td>	<td>${user_armor.item_wei }</td></tr>
				<tr><th>장신구</th>	<td>${user_acce.item_name }</td>	<td>${user_acce.item_att }</td>	<td>${user_acce.item_wei }</td></tr>
				<!-- 빈칸 -->
				<tr><th>	</th>	<td>		</td>	<td></td>	<td></td></tr>
				
			</table>
			
			
		</div>
		
		
			<hr style="width:0px;height:293px;border:1px solid skyblue;float:left;margin:auto"/>
		
		
		
		<!-- 캐릭터 장비창 -->
		<div style="float:left; width: 449px;height: 200px">
			<form id="user_item_form" action="equipment_item" method="POST">
				<table class="table" style="width: 100%; text-align: center; font-size: 12px;float: left;">
					<tr>
					<th style="width:70px;">선택</th>
					<th style="width:214px;">아이템 이름</th>
					<th style="width:118px;">가격</th>
					</tr>
					
					
					
					<c:forEach var="user_list" items="${user_list }">
						<tr><td>
						<input type="radio" name="user_item" value="${user_list.pk_no }">
						</td>
						<td>${user_list.item_name }</td><td>${user_list.price }</td></tr>
					</c:forEach>
				</table>
				
			</form>
		</div>
		
		<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		<div style="margin-top: 75px;float: left;text-align: center;width: 100%">
			<input class="btn btn-outline-secondary" type="button" value="장비하기" size="20" onclick="equip()">
			<input class="btn btn-outline-secondary" type="button" value="메인으로" size="20" onclick="location.href='main'">
		</div>
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px; width:100%; float:left;margin-top: 100px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
	</div>
	
</body>
</html>