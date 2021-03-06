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
		if(select_value.value=="1")   location.href='hunt?map_level=1&auto=false';  //神舛酔税 増
		else if(select_value.value=="2")   location.href='hunt?map_level=2&auto=false';  //廃虞企俳嘘
		else if(select_value.value=="3")   location.href='hunt?map_level=3&auto=false';  //沿疑硲税 嘘呪叔
	}
	
	
	function user_menu(){
		var select_value = document.getElementById('user_menu');
		if(select_value.value=="1")   location.href='user_info';  //蝶遣斗 舛左 左奄
		else if(select_value.value=="2")   location.href='inventory';  //昔坤塘軒
		else if(select_value.value=="3")   alert("耕姥薄脊艦陥. 匙献 獣析鎧稽 姥薄馬畏柔艦陥.");  //什迭 壕酔奄
		else if(select_value.value=="4")   alert("耕姥薄脊艦陥. 匙献 獣析鎧稽 姥薄馬畏柔艦陥.");  //什迭 竺舛
	}
	
	
	function shop_menu(){
		var select_value = document.getElementById('shop_menu');
		if(select_value.value=="1")   location.href='item_shop?location=weapon';  //巷奄 雌繊
		else if(select_value.value=="2")   location.href='item_shop?location=armor';  //号嬢姥 雌繊
		else if(select_value.value=="3")   location.href='item_shop?location=acce';  //舌重姥 雌繊
		else if(select_value.value=="4")   location.href='item_shop?location=expen';  //社乞念 雌繊
	}
	
	
	function move_conveni(){
		var select_value = document.getElementById('conveni_menu');
		if(select_value.value=="1")   location.href='motel';  //食淫 亜奄
		else if(select_value.value=="2")   location.href='bank';  //精楳 亜奄
		else if(select_value.value=="3")   alert("耕姥薄脊艦陥. 匙献 獣析鎧稽 姥薄馬畏柔艦陥.");  //送穣 社鯵社
		else if(select_value.value=="4")   alert("耕姥薄脊艦陥. 匙献 獣析鎧稽 姥薄馬畏柔艦陥.");  //企舌娃
		//切政惟獣毒, 戚硯精 韻舌生稽 幻級奄
	}
	
	/* hunt_menu, user_menu, shop_menu, conveni_menu */
	
</script>

