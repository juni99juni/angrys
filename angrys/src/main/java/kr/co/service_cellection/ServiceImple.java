package kr.co.service_cellection;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.DAO.DAOImple;
import kr.co.DTO.fightDTO;
import kr.co.DTO.fightEndDTO;
import kr.co.DTO.itemInfoDTO;
import kr.co.DTO.monsterDTO;
import kr.co.DTO.userExpDTO;
import kr.co.DTO.userFightDTO;
import kr.co.DTO.userLoginDTO;
import kr.co.DTO.userMoneyDTO;

@Repository
public class ServiceImple {
	
	@Autowired
	DAOImple dao;
	
	
	
	//연습용
	public List<userLoginDTO> select_user(){
		
		
		return dao.select_user();
	}
	
	
	
	
	//회원가입 처리
	public void signup(userLoginDTO user) {
		
		dao.signup(user);
	}
	
	
	
	//로그인 아이디, 비밀번호 체크
	public boolean login(userLoginDTO user) {
		userLoginDTO me = dao.login(user);
		
		
		if(me != null) {
			//아이디, 비밀번호가 일치할 시
			return true;
		}else {
			//아이디, 비밀번호가 일치하지 않을 시
			return false;
		}
		
	}
	
	
	
	
	
	
	
	
	
	public String get_nickname(String ID) {
		
		
		return dao.get_nickname(ID);
	}
	
	
	
	public userFightDTO user_info(String ID) {
		return dao.user_info(ID);
	}
	
	public monsterDTO monster_info(String monster_name) {
		return dao.monster_info(monster_name);
	}
	
	
	
