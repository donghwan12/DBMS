-- insert

use shopdb;
select * from tbl_buy_copy3;


create table tbl_buy_copy3(select * from buytbl);
-- 여러값 삽입
insert into tbl_buy_copy3 values
(13,"aab",'운동화','의류','1000',2),
(14,"aab",'운동화','의류','1000',2),
(15,"aab",'운동화','의류','1000',2),
(16,"aab",'운동화','의류','1000',2);

-- auto_increment (자동으로 number가 올라옴)
desc tbl_a;
insert into tbl_a(name) values('홍길동');
select *from tbl_a;
insert into tbl_a values(null,'김민수');
delete from tbl_a;
select * from tbl_a;
insert into tbl_a(name) values('홍길동');

-- auto_increment 초기화
delete from tbl_a;
alter table tbl_a auto_increment=0;
insert into tbl_a(name) values('홍길동');
select *from tbl_a;                                                                                                                                                                                                                                                                                                                                                                       