<body>
	
	<%-- <c:set var="memID" value="${memID}" scope="session"/> --%>
	
	<c:if test="${empty sessionScope.memID }">
		<script type="text/javascript">
			alert("辞搾什研 荘奄獣形檎 稽益昔戚 琶推杯艦陥.");
		</script>
		<meta http-equiv="refresh" content="0;url=login">
	</c:if>
	
	
	
	
	<div align="center" style="margin:0 auto;background-color:#DDDDDD;height: 1200px;width: 900px;" >
	
		<div align="center" style="background-color: skyblue;font-size: 50px;">
			<div style="width:220px; color: white; cursor: pointer;" onclick="location.href='main'">ANGRY'S</div>
		</div>
		
		
		<!-- 政煽 舛左 -->
		<div style="background-color:#ffffff;height:300px;width:550px;float:left;">
			
			<div style="height:120px; width:100px;float:left;margin-top: 10px;">
				<img src="${pageContext.request.contextPath }/resources/${img}" style="float: left;">
				<label style="font-weight: bold">${nickname }</label>
			</div>
			
			
			 
			<table style="height:120px;width:210px;float:right;text-align: center; margin-left: 10px;margin-top: 10px;">
				<tr>	<th style="width:50px">
							傾婚</th>		<td>${exp_info.user_level }</td>	</tr>
				<tr>	<th>井蝿帖</th>	<td>${exp_info.user_exp }</td>		</tr>
				<tr>	<th>社走榎</th>	<td>${money_info.now_money }</td>	</tr>
				<tr>	<th>森榎</th>		<td>${money_info.bank_money }</td>	</tr>
			</table>
			
			
			
			<table style="height:120px;width:210px;float:right;text-align: center; margin-left: 10px;margin-top: 10px;">
				<tr><th style="width:50px">端径</th>
					<td><div class="progress">
						<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  							aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${HPpercent}%">
    						${user_info.user_nowHP} / ${user_info.user_maxHP}</div>
    					</div>
    				</td>
    			</tr>
				<tr>	<th>原蟹</th>
					<td><div class="progress">
						<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  							aria-valuemin="0" aria-valuemax="100" style="width:${MPpercent}%">
							${user_info.user_nowMP} / ${user_info.user_maxMP}</div>
    					</div>
    				</td>
				</tr>
				
				<tr>	<th>送穣</th>		<td>${exp_info.user_job }</td>			</tr>
				<tr>	<th>寿恵亀</th>	<td>${exp_info.user_jobexp }</td>		</tr>
			</table>
			
			
			<hr style="width:548px;height:0px;border:1px solid skyblue;float:left;margin-top:15px;margin-bottom:10px;"/>
			
			
			<table style="height:128px;width:300px;float:left;text-align: center;margin-left: 20px;">
				<tr>	<th style="width:50px">巷奄</th><td>${user_weapon.item_name }</td>		</tr>
				<tr>	<th>号嬢姥</th><td>${user_armor.item_name }</td>	</tr>
				<tr>	<th>舌重姥</th><td>${user_acce.item_name }</td>	</tr>
			</table>
			
			<!-- user_weapon,user_armor,user_acce -->
			<table style="height:128px;width:210px;float:right;text-align: center;margin-left: 10px">
				<tr>	<th style="width:50px">因維径</th><td>${user_info.user_att } + ${user_weapon.item_att }</td>	</tr>
				<tr>	<th>号嬢径</th><td>${user_info.user_def } + ${user_armor.item_att }</td>	</tr>
				<tr>	<th>紗亀</th><td>${user_info.user_spe } + ${user_acce.item_att }</td>		</tr>
			</table>
			
			
		</div>
		
		
		
		
		
		
		
		
			<hr style="width:0px;height:298px;border:1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		<!-- 戚疑拝 員 -->
		<div style="background-color:#ffffff;height:300px;width:348px;float:left;">
			
			<br>
			
			<table style="height:250px;width:330px;text-align: center;"><tr><td>
				<label>紫撹馬奄</label></td>
				<td>
				<select class="form-control" id="hunt_menu">
					<option value=1>神舛酔税 増</option>
					<option value=2>廃虞企俳嘘</option>
					<option value=3>沿疑硲税 嘘呪叔</option>
				</select></td>
				<td><input type="button" value="戚疑" class="btn btn-outline-secondary" onclick="move_hunt()"></td></tr>
				
			
				<tr><td>
				<label>政煽舛左</label></td>
				<td>
				<select class="form-control" id="user_menu">
					<option value=1>蝶遣斗 舛左左奄</option>
					<option value=2>昔坤塘軒</option>
					<option value=3>什迭 壕酔奄</option>
					<option value=4>什迭 竺舛</option>
				</select></td>
				<td><input type="button" value="戚疑" class="btn btn-outline-secondary" onclick="user_menu()"></td></tr>
				
			
			
				<tr><td>
				<label>雌繊</label></td><td>
				<select class="form-control" id="shop_menu">
					<option value=1>巷奄 雌繊</option>
					<option value=2>号嬢姥 雌繊</option>
					<option value=3>舌重姥 雌繊</option>
					<option value=4>社乞念 雌繊</option>
				</select></td>
				<td><input type="button" value="戚疑" class="btn btn-outline-secondary" onclick="shop_menu()"></td></tr>
			
			
				<tr><td>
				<label>畷税獣竺</label></td><td>
				<select class="form-control" id="conveni_menu">
					<option value=1>食淫</option>
					<option value=2>精楳</option>
					<option value=3>送穣社鯵社</option>
					<option value=4>企舌娃</option>
				</select></td>
				<td><input type="button" value="戚疑" class="btn btn-outline-secondary" onclick="move_conveni()"></td></tr>
			</table>
		</div>
		
		
		
			<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		
		
		
		
		<!-- 原聖 舛左 -->
		<div style="background-color:#ffffff;height:300px;width:100%;float:left;">
			<!-- 失爽還 廃原巨 -->
			<div style="width:550px;float:left;">
				<div style="height: 65px"><label style="margin-top: 20px"><b>失爽税 廃原巨</b></label></div>
				<hr style="width:548px;height:0px;border:1px solid skyblue;float:left;margin:auto"/>
				<br>${castle_info.castle_text }
			</div>
			
			
			
			<hr style="width:0px;height:298px;border:1px solid skyblue;float:left;margin:auto"/>
			
			
			
			<!-- 失混 舛左 -->
			<div style="width:348px;float:left; text-align: center;">
				<div style="width:348px;float:left;">
					<div style="height: 65px"><label style="margin-top: 20px"><b>原聖 舛左</b></label>
				</div>
				<hr style="width:346px;height:0px;border:1px solid skyblue;float:left;margin:auto"/>
				
				
				<table style="width: 320px;height: 203px; margin-top: 15px; margin-left: 28px">
					<tr><th style="width: 100px;">失 戚硯</th><td style="width: 248px;">${castle_info.castle_name }</td></tr>
					<tr><th>因維径</th><td>${castle_info.castle_att }</td></tr>
					<tr><th>号嬢径</th><td>${castle_info.castle_def }</td></tr>
					<tr><th>端径</th><td>${castle_info.castle_nowHP } / ${castle_info.castle_maxHP }</td></tr>
				</table>
			</div>
		</div>
		
		
		
		<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		
		<!-- 稽益 -->
		
		
		<div style="background-color:#ffffff;height:350px;width:100%;float:left;">
			<label style="font-weight: bolder;margin: 30px;">厩薦 舛室</label>
			<table class="table">
				<tr><td>ししし 還戚 宋生写柔艦陥!</td><td>益掘?</td></tr>
				<tr><td>ししし 還戚 宋生写柔艦陥!</td></tr>
				<tr><td>ししし 還戚 宋生写柔艦陥!</td></tr>
				<tr><td>ししし 還戚 宋生写柔艦陥!</td></tr>
				<tr><td>ししし 還戚 宋生写柔艦陥!</td></tr>
			</table>
		</div>
	</div>
	
</body>
</html>