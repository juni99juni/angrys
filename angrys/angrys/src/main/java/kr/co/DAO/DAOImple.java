package kr.co.DAO;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.DTO.castleInfoDTO;
import kr.co.DTO.fightEndDTO;
import kr.co.DTO.itemChangeDTO;
import kr.co.DTO.itemInfoDTO;
import kr.co.DTO.monsterDTO;
import kr.co.DTO.userExpDTO;
import kr.co.DTO.userFightDTO;
import kr.co.DTO.userLoginDTO;
import kr.co.DTO.userMoneyDTO;



@Repository
public class DAOImple {
	
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	
	
	public List<userLoginDTO> select_user(){
		
		//System.out.println("in select_user. start");
		
		List<userLoginDTO> user = sqlSession.selectList("select_users");
		
		
		return user;
	}
	
	
	public String ID_overlap_check(String ID) {
		
		
		userLoginDTO result = sqlSession.selectOne("ID_overlap_check", ID);
		
		if(result != null) {
			return "false"; //ㄴㄴ 중복임
		} else {
			return "true";  //ㅎㅎ 써도 됨
		}
		
	}
	
	
	
	public String nickname_overlap_check(String nickname) {
		
		userLoginDTO result = sqlSession.selectOne("nickname_overlap_check", nickname);
		if(result != null) {
			return "false";
		} else {
			return "true";
		}
	}
	
	
	
	public void signup_user_table(userLoginDTO user) {
		
		sqlSession.insert("signup_user_table", user);
	}
	
	public void signup_user_info(userLoginDTO user) {
		sqlSession.insert("signup_user_info", user);
	}
	
	public void signup_user_money(userLoginDTO user) {
		sqlSession.insert("signup_user_money", user);
	}

	public void signup_user_exp(userLoginDTO user) {
		sqlSession.insert("signup_user_exp", user);
	}
	
	
	
	
	public userLoginDTO login(userLoginDTO user) {
		
		return sqlSession.selectOne("login_action", user);
	}
	
	
	
	
	
	
	
	
	
	public String get_nickname(String ID) {
		
		return sqlSession.selectOne("get_nickname", ID);
	}
	
	
	
	
	
	
	
	
	public userFightDTO user_info(String userID) {
		
		userFightDTO user = sqlSession.selectOne("user_info",userID);
		
		return user;
	}
	
	
	
	public monsterDTO monster_info(String monster_name) {
		
		monsterDTO monster = sqlSession.selectOne("monster_table", monster_name);
		
		return monster;
	}
	
	
	
	public userMoneyDTO money_info(String ID) {
		
		userMoneyDTO money = sqlSession.selectOne("money_info", ID);
		
		return money;
	}
	
	public userExpDTO exp_info(String ID) {
		
		userExpDTO exp = sqlSession.selectOne("exp_info", ID);
		
		return exp;
	}
	
	
	
	
	
	//all_save_money, part_save_money, all_out_money, part_out_money
	public void all_save_money(String user_name) {
		sqlSession.update("all_save_money", user_name);
	}
	
	public void part_save_money(userMoneyDTO money) {
		sqlSession.update("part_save_money", money);
	}
	
	public void all_out_money(String user_name) {
		sqlSession.update("all_out_money", user_name);
	}
	
	public void part_out_money(userMoneyDTO money) {
		sqlSession.update("part_out_money", money);
	}
	
	
	
	
	
	public int getGold(String ID) {
		
		int result = sqlSession.selectOne("getGold", ID);
		
		return result;
	}
	
	
	
	
	
	public void root_item(itemInfoDTO result) {
		sqlSession.insert("root_item", result);
	}
	
	
	
	public void set_HPMP(fightEndDTO result) {
		sqlSession.update("set_HPMP", result);
	}
	
	
	
	public void set_gold(fightEndDTO result) {
		sqlSession.update("set_gold", result);
	}
	
	
	public void set_exp(fightEndDTO result) {
		sqlSession.update("set_exp", result);
	}
	
	
	
	public void heal(userMoneyDTO money) {
		sqlSession.update("heal_money", money);
		sqlSession.update("heal_user", money.getUser_name());
	}
	
	
	//아이템의 정보
	public itemInfoDTO item_info(int item_no) {
		
		itemInfoDTO item = sqlSession.selectOne("get_item_info", item_no);
		
		return item;
	}
	
	
	//유저 아이템 개수
	public int user_item_count(String ID) {
		return sqlSession.selectOne("user_item_count", ID);
	}
	
	
	
	
	
	public itemInfoDTO pk_item_info(int pk_no) {
		itemInfoDTO item = sqlSession.selectOne("pk_item_info", pk_no);
		
		return item;
	}
	
	
	
	public List<itemInfoDTO> get_item_list(){
		
		List<itemInfoDTO> item_list = sqlSession.selectList("get_item_list");
		
		return item_list;
	}
	
	
	//유저가 소유한 아이템 불러오기
	public List<itemInfoDTO> get_item_no(String ID) {
		return sqlSession.selectList("user_item_num_list", ID);
	}
	
	
	public itemInfoDTO get_user_item(int item_no){
		return sqlSession.selectOne("get_item_info", item_no);
	}
	
	
	public List<itemInfoDTO> shop_item_list(String location){
		return sqlSession.selectList("shop_item_list", location);
	}
	
	
	
	
	//buy_item_gold, buy_item_add, sell_item_gold, sell_item_del
	//아이템 사기
	public void buy_item_gold(userMoneyDTO money) {
		sqlSession.update("buy_item_gold", money);
	}
	
	public void buy_item_add(itemInfoDTO item) {
		sqlSession.insert("buy_item_add", item);
	}
	
	
	
	//아이템 팔기
	public void sell_item_gold(userMoneyDTO money) {
		sqlSession.update("sell_item_gold", money);
	}
	
	public void sell_item_del(int pk_no) {
		sqlSession.insert("sell_item_del", pk_no);
	}
	
	
	
	//성 정보 얻기
	public castleInfoDTO get_castle_info() {
		
		return sqlSession.selectOne("get_castle_info");
	}
	
	
	
	
	//DB에 로그 남기기
	public void save_log(String log_text) {
		sqlSession.insert("save_log", log_text);
	}
	
	
	
	
	
	
	
	//아이템 카테고리 확인하기
	public String item_category_check(int pk_no) {
		return sqlSession.selectOne("item_category_check", pk_no);
	}
	
	
	
	//아이템 교체 전 정보 받기
	public itemInfoDTO category_equip_item_check(itemInfoDTO item) {
		
		return sqlSession.selectOne("category_equip_item_check", item);
	}
	
	
	
	
	//인벤토리 아이템 장착하기
	public void equipment_on(itemInfoDTO item) {
		sqlSession.update("equipment_on", item);
	}
	//장착한 아이템 인벤토리에서 제거
	public void equip_item_delete(int pk_no) {
		sqlSession.delete("equip_item_delete", pk_no);
	}
	
	
	//장착 아이템 인벤토리로 옮기기
	public void equipment_off(itemInfoDTO item) {
		sqlSession.insert("equipment_off", item);
	}
	
	
	public String get_item_name(int item_no) {
		return sqlSession.selectOne("get_item_name", item_no);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String test_table(Map<String, String> create_table) {
		String test = sqlSession.selectOne("test", create_table);
		
		return test;
	}
	
	
	
	
}
