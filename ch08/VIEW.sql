-- --------------
-- VIEW ----
-- -------------
-- 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기 위한 가상 테이블이다.

use shopdb;
select *from usertbl;
select *from buytbl;
desc usertbl;

create view view_test
as 
select userid,name,birthyear,addr,height from usertbl;

select *from view_test;
insert into view_test values('aaa','에이','1999','경기','188');
select *from view_test;
select *from usertbl;

-- view 만들기
create or replace view view_usertbl
as
select userid,name, concat(mobile1,'-',mobile2) as phone 
from usertbl;

select *from view_usertbl;

use shopdb;
create or replace view view_usertbl_2
as
select userid,name, concat(mobile1,'-',mobile2) as phone 
from usertbl
where addr in ('서울','경기','경남');

select *from view_usertbl_2;
select * from information_schema.views where table_schema='shopdb';

create or replace view view_tbl_user_buytbl
as
select U.userid,addr,concat(mobile1,'-',mobile2) as phone,prodname,amount 
from usertbl U
inner join buytbl B
on u.userid=b.userid;

select *from view_tbl_user_buytbl;
select *from view_tbl_user_buytbl where amount>=5;
desc usertbl;

create table tbl_f(
	col1 int primary key,
    col2 int 
);

create table tbl_g(
	col3 int primary key,
    col4 int 
);

create or replace view view_a_b
as 
select *
from tbl_f 
inner join tbl_g;

select *from view_a_b;
insert into view_a_b(col1,col2,col3,col4) values(1,1,1,1); 

desc products;
desc orderdetails;
desc orders;

-- classicmodes 에서
-- prodcuts,orderdetlails,orders 에 대한 관꼐도를 확인해서
-- 열항목이 productname,productvendor,quantityorderd,priceeacch,orderdate가 포함된
-- view product_order 를만들어보세요
--
use classicmodels;
create or replace view view_product_order
as 
select productname,productvendor,quantityordered,priceeach,orderdate
from orderdetails Od
inner join products P
on Od.productCode=p.productCode
inner join orders O
on Od.orderNumber=o.orderNumber
where quantityOrdered>=25;

select *from view_product_order;
