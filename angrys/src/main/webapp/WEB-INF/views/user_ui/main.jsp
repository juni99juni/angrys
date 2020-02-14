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
<script type="text/javascript">
	
	function move_hunt(){
		var select_value = document.getElementById('hunt_menu');
		if(select_value.value=="1")   location.href='hunt?map_level=1&auto=false';  //오정우의 집
		else if(select_value.value=="2")   location.href='hunt?map_level=2&auto=false';  //한라대학교
		else if(select_value.value=="3")   location.href='hunt?map_level=3&auto=false';  //김동호의 교수실
	}
	
	
	function user_menu(){
		var select_value = document.getElementById('user_menu');
		if(select_value.value=="1")   location.href='user_info';  //캐릭터 정보 보기
		else if(select_value.value=="2")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //인벤토리
		else if(select_value.value=="3")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //스킬 배우기
		else if(select_value.value=="4")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //스킬 설정
	}
	
	
	function shop_menu(){
		var select_value = document.getElementById('shop_menu');
		if(select_value.value=="1")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //무기 상점
		else if(select_value.value=="2")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //방어구 상점
		else if(select_value.value=="3")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //장신구 상점
		else if(select_value.value=="4")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //소모품 상점
	}
	
	
	function move_conveni(){
		var select_value = document.getElementById('conveni_menu');
		if(select_value.value=="1")   location.href='motel';  //여관 가기
		else if(select_value.value=="2")   location.href='bank';  //은행 가기
		else if(select_value.value=="3")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //직업 소개소
		else if(select_value.value=="4")   alert("미구현입니다. 빠른 시일내로 구현하겠습니다.");  //대장간
	}
	
	/* hunt_menu, user_menu, shop_menu, conveni_menu */
	
</script>

