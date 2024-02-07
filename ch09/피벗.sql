use shopdb;
select *from buytbl;
select userid,
sum(if(prodName='모니터',amount,0)) as '모니터',
sum(if(prodName='운동화',amount,0)) as '운동화',
sum(if(prodName='메모리',amount,0)) as '메모리',
sum(if(prodName='청바지',amount,0)) as '청바지',
sum(if(prodName='책',amount,0)) as '책'
from buytbl group by userid with rollup;

create or replace view view_pivot_buytbl
as
select userid,
sum(if(groupName='전자',amount,0)) as '전자',
sum(if(groupname='의류',amount,0)) as '의류',
sum(if(groupName='서적',amount,0)) as '서적',
sum(if(groupName=null,amount,0)) as '기타'
from buytbl group by userid with rollup;

select *from view_pivot_buytbl;
-- usertbl의 add를 이용하여 다음과 같은 피벗 테이블을 만들어보세요. 
select *from usertbl;
select
sum(if(addr='서울',1,0)) as'서울',
sum(if(addr='경남',1,0)) as'경남',
sum(if(addr='경북',1,0)) as'경북',
sum(if(addr='경기',1,0)) as'경기'
from usertbl;