	public userMoneyDTO money_info(String ID) {
		return dao.money_info(ID);
	}
	
	
	public userExpDTO exp_info(String ID) {
		return dao.exp_info(ID);
	}
	
	
	
	
	
	
	
	
	public ArrayList<fightDTO> hunt_map(String monster_name, String userID) {
		//몬스터 정보랑 유저 정보 넘겨주어야함
		
		//String monster_name = MonsterName(map);
		userFightDTO user = dao.user_info(userID);
		monsterDTO mon = dao.monster_info(monster_name);
		
		int user_HP = user.getUser_nowHP();
		int mon_HP = mon.getMonster_maxHP();
		int user_MP = user.getUser_nowMP();
		int mon_MP = mon.getMonster_maxMP();
		
		ArrayList<fightDTO> fight = new ArrayList<fightDTO>();
		//System.out.println("user.getEquip_weapon() : " + user.getEquip_weapon());
		//System.out.println("item_info(user.getEquip_weapon()).getItem_att() : " + item_info(user.getEquip_weapon()).getItem_att());
		
		int user_waepon_att = item_info(user.getEquip_weapon()).getItem_att();
		int user_armor_att = item_info(user.getEquip_armor()).getItem_att();
		int user_accessory_att = item_info(user.getEquip_accessory()).getItem_att();
		
		
		
		while(true) {
			
			
			if((user.getUser_spe()-mon.getMonster_spe()) >= 0) {  //유저의 속도가 더 빨랐을 경우
				
				//싸움 정보를 담을 DTO 세팅
				fightDTO user_dto = new fightDTO();
				fightDTO mon_dto = new fightDTO();
				
				ArrayList<Integer> user_dmgList = new ArrayList<Integer>();
				ArrayList<Integer> monster_dmgList = new ArrayList<Integer>();
				
				
				
				
				for(int i=0; i<=user.getUser_spe()+user_accessory_att; i += 100) {
					//데미지 산정
					int result = (int)(Math.random() * user.getUser_spe()) + (((user.getUser_att()/2)+user_waepon_att) - (mon.getMonster_def()/4));
					if(result <=0) result = 1;
					
					user_dmgList.add(result);  //데미지 결과 저장
					mon_HP -= result;  //데미지 입음
				}
				
				user_dto.setNowHP(mon_HP);
				user_dto.setDmg(user_dmgList);  //fightDTO 에 데미지 리스트를 넣음
				user_dto.setWhois(user.getNick_name());  //user가 공격했음을 알림
				
				
				
				//전투 종료
				if(mon_HP <= 0) {  //몬스터가 죽었다면
					user_dto.setNowHP(0);
					user_dto.setWin(true);
					user_dto.setRoot_item(fight_win(user_HP, user_MP, mon, userID));
					fight.add(user_dto);
					break;
				}
				
				fight.add(user_dto);  //해당 dto를 List로 감쌌다.
				
				
				
				
				
				
				for(int i=0; i<=mon.getMonster_spe(); i += 100) {
					int result = (int)(Math.random() * user.getUser_spe()) + ((mon.getMonster_att()/2) - ((user.getUser_def() + user_armor_att)/4));
					if(result <=0) result = 1;
					monster_dmgList.add(result);
					user_HP -= result;
				}
				
				mon_dto.setNowHP(user_HP);
				mon_dto.setDmg(monster_dmgList);  //fightDTO 에 데미지 리스트를 넣음
				mon_dto.setWhois(mon.getMonster_name()); //monster가 공격했음을 알림
				
				
				//System.out.println("user_HP : " + user_HP);
				//전투 종료
				if(user_HP <= 0) {  //유저가 죽었다면
					mon_dto.setNowHP(0);
					mon_dto.setWin(true);
					fight.add(mon_dto);
					break;
				}
				fight.add(mon_dto);  //해당 dto를 List로 감쌌다.
				
				
				
				
				
				
			} else {  //몬스터의 속도가 더 빨랐을 경우
				ArrayList<Integer> user_dmgList = new ArrayList<Integer>();
				ArrayList<Integer> monster_dmgList = new ArrayList<Integer>();
				
				fightDTO user_dto = new fightDTO();
				fightDTO mon_dto = new fightDTO();
				
				
				for(int i=0; i<=mon.getMonster_spe(); i += 100) {
					int result = (int)(Math.random() * user.getUser_spe()) + ((mon.getMonster_att()/2) - ((user.getUser_def() + user_armor_att)/4));
					if(result <=0) result = 1;
					monster_dmgList.add(result);
					user_HP -= result;
				}
				
				mon_dto.setNowHP(user_HP);
				mon_dto.setDmg(monster_dmgList);  //fightDTO 에 데미지 리스트를 넣음
				mon_dto.setWhois(mon.getMonster_name()); //monster가 공격했음을 알림
				
				
				
				//전투 종료
				if(user_HP <= 0) {  //유저가 죽었다면
					mon_dto.setNowHP(0);
					mon_dto.setWin(true);
					fight.add(mon_dto);
					break;
				}
				fight.add(mon_dto);  //해당 dto를 List로 감쌌다.
				
				
				
				
				
				
				for(int i=0; i<=user.getUser_spe()+user_accessory_att; i += 100) {
					int result = (int)(Math.random() * user.getUser_spe()) + (((user.getUser_att()/2)+user_waepon_att) - (mon.getMonster_def()/4));
					if(result <=0) result = 1;
					user_dmgList.add(result);
					mon_HP -= result;
				}
				
				user_dto.setNowHP(mon_HP);
				user_dto.setDmg(user_dmgList);  //fightDTO 에 데미지 리스트를 넣음
				user_dto.setWhois(user.getNick_name()); //user가 공격했음을 알림
				
				
				//전투 종료
				if(mon_HP <= 0) {  //몬스터가 죽었다면 
					user_dto.setNowHP(0);
					user_dto.setWin(true);
					user_dto.setRoot_item(fight_win(user_HP, user_MP, mon, userID));
					fight.add(user_dto);
					break;
				}
				
				fight.add(user_dto);  //해당 dto를 List로 감쌌다.
			}
			
			
		}
		
		
		
		return fight;
	}
	
	
	
