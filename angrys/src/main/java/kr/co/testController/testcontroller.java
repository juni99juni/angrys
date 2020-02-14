package kr.co.testController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.DAO.DAOImple;
import kr.co.DTO.fightDTO;
import kr.co.service_cellection.ServiceImple;

@Controller
public class testcontroller {
	
	@Autowired
	ServiceImple service;
	
	
	@Autowired
	DAOImple dao;
	
	
	
	@RequestMapping(value = "select_user", method = RequestMethod.GET)
	public String select_user(Model model) {
		
		model.addAttribute("user", service.select_user());
		
		return "select";
	}
	
	
	
	
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String test(Model model) {
		
		
		//ArrayList<fightDTO> fight = service.hunt_map(1, "d");
		
		
		//odel.addAttribute("fight", fight);
		String table_name = "ddddd";
		String create_table = "create table " + table_name + "("
				+ "user_name varchar2(15) ,"
				+ "item_no number)";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("create_table", create_table);
		
		dao.test_table(map);
		
		System.out.println("test : ");
		
		
		return "test";
	}
	
}
