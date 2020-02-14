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
		
		
		
		
		$(document).ready(function(){
			 
			if(${auto_check} == true){
				$("#move_auto").prop("checked", true);
				$('#move_text').text('5초뒤 이동합니다.');
				
				setTimeout(function(){
					
					location.href='hunt?map_level=${map_level}&auto=true';
				},5000);
				/* 
				if($("#move_auto").is('checked')==false){
					$('#move_text').text('');
					return false;
				}
				 */
			}else{
				$("#move_auto").prop("checked", false);
				$('#move_text').text('');
				
			}
			
			
			setTimeout(function() {
				$('#butt').attr('disabled', false);
			}, 5000);
			
			 
			$("#move_auto").on('click',function(){
				
				if($(this).prop('checked')){
					$('#move_text').text('5초뒤 이동합니다.');
					
					setTimeout(function(){
						/* 
						if($("#move_auto").is('checked')==false){
							$('#move_text').text('');
							return false;
						}
						 */
						location.href='hunt?map_level=${map_level}&auto=true';
					},5000);				
				} else{
					$('#move_text').text('');
					return false;
				}
				
			});
			
			/* 
			$("#move_label").on('click',function(){
				
				if($("#move_auto").prop('checked')){
					$('#move_text').text('5초뒤 이동합니다.');
					
					setTimeout(function(){
						location.href='hunt?map_level=${map_level}&auto=true';
					},5000);				
				}
				
			});
			 */
			
		});
		 
		
		
		
	</script>
	
