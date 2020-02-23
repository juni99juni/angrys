package kr.co.DTO;

import java.util.ArrayList;

public class fightDTO {
	
	ArrayList<Integer> dmg;
	String whois;
	boolean win = false;
	int nowHP;
	String root_item;
	
	
	
	public String getRoot_item() {
		return root_item;
	}
	public void setRoot_item(String root_item) {
		this.root_item = root_item;
	}
	public int getNowHP() {
		return nowHP;
	}
	public void setNowHP(int nowHP) {
		this.nowHP = nowHP;
	}
	public ArrayList<Integer> getDmg() {
		return dmg;
	}
	public void setDmg(ArrayList<Integer> dmg) {
		this.dmg = dmg;
	}
	public String getWhois() {
		return whois;
	}
	public void setWhois(String whois) {
		this.whois = whois;
	}
	public boolean isWin() {
		return win;
	}
	public void setWin(boolean win) {
		this.win = win;
	}
	
	
	
	
}
