package kr.co.service_cellection;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.DAO.DAOImple;
import kr.co.DTO.castleInfoDTO;
import kr.co.DTO.fightDTO;
import kr.co.DTO.fightEndDTO;
import kr.co.DTO.itemChangeDTO;
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
		//만들어야 할 테이블 - user_table, user_info, user_money, user_exp
		dao.signup_user_table(user);  //user_table, 기본 로그인 테이블
		
		dao.signup_user_info(user);
		
		dao.signup_user_money(user);
		
		dao.signup_user_exp(user);
		
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
		itemInfoDTO item_result = get_item(userID);
		String item_name = item_result.getItem_name();
		
		//아이디 세팅
		result.setUser_name(userID);
		
		//루트 아이템 세팅
		result.setItem_result(item_result.getItem_no());
		
		//아이템 루팅
		item_result.setItem_name(userID);
		if(item_result.getItem_no() != 0) {
			dao.root_item(item_result);
		}
		
		
		
		//HP,MP 세팅
		result.setHP(HP);
		result.setMP(MP);
		
		dao.set_HPMP(result);
		
		
		//골드, 경험치, 숙련도 획득
		result.setMoney(monster.getMonster_gold());
		dao.set_gold(result);
		
		
		result.setExp(monster.getMonster_exp());
		result.setJobexp(monster.getMonster_jobexp());
		dao.set_exp(result);
		
		
		if(item_result.getItem_no() != 0 && item_result.getItem_category() != "potion") {
			return item_name;
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
	
	
	
	
	//아이템 루트 획득
	public itemInfoDTO get_item(String ID) {
		//int result = 0;
		itemInfoDTO item = new itemInfoDTO();
		
		Random ran = new Random(); 
		int monsterRan = ran.nextInt(2);
		
		if(dao.user_item_count(ID) <= 20) {
			
			
			if(((int)(Math.random() * 100 )+1) < 100) {
				List<itemInfoDTO> item_list =  dao.get_item_list();
				
				item = item_list.get(ran.nextInt(item_list.size()));
				//result = item.getItem_no();
				
				System.out.println("item random no : " + ran.nextInt(item_list.size()));
				//System.out.println("item no : " + result);
			}
		}
		
		
		
		return item;
		
	}
	
	
	
	
	
	
	
	
	
	//nowMoney를 알려주는 메소드
	public int getGold(String ID) {
		
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
	
	
	
	
	
	
	
	
	//은행 돈 처리
	public void use_bank(int value, int money, String ID) {
		userMoneyDTO moneyDTO = new userMoneyDTO();
		
		moneyDTO.setUser_name(ID);
		moneyDTO.setNow_money(money);
		
		
		if(value==1) {  //전액 저금
			dao.all_save_money(ID);
		} else if(value==2) {  //부분 저금
			dao.part_save_money(moneyDTO);
		} else if(value==3) {  //전액 출금
			dao.all_out_money(ID);
		} else if(value==4) {  //부분 출금
			dao.part_out_money(moneyDTO);
		}
	}
	
	
	
	
	
	
	//유저 인벤토리에 있는 아이템 리스트
	public List<itemInfoDTO> user_item_list(String ID){
		/*
		List<itemInfoDTO> item_list = new ArrayList<itemInfoDTO>();
		List<Integer> item_num_list = dao.get_item_no(ID);
		*/
		List<itemInfoDTO> item_list = dao.get_item_no(ID);
		
		
		//for(int i=0; i<item_num_list.size(); i++) {
		for(int i=0; i<item_list.size(); i++) {
			//item_list.add(dao.get_user_item(item_num_list.get(i)));
			itemInfoDTO item = dao.get_user_item(item_list.get(i).getItem_no());
			
			item_list.get(i).setItem_name(item.getItem_name());
			item_list.get(i).setItem_att(item.getItem_att());
			item_list.get(i).setItem_wei(item.getItem_wei());
			item_list.get(i).setPrice(item.getPrice()/2);
			
			
			//System.out.println("item_list.get : " + item_list.get(i));
			//System.out.println("item_name : " + item_list.get(i).getItem_name());
			//System.out.println("item_price : " + item_list.get(i).getPrice());
		}
		
		
		
		return item_list;
	}
	
	
	
	
	//상점 아이템 목록 출력
	public List<itemInfoDTO> shop_item_list(String location){
		
		List<itemInfoDTO> item_list = new ArrayList<itemInfoDTO>();
		item_list = dao.shop_item_list(location);
		
		
		return item_list;
	}
	
	
	
	
	
	
	//buy_item_gold, buy_item_add, sell_item_gold, sell_item_del
	
	//상점에서 물품 구매
	public void shop_item_buy(String ID, int item_no) {
		//골드 증감 - 골드, ID
		userMoneyDTO money = new userMoneyDTO();
		money.setNow_money(dao.item_info(item_no).getPrice());
		money.setUser_name(ID);
		dao.buy_item_gold(money);
		
		
		//아이템 얻기 - 유저 이름(아이템 이름에 넣기), 아이템 번호
		itemInfoDTO item = new itemInfoDTO();
		/*
		item.setItem_name(ID);
		item.setItem_no(item_no);//구매한 아이템 번호
		item.setItem_category(dao.item_info(item_no).getItem_category());
		*/
		//이럴거면 그냥 item_info로 아이템 정보 싹 다 긁어오는게 낫지않냐?
		//item_name만 user_name으로 바꿔주고
		item = dao.item_info(item_no);
		item.setItem_name(ID);
		System.out.println("item.getItemCategory : " + item.getItem_category());
		//dao.item_info(item_no);
		dao.buy_item_add(item);
	}
	
	
	//상점에서 아이템 판매
	public void user_item_sell(String ID, int pk_no) {
		//골드 증감 - 골드, ID
		userMoneyDTO money = new userMoneyDTO();
		money.setNow_money(dao.item_info(dao.pk_item_info(pk_no).getItem_no()).getPrice()/2);
		money.setUser_name(ID);
		dao.sell_item_gold(money);
		
		
		//아이템 팔기 - pk_no
		dao.sell_item_del(pk_no);
	}
	
	
	
	//성 정보를 얻음
	public castleInfoDTO get_castle_info() {
		
		return dao.get_castle_info();
	}
	
	
	
	
	
	
	
	
	
	//아이템 교체
	public void equip_item_change(int pk_no, String user_name) {
		
		//pk_no을 가져와서 해당 아이템의 카테고리를 불러와 교체할 equip item의 정보 가져옴 (equip_item의 info = item_no, pk_no)
		
		itemInfoDTO inventory_item_info = dao.pk_item_info(pk_no);  //인벤토리 아이템
		inventory_item_info.setUser_name(user_name);
		inventory_item_info.setPk_no(pk_no);
		
		
		itemInfoDTO equipment_item_info = dao.category_equip_item_check(inventory_item_info);  //장착한 아이템
		equipment_item_info.setUser_name(user_name);
		
		equipment_item_info.setItem_category(inventory_item_info.getItem_category());
		
		
		//인벤토리에 있는 아이템 장착하기
		dao.equipment_on(inventory_item_info);
		System.out.println("inventory_item_info.getPk_no : " + inventory_item_info.getPk_no());
		System.out.println("item pk_no : " + pk_no);
		//장착한 아이템 인벤토리에서 제거
		dao.equip_item_delete(pk_no);
		
		
		//아이템 이름 조사 전 아이템 이름 가져오기... 너무 비효율적인데 정리하고싶다
		equipment_item_info.setItem_name(dao.get_item_name(equipment_item_info.getItem_no()));
		//장비를 끼고있다면? (장비 장착 여부, none 조사)
		if(!equipment_item_info.getItem_name().equals("none")) {
			//장비한 아이템 인벤토리로 옮기기
			dao.equipment_off(equipment_item_info);
		}
		
		
		
		//만약 pk_no 의 category가 weapon이라면 user_info에서 equip_weapon과 weapon_pk_no을 불러온다.
		//
		
		//가져온 e
		
	}
	
	
	
	
	
	//아이템 카테고리 확인
	public boolean item_category_check(int pk_no) {
		
		
		if(!dao.item_category_check(pk_no).equals("potion")) {
			//장착할 수 있는 유형임 (weapon, armor, accessory)
			return true;
		}else {
			//장착할 수 없는 유형임 (포션, 주문서 등등)
			return false;
		}
		
		//return true;
	}
	
}
