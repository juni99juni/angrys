package kr.co.controller_collection;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.DAO.DAOImple;
import kr.co.DTO.fightDTO;
import kr.co.DTO.userFightDTO;
import kr.co.DTO.userLoginDTO;
import kr.co.DTO.userMoneyDTO;
import kr.co.service_cellection.ServiceImple;

@Controller
public class MainController {
	
	@Autowired
	ServiceImple service;
	
	@Autowired
	DAOImple dao;
	
	
	
	
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login_form(Model model) {
		
		return "user_ui/login";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "login_action", method = RequestMethod.POST)
	public String login_action(@RequestParam("ID") String ID, @RequestParam("password") String password, Model model,
				HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		userLoginDTO user = new userLoginDTO();
		
		user.setID(ID);
		user.setPassword(password);
		
		
		boolean result = service.login(user);
		
		if(result == true) {
			
			session.setAttribute("memID", ID);
			
			return "true";
		}
		else {
			return "false";
		}
		
		
	}
	
	
	
	
	

	@RequestMapping(value = "signup", method = RequestMethod.GET)
	public String sign_menu() {
		return "user_ui/signup";
	}
	
	@RequestMapping(value = "signup_action", method = RequestMethod.POST)
	public String sign_action(userLoginDTO user) {
		
		service.signup(user);
		
		return "redirect:select_user";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "overlap_check", method = RequestMethod.GET)
	public String overlap_check(@RequestParam("userID") String userID) {
		//System.out.println("overlap_check insert");
		
		String result =  dao.overlap_check(userID);
		
		//System.out.println("result : " + result);
		return result;
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main_page(HttpServletRequest request, Model model) {
		//유저 정보, 마을정보, 로그 넘겨주기
		
		
		System.out.println("main get session");
		HttpSession session = request.getSession();
		//System.out.println("session.getAttribute");
		String ID = (String) session.getAttribute("memID");
		
		
		
		System.out.println("sessionID : " + ID);
		
		if(ID != null) {
			userFightDTO user_info = service.user_info(ID);
			
			model.addAttribute("user_info", user_info);
			model.addAttribute("money_info", service.money_info(ID));
			model.addAttribute("exp_info", service.exp_info(ID));
			
			
			model.addAttribute("user_weapon", service.item_info(user_info.getEquip_weapon()));
			model.addAttribute("user_armor", service.item_info(user_info.getEquip_armor()));
			model.addAttribute("user_acce", service.item_info(user_info.getEquip_accessory()));
			
			//System.out.println("user_nowHP : " + user_info.getUser_nowHP());
			//System.out.println("user_maxHP : " + user_info.getUser_maxHP());
			//System.out.println("user HP info percent : " + (user_info.getUser_nowHP()/user_info.getUser_maxHP())*100);
			
			
			model.addAttribute("HPpercent", (int)(((float)user_info.getUser_nowHP()/(float)user_info.getUser_maxHP())*100));
			//System.out.println("HP percent : " + (int)(((float)user_info.getUser_nowHP()/(float)user_info.getUser_maxHP())*100));
			model.addAttribute("MPpercent", (int)(((float)user_info.getUser_nowMP()/(float)user_info.getUser_maxMP())*100));
			
			model.addAttribute("nickname", service.get_nickname(ID));
			model.addAttribute("img", "img/lowpepe.jpg");
		}
		
		return "user_ui/main";
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "hunt", method = RequestMethod.GET)
	public String hunt_map(@RequestParam("map_level") int map,
			@RequestParam("auto") String auto, HttpServletRequest request, Model model) {
		
		//String result = request.getAttribute("auto_check");
		
		//세션에서 memID 받아오기 (ID)
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		
		//유저와 싸울 몬스터 지정
		String monster_name = service.MonsterName(map);
		
		//다시 사용할 맵 레벨과 오토 여부를 전송함
		model.addAttribute("map_level", map);
		model.addAttribute("auto_check", auto );
		
		
		if(ID != null) {
			//유저와 몬스터 싸웠을 시 데이터 얻어오기
			ArrayList<fightDTO> fight = service.hunt_map(monster_name, ID);
			
			//유저와 몬스터의 사진... 과 싸움 정보 전송
			model.addAttribute("img", "img/lowpepe.jpg");
			model.addAttribute("fight", fight);
			
			//유저, 몬스터 정보 전송
			model.addAttribute("user_info", service.user_info(ID));
			model.addAttribute("monster_info", service.monster_info(monster_name));
			//model.addAttribute("nick_name",service.get_nickname(ID));
			//model.addAttribute("monster_name",monster_name);
			
			//model.addAttribute("user_now_gold", service.getGold(ID));
		}
		
		
		//유저와 몬스터 nickname 넘겨주고싶음 / ㅎㅎ 넘겨줬음
		
		
		return "user_ui/hunt_map";
	}
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "motel", method = RequestMethod.GET)
	public String motel(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		System.out.println("motel insert ID : " + ID);
		
		if(ID != null) {
			model.addAttribute("user_gold", (service.getGold(ID)/10));
		}
		
		
		return "user_ui/motel";
	}
	
	
	
	
	@RequestMapping(value = "heal", method = RequestMethod.GET)
	public String heal(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		

		if(ID != null) {
			service.heal(ID);
		}
		
		return "redirect:main";
	}
	
	
	
	
	
	@RequestMapping(value = "bank", method = RequestMethod.GET)
	public String bank(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		
		
		if(ID != null) {
			userMoneyDTO money = service.money_info(ID);
			model.addAttribute("user_money", money);
		}
		
		
		
		return "user_ui/bank";
	}
	
	
	
	
	
	@RequestMapping(value = "bank_action", method = RequestMethod.POST)
	public String bank_action(int bank_menu, int want_money, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		
		
		if(ID != null) {
			//String value = bank_menu;
			System.out.println("value : " + bank_menu);
			//int money = (Integer) request.getAttribute("want_money");
			System.out.println("money : " + want_money);
			//int money = (Integer) request.getAttribute("want_money");
			//System.out.println("request.bank_menu : " + value);
			//use_bank(int value, int money, String ID) {
			service.use_bank(bank_menu, want_money, ID);
			
		}
		
		
		return "redirect:main";
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value = "user_info", method = RequestMethod.GET)
	public String user_info(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("memID");
		
		
		
		
		if(ID != null) {
			
			
		}
		
		
		
		
		return "user_ui/user_info";
	}
}
