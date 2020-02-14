package kr.co.DAO;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.DTO.fightEndDTO;
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
	
	
	public String overlap_check(String ID) {
		
		
		userLoginDTO result = sqlSession.selectOne("overlap_user", ID);
		
		if(result != null) {
			return "false"; //ㄴㄴ 중복임
		} else {
			return "true";  //ㅎㅎ 써도 됨
		}
		
	}
	
	
	
	public void signup(userLoginDTO user) {
		
		sqlSession.insert("insert_user", user);
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
	
	
	
	
	
	public void root_item(fightEndDTO result) {
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
	
	
	public itemInfoDTO item_info(int item_no) {
		
		itemInfoDTO item = sqlSession.selectOne("get_item_info", item_no);
		
		
		
		return item;
	}
	
	
	
	public List<itemInfoDTO> get_item_list(){
		
		List<itemInfoDTO> item_list = sqlSession.selectList("get_item_list");
		
		return item_list;
	}
	
	
	
	
	
	
	
	
	public String test_table(Map<String, String> create_table) {
		String test = sqlSession.selectOne("test", create_table);
		
		return test;
	}
	
	
	
	
}
