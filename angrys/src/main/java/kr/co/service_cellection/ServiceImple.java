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
	
	
	
	//������
	public List<userLoginDTO> select_user(){
		
		
		return dao.select_user();
	}
	
	
	
	
	//ȸ������ ó��
	public void signup(userLoginDTO user) {
		
		dao.signup(user);
	}
	
	
	
	//�α��� ���̵�, ��й�ȣ üũ
	public boolean login(userLoginDTO user) {
		userLoginDTO me = dao.login(user);
		
		
		if(me != null) {
			//���̵�, ��й�ȣ�� ��ġ�� ��
			return true;
		}else {
			//���̵�, ��й�ȣ�� ��ġ���� ���� ��
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
		//���� ������ ���� ���� �Ѱ��־����
		
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
			
			
			if((user.getUser_spe()-mon.getMonster_spe()) >= 0) {  //������ �ӵ��� �� ������ ���
				
				//�ο� ������ ���� DTO ����
				fightDTO user_dto = new fightDTO();
				fightDTO mon_dto = new fightDTO();
				
				ArrayList<Integer> user_dmgList = new ArrayList<Integer>();
				ArrayList<Integer> monster_dmgList = new ArrayList<Integer>();
				
				
				
				
				for(int i=0; i<=user.getUser_spe()+user_accessory_att; i += 100) {
					//������ ����
					int result = (int)(Math.random() * user.getUser_spe()) + (((user.getUser_att()/2)+user_waepon_att) - (mon.getMonster_def()/4));
					if(result <=0) result = 1;
					
					user_dmgList.add(result);  //������ ��� ����
					mon_HP -= result;  //������ ����
				}
				
				user_dto.setNowHP(mon_HP);
				user_dto.setDmg(user_dmgList);  //fightDTO �� ������ ����Ʈ�� ����
				user_dto.setWhois(user.getNick_name());  //user�� ���������� �˸�
				
				
				
				//���� ����
				if(mon_HP <= 0) {  //���Ͱ� �׾��ٸ�
					user_dto.setNowHP(0);
					user_dto.setWin(true);
					user_dto.setRoot_item(fight_win(user_HP, user_MP, mon, userID));
					fight.add(user_dto);
					break;
				}
				
				fight.add(user_dto);  //�ش� dto�� List�� ���մ�.
				
				
				
				
				
				
				for(int i=0; i<=mon.getMonster_spe(); i += 100) {
					int result = (int)(Math.random() * user.getUser_spe()) + ((mon.getMonster_att()/2) - ((user.getUser_def() + user_armor_att)/4));
					if(result <=0) result = 1;
					monster_dmgList.add(result);
					user_HP -= result;
				}
				
				mon_dto.setNowHP(user_HP);
				mon_dto.setDmg(monster_dmgList);  //fightDTO �� ������ ����Ʈ�� ����
				mon_dto.setWhois(mon.getMonster_name()); //monster�� ���������� �˸�
				
				
				//System.out.println("user_HP : " + user_HP);
				//���� ����
				if(user_HP <= 0) {  //������ �׾��ٸ�
					mon_dto.setNowHP(0);
					mon_dto.setWin(true);
					fight.add(mon_dto);
					break;
				}
				fight.add(mon_dto);  //�ش� dto�� List�� ���մ�.
				
				
				
				
				
				
			} else {  //������ �ӵ��� �� ������ ���
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
				mon_dto.setDmg(monster_dmgList);  //fightDTO �� ������ ����Ʈ�� ����
				mon_dto.setWhois(mon.getMonster_name()); //monster�� ���������� �˸�
				
				
				
				//���� ����
				if(user_HP <= 0) {  //������ �׾��ٸ�
					mon_dto.setNowHP(0);
					mon_dto.setWin(true);
					fight.add(mon_dto);
					break;
				}
				fight.add(mon_dto);  //�ش� dto�� List�� ���մ�.
				
				
				
				
				
				
				for(int i=0; i<=user.getUser_spe()+user_accessory_att; i += 100) {
					int result = (int)(Math.random() * user.getUser_spe()) + (((user.getUser_att()/2)+user_waepon_att) - (mon.getMonster_def()/4));
					if(result <=0) result = 1;
					user_dmgList.add(result);
					mon_HP -= result;
				}
				
				user_dto.setNowHP(mon_HP);
				user_dto.setDmg(user_dmgList);  //fightDTO �� ������ ����Ʈ�� ����
				user_dto.setWhois(user.getNick_name()); //user�� ���������� �˸�
				
				
				//���� ����
				if(mon_HP <= 0) {  //���Ͱ� �׾��ٸ� 
					user_dto.setNowHP(0);
					user_dto.setWin(true);
					user_dto.setRoot_item(fight_win(user_HP, user_MP, mon, userID));
					fight.add(user_dto);
					break;
				}
				
				fight.add(user_dto);  //�ش� dto�� List�� ���մ�.
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
				monster_name = "����";
			} else {
				monster_name = "����";
			}
		}
		
		else if(map == 2) {
			if(monsterRan == 1) {
				monster_name = "����";
			} else {
				monster_name = "�����";
			}
		}
		
		else if(map == 3) {
			if(monsterRan == 1) {
				monster_name = "�赿ȣ";
			} else {
				monster_name = "���߾�";
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
		
		//���̵� ����
		result.setUser_name(userID);
		
		//��Ʈ ������ ����
		result.setItem_result(item_result.getItem_no());
		
		//������ ����
		if(item_result.getItem_no() != 0) {
			dao.root_item(result);
		}
		
		
		//HP,MP ����
		result.setHP(HP);
		result.setMP(MP);
		
		dao.set_HPMP(result);
		
		
		//���, ����ġ, ���õ� ȹ��
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
		//nowMoney�� �˷��ִ� �޼ҵ�
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
