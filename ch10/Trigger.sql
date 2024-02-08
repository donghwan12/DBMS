-- ------------
-- TRIGGER
-- ------------


use shopdb;
-- 01 After Trigger

drop table c_usertbl;
create table c_usertbl select * from usertbl;
select * from c_usertbl;
create table c_usertbl_bak like c_usertbl; -- 구조 복사
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak add column U_D_date char(5);
alter table c_usertbl_bak change column U_D_date U_D_date datetime;
desc c_usertbl_bak;
select * from c_usertbl_bak;

use shopdb;
delimiter $$
create trigger trg_c_usertbl_update
after update -- 업데이트시 발생하는 에프터 트리거
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,
    old.mDate,'수정',now()
    );
end $$
delimiter ;

show triggers;
show create trigger trg_c_usertbl_update;

select * from c_usertbl;
select * from c_usertbl_bak; -- 업데이트전 데이터가 여기에 삽입됨
update c_usertbl set name='바비' where userid='BBK';
update c_usertbl set addr='경남' where userid='EJW';


-- 02 삭제 트리거
delimiter $$
create trigger trg_c_usertbl_delete
after delete
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,
    old.mDate,'삭제',now()
    );
end $$
delimiter ;

select * from c_usertbl;
delete from c_usertbl where userid='KKH';
select * from c_usertbl_bak;

-- buytbl의 c_buytbl의 구조+값복사
-- c_buytbl의 구조만 복사한 c_buytbl_bak 만들기
-- c_buytbl_bak 에 type char(5)와 mDate datetime 을 열로 추가
-- c_buytbl의 update시 c_buytbl_bak에 내용저장되는 trg_c_buytbl_update 트리거 만들기
-- c_buytbl의 delete시 c_buytbl_bak에 내용저장되는 trg_c_buytbl_delete 트리거 만들기

create table c_buytbl select *from buytbl;
select *from c_buytbl;
create table c_buytbl_bak like c_buytbl;
select *from c_buytbl_bak;
alter table c_buytbl_bak add column type char(5);
alter table c_buytbl_bak add column mdate datetime;

drop trigger trg_c_buytbl_update;
delimiter $$
create trigger trg_c_buytbl_update
after update
on c_buytbl
for each row
begin
	insert into c_buytbl_bak values(
    old.num,old.userId,old.prodName,old.groupName,old.price,old.amount,'수정',now()
    ); 
end $$
delimiter ;

update c_buytbl set prodName='덤벨' where userId='KBS';
update c_buytbl set ProdName='바벨' where userId='JYP';

select *from c_buytbl_bak;

delimiter $$
create trigger trg_c_buytbl_delete
after delete
on c_buytbl
for each row
begin 
	insert into c_buytbl_bak values(
    old.num,old.userId,old.prodName,old.groupName,old.price,old.amount,'삭제',now());
end $$ 
delimiter ;

select *from c_buytbl;
delete from c_buytbl where amount>3;
select *from c_buytbl_bak;



