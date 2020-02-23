/*로그인 시 필요한 유저 테이블*/
create table user_table(
	ID varchar2(15) not null primary key ,
	password varchar2(15) not null,
	nickname varchar2(18)
)

select * from user_table
drop table user_table
INSERT INTO user_table VALUES ('d','d','병날개')
DELETE FROM user_table WHERE ID='d'
SELECT * FROM user_table WHERE ID='asd' AND password='asd'


/*전투에 필요한 유저 정보 테이블*/
create table user_info(
	user_name varchar2(6) primary key,
	nick_name varchar2(18) ,
	
	user_att number ,
	user_def number ,
	user_spe number ,
	
	user_nowHP number ,   user_maxHP number ,
	user_nowMP number ,   user_maxMP number ,
	
	equip_weapon number ,
	equip_armor number ,
	equip_accessory number ,
	
	CONSTRAINT info_fk_code FOREIGN KEY(user_name)
	REFERENCES user_table(ID) ON DELETE CASCADE
);

select * from user_info
drop table user_info
UPDATE user_info SET user_nowHP=1000,  user_nowMP=100  WHERE user_name = 'd'



/*유저의 금액 현황*/
CREATE TABLE user_money(
	user_name varchar2(6),
	
	now_money number ,
	bank_money number ,
	
	CONSTRAINT money_fk_code FOREIGN KEY(user_name)
	REFERENCES user_table(ID) ON DELETE CASCADE
);

select * from user_money
drop table user_money
select now_money from user_money where user_name='d'
insert into USER_MONEY values ('d', '123', '456')
delete from USER_MONEY where user_name = 'd'
UPDATE user_money SET now_money = now_money - 23  WHERE user_name = 'd'
update user_money set now_money = now_money + bank_money ,
bank_money = 0 where user_name='d'




/*유저 레벨과 직업*/
CREATE TABLE user_exp(
	user_name varchar2(6),
	
	user_job varchar2(10) ,
	user_jobexp number,
	
	user_level number ,
	user_exp number ,
	
	CONSTRAINT exp_fk_code FOREIGN KEY(user_name)
	REFERENCES user_table(ID) ON DELETE CASCADE
);

select * from user_exp
drop table user_exp
INSERT INTO user_exp VALUES ('d', '백수', 100, 1, 120)
UPDATE user_exp set user_exp = 100, user_jobexp = 100 WHERE user_name = 'd'



/*몬스터 테이블*/
create table monster_table(
	monster_name varchar2(10) primary key ,
	
	monster_att number ,
	monster_def number ,
	monster_spe number ,
	
	monster_nowHP number ,   monster_maxHP number ,
	monster_nowMP number ,   monster_maxMP number ,
	
	monster_gold number ,
	monster_exp number,
	monster_jobexp number
)

select * from monster_table
drop table monster_table



/* 아이템 정보 테이블 */
CREATE TABLE item_info(
	item_no number primary key not null,
	item_name varchar2(30) ,
	item_att number ,
	item_wei number 
)

select * from item_info
drop table item_info
insert into item_info values (0,'none', 0, 0)
insert into item_info values (3,'test item3', 200, 0)
delete from item_info where item_no=3






CREATE TABLE user_item(
	user_name varchar2(15) ,
	item_no number ,
	
	CONSTRAINT item_user_fk_code FOREIGN KEY(user_name)
	REFERENCES user_table(ID) ON DELETE CASCADE ,
	
	CONSTRAINT item_info_fk_code FOREIGN KEY(item_no)
	REFERENCES item_info(item_no) ON DELETE CASCADE
)
select * from user_item
drop table user_item
insert into user_item values ('d', 3)
delete from user_item where user_name='asd'


CREATE TABLE d_item(
	user_name varchar2(15) ,
	item_no number ,
	
	CONSTRAINT item_user_fk_code FOREIGN KEY(user_name)
	REFERENCES user_table(ID) ON DELETE CASCADE ,
	
	CONSTRAINT item_info_fk_code FOREIGN KEY(item_no)
	REFERENCES item_info(item_no) ON DELETE CASCADE
)




INSERT INTO user_info VALUES ('d','병날개','123','123','100','500','1000','100','100', 1, 2, 3)
INSERT INTO monster_table VALUES ('늑대','100','123','100','500','500','100','100',300, 100, 100)
delete from monster_table where monster_name = '늑대'


select * FROM USER_INFO
UPDATE user_info SET user_nowHP = user_maxHP WHERE user_name = 'd'

select * FROM USER_MONEY
UPDATE user_money SET now_money = now_money - (now_money/10)


select * from ddddd
drop table ddddd


select * from(
    select item_no from item_info
    order by DBMS_RANDOM.RANDOM
) where rownum>0 AND rownum < 10;