<body>
	
	
	<c:set var="memID" value="${memID}" scope="session"/>
	<c:if test="${empty sessionScope.memID }">
		<script type="text/javascript">
			alert("서비스를 즐기시려면 로그인이 필요합니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=login">
	</c:if>
	
	
	
	<div align="center" style="margin:0 auto;width: 900px;" >
	
		<div align="center" style="background-color: skyblue;font-size: 50px;">
			<div style="width:220px; color: white; cursor: pointer;" onclick="location.href='main'">ANGRY'S</div>
		</div>
		
		
		<!-- 유저 정보 -->
		<div style="height: 200px; width: 449px; background-color: white; float: left;">
			<label style="font-weight: bolder; margin-top: 15px;">${user_info.nick_name }</label>
			
			<div>
				<table class="table" style="width:220px;float:left;">
					<tr style="font-size: 12px"><th>무기류</th><td> - </td></tr>
					<tr style="font-size: 12px"><th>방어구</th><td> - </td></tr>
					<tr style="font-size: 12px"><th>장신구</th><td> - </td></tr>
					<tr style="font-size: 12px"><th></th><td></td></tr>
				</table>
				
				<table class="table" style="width:220px;float:right;">
					<tr style="font-size: 12px"><th>공격력</th><td>${user_info.user_att }</td></tr>
					<tr style="font-size: 12px"><th>방어력</th><td>${user_info.user_def }</td></tr>
					<tr style="font-size: 12px"><th>스피드</th><td>${user_info.user_spe }</td></tr>
					<tr style="font-size: 12px"><th></th><td></td></tr>
				</table>
			</div>
		</div>
		
		<hr style="width:0px;height:198px;border:1px solid skyblue;float:left;margin:auto"/>
		
		<!-- 몬스터 정보 -->
		<div style="height: 200px; width: 449px; background-color: white; float: left;">
			<label style="font-weight: bolder; margin-top: 15px;">${monster_info.monster_name }</label>
			
			<div>
				<table class="table" style="width:220px;float:left;">
					<tr style="font-size: 12px"><th>무기류</th><td> - </td></tr>
					<tr style="font-size: 12px"><th>방어구</th><td> - </td></tr>
					<tr style="font-size: 12px"><th>장신구</th><td> - </td></tr>
					<tr style="font-size: 12px"><th></th><td></td></tr>
				</table>
				
				<table class="table" style="width:220px;float:right;">
					<tr style="font-size: 12px"><th>공격력</th><td>${monster_info.monster_att }</td></tr>
					<tr style="font-size: 12px"><th>방어력</th><td>${monster_info.monster_def }</td></tr>
					<tr style="font-size: 12px"><th>스피드</th><td>${monster_info.monster_spe }</td></tr>
					<tr style="font-size: 12px"><th></th><td></td></tr>
				</table>
			</div>
		</div>
		
		
			<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>
		
		
		<c:set var="turn" value="0"/>
		<c:set var="turn_bar" value="1"/>
		
		<% 
			//int user_HP, monster_HP;
			//userFightDTO user = (userFightDTO)request.getAttribute("user_info");
			//monsterDTO monster = (monsterDTO)request.getAttribute("monster_info");
		%>
		
		<c:set var="user_HP" value="${user_info.user_nowHP }"/>
		<c:set var="user_MP" value="${user_info.user_nowMP }"/>
		<c:set var="monster_HP" value="${monster_info.monster_nowHP }"/>
		<c:set var="monster_MP" value="${monster_info.monster_nowMP }"/>
		
		
		
		<%-- <c:out value="${(user_HP/user_info.user_maxHP)*100 }"/> --%>
		<c:forEach var="fight" items="${fight }">
			<%-- <c:set target="${turn }" value="${turn +1 }"/> --%>
			
			<c:set var="user_HP_percent" value="${(user_HP/user_info.user_maxHP)*100 }"/>
			<c:set var="user_MP_percent" value="${(user_MP/user_info.user_maxMP)*100 }"/>
			<c:set var="monster_HP_percent" value="${(monster_HP/monster_info.monster_maxHP)*100 }"/>
			<c:set var="monster_MP_percent" value="${(monster_MP/monster_info.monster_maxMP)*100 }"/>
			
			<!-- 턴 횟수 알려주기 -->
			<c:set var="turn" value="${turn+1 }"/>
			
			<div style="float: top;margin:auto">
				<c:if test="${ (turn mod 2) == 1 }">
					<c:if test="${turn_bar ne 1 }">
						<br>
						<%-- <%user_HP=%>${fight.nowHP}<%;
						
						monster_HP = monster.getMonster_maxHP();
						%> --%>
						<!-- 체력 현황 -->
						<div style="width: 100%; float:left; margin-bottom: 20px; margin-top:20px;">
							<div style="width:300px; float:left; margin-left:50px;">
								<div class="progress">
									<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  										aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${user_HP_percent}%">
    									${user_HP} / ${user_info.user_maxHP}</div>
    							</div>
    							<div class="progress">
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  										aria-valuemin="0" aria-valuemax="100" style="width:${user_MP_percent}%">
										${user_MP} / ${user_info.user_maxMP}</div>
    							</div>
							</div>
							
							
							
							<div style="width:300px; float:right;margin-right:50px;">
								<div class="progress">
									<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  										aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${monster_HP_percent}%">
    									${monster_HP} / ${monster_info.monster_maxHP}</div>
    							</div>
    							<div class="progress">
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  										aria-valuemin="0" aria-valuemax="100" style="width:${monster_MP_percent}%">
										${monster_MP} / ${monster_info.monster_maxMP}</div>
    							</div>
							</div>
						</div>
						<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:auto"/>	
					</c:if>
					
					<label style="margin-top: 5px;"><c:out value="${turn_bar }"/> 턴 시작</label>
					<hr style="height:0px;width:898px;border: 1px solid skyblue;float:top;margin:auto"/>
					<c:set var="turn_bar" value="${turn_bar+1 }"/>
				</c:if>
			</div>
			
			
			
			<!-- 싸움 정보 출력 -->
			<div style="background-color: white; width: 900px;float:left; margin:auto;">
			<br>
				<!-- 유저가 공격할 때 -->
				<c:if test="${fight.whois eq user_info.nick_name }">
					<div style="text-align: left;">
						<img src="${pageContext.request.contextPath }/resources/${img}" style="float: left;">
						<label style="margin-left:30px;">${fight.whois }의 ${fn:length(fight.dmg)} 회 공격!</label><br>
						
						
						<!-- DTO 내의 dmg list -->
						<div style="text-align: left; width: 400px;float: left;">
							<c:forEach var="dmg" items="${fight.dmg }">
								<label style="margin-left:30px">${fight.whois}의 기본 공격! ${dmg } 데미지를 입혔다.</label><br>
							</c:forEach>
						</div>
						<c:set var="monster_HP" value="${fight.nowHP }"/>
					</div>
				</c:if>
				
				
				
				<!-- 몬스터의 공격 -->
				<c:if test="${fight.whois eq monster_info.monster_name }">
					<div style="text-align: right; margin:auto;">
						<img src="${pageContext.request.contextPath }/resources/${img}" style="float: right;">
						<label style="margin-right:30px">${fight.whois }의 ${fn:length(fight.dmg)} 회 공격!</label><br>
						
						
						<!-- DTO 내의 dmg list에서 데미지를 뽑아낸다. -->
						<div>
							<c:forEach var="dmg" items="${fight.dmg }">
								<label style="margin-right:30px">${fight.whois}의 기본 공격! ${dmg } 데미지를 입혔다.</label><br>
							</c:forEach>
						</div>
						<c:set var="user_HP" value="${fight.nowHP }"/>
					</div>
				</c:if>
				
				
				
				
				
				
				
				
				
				<!-- 전투 결과 -->
				<c:if test="${fight.win eq true }"><br>
					<div style="width:100%; float:left;"><b>${fight.whois }는 승리했다!</b></div><br>
					<div style="width: 100%; float:left; margin-bottom: 20px; margin-top:20px;">
							<div style="width:300px; float:left; margin-left:50px;">
								<div class="progress">
									<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  										aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${user_HP_percent}%">
    									${user_HP} / ${user_info.user_maxHP}</div>
    							</div>
    							<div class="progress">
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  										aria-valuemin="0" aria-valuemax="100" style="width:${user_MP_percent}%">
										${user_MP} / ${user_info.user_maxMP}</div>
    							</div>
							</div>
							
							
							
							<div style="width:300px; float:right;margin-right:50px;">
								<div class="progress">
									<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50"
  										aria-valuemin="0" aria-valuemax="100" style="background-color:red; width:${monster_HP_percent}%">
    									${monster_HP} / ${monster_info.monster_maxHP}</div>
    							</div>
    							<div class="progress">
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
  										aria-valuemin="0" aria-valuemax="100" style="width:${monster_MP_percent}%">
										${monster_MP} / ${user_info.user_maxMP}</div>
    							</div>
							</div>
						</div>
						<hr style="height:0px;width:898px;border: 1px solid skyblue;float:left;margin:0 auto"/>	
					<br>
					<c:if test="${fight.whois eq user_info.nick_name }">
						<div style="width: 750px;height: 200px;text-align: center;margin-top: 200px;
						border: 1px solid skyblue;">
							<div style="width: 30%;height:100%;background-color: white; border: 1px solid skyblue; float: left;margin:0 auto">
								<div style="margin: 70px 10px 70px 10px;width:200px ;height: 50px"><label>전투결과<br>승리!</label></div>
							</div>
							<div style="width: 70%;height:100%;background-color: white; border: 1px solid skyblue; float: right">
								<div style="margin: 45px 70px 45px 70px">
									<label>${monster_info.monster_gold } 골드를 획득했다!</label><br>
									<label>${monster_info.monster_exp } 경험치를 획득했다!</label><br>
									<label>${monster_info.monster_jobexp } 숙련도를 획득했다!</label><br>
									<c:if test="${!empty fight.root_item }">
										<label><b>${fight.root_item }</b> 을 획득했다!</label>
									</c:if>
								</div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${fight.whois eq monster_info.monster_name }">
						<div style="width: 750px;height: 200px;text-align: center;margin-top: 150px;
						border: 1px solid skyblue">
							<div style="width: 30%;height:100%;background-color: white; border: 1px solid skyblue; float: left;margin:0 auto">
								<div style="margin:0 auto"><label>전투결과<br>패배...</label></div>
							</div>
							<div style="width: 70%;height:100%;background-color: white; border: 1px solid skyblue; float: right">
								소지한 골드의 절반인 ${user_info.user_now_gold } 골드를 잃었습니다.<br>
								여관에서 치유하시는것을 추천드립니다.
								
							</div>
						</div>
					</c:if>
					
					<%-- 
					<c:if test="${fight.whois eq monster_info.monster_name }">
						<div style="width: 750px;height: 200px;text-align: center;background-color: skyblue;margin-top: 20px;
						border: 1px solid skyblue">
							<div style="width: 30%;height:100%;background-color: white; border: 1px solid skyblue; float: left;">
								<div style="margin:0 auto"><label>전투결과<br>패배...</label></div>
							</div>
							<div style="width: 70%;height:100%;background-color: white; border: 1px solid skyblue; float: left">
								소지한 골드의 절반인 ${fight_info.gold } 골드를 잃었습니다.<br>
								여관에서 치유하시는것을 추천드립니다.
								
							</div>
						</div>
					</c:if>
					 --%>
					
				</c:if>
				
				
				<br>
			</div>
			
		</c:forEach>
		
	
		<input type="checkbox" id="move_auto"><label id="move_label" name="move_label">자동으로 이동하기</label><br>
		<label id="move_text"></label><br>
		<input class="btn btn-outline-secondary" type="button" value="전투하기" size="20" id="butt" disabled="disabled" onclick="location.href='hunt?map_level=${map_level}&auto=false'">
		<input class="btn btn-outline-secondary" type="button" value="메인으로" size="20" onclick="location.href='main'">
		<input class="btn btn-outline-secondary" type="button" value="여관으로" size="20" onclick="location.href='motel'">
		<input type="hidden" value="${auto_check }" name="auto_check" id="auto_check">	
		<br><br>
		
		
		
		<div style="text-align: center; background-color: #DDDDDD; height: 200px;">
			서울특별시 종로구 종로12길 15, 5층(관철동 13-13)           대표전화: 1544-0714          교육담당: 전형후
		</div>
		
	</div>
	
	
	

	
	
</body>
</html>