<body>
	
	<%-- <c:set var="memID" value="${memID}" scope="session"/> --%>
	
	<c:if test="${empty sessionScope.memID }">
		<script type="text/javascript">
			alert("서비스를 즐기시려면 로그인이 필요합니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=login">
	</c:if>
	
	
	
	
	<div align="center" style="margin:0 auto;background-color:#DDDDDD;height: 1200px;width: 900px;" >
	
		<div align="center" style="background-color: skyblue;font-size: 50px;">
			<div style="width:220px; color: white; cursor: pointer;" onclick="location.href='main'">ANGRY'S</div>
		</div>
		
		
		<!-- 유저 정보 -->
		<div style="background-color:#ffffff;height:300px;width:550px;float:left;">
			
			<div style="height:120px; width:100px;float:left;margin-top: 10px;">
				<img src="${pageContext.request.contextPath }/resources/${img}" style="float: left;">
				<label style="font-weight: bold">${nickname }</label>
			</div>
			
			
			 
			<table style="height:120px;width:210px;float:right;text-align: center; margin-left: 10px;margin-top: 10px;">
				<tr>	<th style="width:50px">
							레벨</th>		<td>${exp_info.user_level }</td>	</tr>
				<tr>	<th>경험치</th>	<td>${exp_info.user_exp }</td>		</tr>
				<tr>	<th>소지금</th>	<td>${money_info.now_money }</td>	</tr>
				<tr>	<th>예금</th>		<td>${money_info.bank_money }</td>	</tr>
			</table>
			
			
			
			<table style="height:120px;width:210px;float:right;text-align: center; margin-left: 10px;margin-top: 10px;">
				<tr><th style="width:50px">체력</th>
					<td><div class="progress">
						<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  							aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${HPpercent}%">
    						${user_info.user_nowHP} / ${user_info.user_maxHP}</div>
    					</div>
    				</td>
    			</tr>
				<tr>	<th>마나</th>
					<td><div class="progress">
						<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  							aria-valuemin="0" aria-valuemax="100" style="width:${MPpercent}%">
							${user_info.user_nowMP} / ${user_info.user_maxMP}</div>
    					</div>
    				</td>
				</tr>
				
				<tr>	<th>직업</th>		<td>${exp_info.user_job }</td>			</tr>
				<tr>	<th>숙련도</th>	<td>${exp_info.user_jobexp }</td>		</tr>
			</table>
			
			
			<hr style="width:548px;height:0px;border:1px solid skyblue;float:left;margin-top:15px;margin-bottom:10px;"/>
			
			
			<table style="height:128px;width:300px;float:left;text-align: center;margin-left: 20px;">
				<tr>	<th style="width:50px">무기</th><td>${user_weapon.item_name }</td>		</tr>
				<tr>	<th>방어구</th><td>${user_armor.item_name }</td>	</tr>
				<tr>	<th>장신구</th><td>${user_acce.item_name }</td>	</tr>
			</table>
			
			<!-- user_weapon,user_armor,user_acce -->
			<table style="height:128px;width:210px;float:right;text-align: center;margin-left: 10px">
				<tr>	<th style="width:50px">공격력</th><td>${user_info.user_att } + ${user_weapon.item_att }</td>	</tr>
				<tr>	<th>방어력</th><td>${user_info.user_def } + ${user_armor.item_att }</td>	</tr>
				<tr>	<th>속도</th><td>${user_info.user_spe } + ${user_acce.item_att }</td>		</tr>
			</table>
			
			
		</div>
		
		
		
		
		
		
		
		
			<hr style="width:0px;height:298px;border:1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		<!-- 이동할 곳 -->
		<div style="background-color:#ffffff;height:300px;width:348px;float:left;">
			
			<br>
			
			<table style="height:250px;width:330px;text-align: center;"><tr><td>
				<label>사냥하기</label></td>
				<td>
				<select class="form-control" id="hunt_menu">
					<option value=1>오정우의 집</option>
					<option value=2>한라대학교</option>
					<option value=3>김동호의 교수실</option>
				</select></td>
				<td><input type="button" value="이동" class="btn btn-outline-secondary" onclick="move_hunt()"></td></tr>
				
			
				<tr><td>
				<label>유저정보</label></td>
				<td>
				<select class="form-control" id="user_menu">
					<option value=1>캐릭터 정보보기</option>
					<option value=2>인벤토리</option>
					<option value=3>스킬 배우기</option>
					<option value=4>스킬 설정</option>
				</select></td>
				<td><input type="button" value="이동" class="btn btn-outline-secondary" onclick="user_menu()"></td></tr>
				
			
			
				<tr><td>
				<label>상점</label></td><td>
				<select class="form-control" id="shop_menu">
					<option value=1>무기 상점</option>
					<option value=2>방어구 상점</option>
					<option value=3>장신구 상점</option>
					<option value=4>소모품 상점</option>
				</select></td>
				<td><input type="button" value="이동" class="btn btn-outline-secondary" onclick="shop_menu()"></td></tr>
			
			
				<tr><td>
				<label>편의시설</label></td><td>
				<select class="form-control" id="conveni_menu">
					<option value=1>여관</option>
					<option value=2>은행</option>
					<option value=3>직업소개소</option>
					<option value=4>대장간</option>
				</select></td>
				<td><input type="button" value="이동" class="btn btn-outline-secondary" onclick="move_conveni()"></td></tr>
			</table>
		</div>
		
		
		
			<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		<!-- 마을 정보 -->
		<div style="background-color:#ffffff;height:300px;width:100%;float:left;">
			<!-- 성주님 한마디 -->
			<div style="width:550px;float:left;">
				<br>
			</div>
			
			<hr style="width:0px;height:298px;border:1px solid skyblue;float:left;margin:auto"/>
			
			<!-- 성벽 정보 -->
			<div style="width:348px;float:left;">
				<br>
			</div>
		</div>
		
		
		
		<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		<!-- 로그 -->
		
		
		<div style="background-color:#ffffff;height:350px;width:100%;float:left;">
			<label style="font-weight: bolder;margin: 30px;">국제 정세</label>
			<table class="table">
				<tr><td>ㅇㅇㅇ 님이 죽으셨습니다!</td><td>그래?</td></tr>
				<tr><td>ㅇㅇㅇ 님이 죽으셨습니다!</td></tr>
				<tr><td>ㅇㅇㅇ 님이 죽으셨습니다!</td></tr>
				<tr><td>ㅇㅇㅇ 님이 죽으셨습니다!</td></tr>
				<tr><td>ㅇㅇㅇ 님이 죽으셨습니다!</td></tr>
			</table>
		</div>
	</div>
	
</body>
</html>