	public String MonsterName(int map) {
		
		Random ran = new Random(); 
		int monsterRan = ran.nextInt(2);
		String monster_name = null;
		
		//System.out.println("moster_random_number : " + monsterRan);
		
		if(map == 1) {
			if(monsterRan == 1) {
				monster_name = "늑대";
			} else {
				monster_name = "늑대";
			}
		}
		
		else if(map == 2) {
			if(monsterRan == 1) {
				monster_name = "조교";
			} else {
				monster_name = "김순석";
			}
		}
		
		else if(map == 3) {
			if(monsterRan == 1) {
				monster_name = "김동호";
			} else {
				monster_name = "오야야";
			}
		}
		
		//System.out.println("service monster_name : " + monster_name);
		
		return monster_name;
	}
	
	
	
	
	
	
	public itemInfoDTO item_info(int item_no) {
		
		itemInfoDTO item = dao.item_info(item_no);
		
		return item;
	}
	
	
	
	
	
	
	
	public String fight_win(int HP, int MP, monsterDTO monster, String userID) {
		
		fightEndDTO result = new fightEndDTO();
		itemInfoDTO item_result = get_item();
		
		//아이디 세팅
		result.setUser_name(userID);
		
		//루트 아이템 세팅
		result.setItem_result(item_result.getItem_no());
		
		//아이템 루팅
		if(item_result.getItem_no() != 0) {
			dao.root_item(result);
		}
		
		
		//HP,MP 세팅
		result.setHP(HP);
		result.setMP(MP);
		
		dao.set_HPMP(result);
		
		
		//골드, 경험치, 숙련도 획득
		result.setMoney(monster.getMonster_gold());
		dao.set_gold(result);
		
		System.out.println("monster.getMonster_exp()" + monster.getMonster_exp());
		result.setExp(monster.getMonster_exp());
		result.setJobexp(monster.getMonster_jobexp());
		dao.set_exp(result);
		
		
		if(item_result.getItem_no() != 0) {
			return item_result.getItem_name();
		} else {
			return "";
		}
	}
	
	
	
	
	public fightEndDTO fight_lose(int HP, int MP, String userID) {
		
		fightEndDTO result = new fightEndDTO();
		
		
		result.setHP(HP);
		result.setHP(MP);
		
		dao.set_HPMP(result);
		
		
		result.setMoney(getGold(userID)/2);
		
		dao.set_gold(result);
		
		
		return result;
	}
	
	
	
	
	
	public itemInfoDTO get_item() {
		//int result = 0;
		itemInfoDTO item = new itemInfoDTO(); 
		
		if(((int)(Math.random() * 100 )+1) == 100) {
			List<itemInfoDTO> item_list =  dao.get_item_list();
			
			item = item_list.get((int)(Math.random() * item_list.size())+1);
			//result = item.getItem_no();
			
			System.out.println("item random no : " + (int)(Math.random() * item_list.size())+1);
			//System.out.println("item no : " + result);
		}
		
		
		return item;
		
	}
	
	
	
	
	
	
	
	
	
	
	public int getGold(String ID) {
		//nowMoney를 알려주는 메소드
		int result = dao.getGold(ID);
		
		System.out.println("result : " + result);
		
		return result;
	}
	
	
	public void heal(String ID) {
		userMoneyDTO money = new userMoneyDTO();
		
		int nowMoney = getGold(ID) / 10;
		money.setNow_money(nowMoney);
		money.setUser_name(ID);
		
		dao.heal(money);
	}
	
	
	
	
	
	
	
	
	//all_save_money, part_save_money, all_out_money, part_out_money
	public void use_bank(int value, int money, String ID) {
		userMoneyDTO moneyDTO = new userMoneyDTO();
		
		moneyDTO.setUser_name(ID);
		moneyDTO.setNow_money(money);
		
		
		if(value==1) {
			dao.all_save_money(ID);
		} else if(value==2) {
			dao.part_save_money(moneyDTO);
		} else if(value==3) {
			dao.all_out_money(ID);
		} else if(value==4) {
			dao.part_out_money(moneyDTO);
		}
	}
}
