-- 00확인
use shopdb;
show tables;
select * from usertbl;
select * from buytbl;
desc usertbl;
desc buytbl;

-- 01select
select * from usertbl;
select userId,birthYear from usertbl;
select userid as '가수명', birthyear as '생년월일' from usertbl;
select 
userid as '가수명', birthyear as '생년월일' ,concat(mobile1,'-',mobile2) as '연락처'-- concat=합쳐준다 
from usertbl;

-- 02 Select where(조건절 -비교 연산자)
select * from usertbl where name='김경호'; -- 동등 비교 연산자(=)
select * from usertbl where userID='LSG'; -- 동등 비교 연산자(=)

select * from usertbl where birthYear >=1970; -- 대소비교 연산자
select * from usertbl where height <=170; -- 대소 비교 연산자

-- 03 Select where(조건절 -논리 연산자)
select *from usertbl where birthyear >=1970 and height >=180; -- and연산자 (참 and 참)
select *from usertbl where birthyear >=1970 or height >=180; -- or 연산자 (거짓 or 참 and 거짓 or 참)

select * from usertbl where height>=170 and height<=180;
select * from usertbl where height between 170 and 180;

-- in(포함문자열-완성된문자열), like(포함문자열-미완성된
select * from usertbl where addr in('서울','경남');
-- select * from usertbl where addr='경남' or addr='서울';

select * from usertbl where name like '김%'; -- 길이제한 없는 모든 문자
select * from usertbl where name like '%수'; -- 길이제한 없는 모든 문자
select * from usertbl where name like '김_'; -- _개수만큼의 길이제한있는 모든 문자;

-- 경 문자를 포함하는 모든 이름 검색??
select *from usertbl where name like '%경%'; 

-- 문제
-- 1.구매양 (amount>가 5개 이상인 행을 출력  
use shopdb;
show tables;
select *from buytbl;

select * from buytbl where amount >= 5;
-- 2.가격이(price)가 50이상 500이하인 행의 userId와 prodName만 출력 
select userid,prodname from buytbl where price between 50 and 500;
-- 3. 구매양(amonunt) 10이상이거나 가격이 100이상인 행 출력 
select * from buytbl where amount >=10 or amount >=100;
-- 4.userid가 k로 시작하는 행 출력
select *from buytbl where userId='k%';
-- 5.'서적' 이거나 '전자' 인행 출력
select * from buytbl;
select *from buytbl where groupName='서적' or groupName='전자';
select *from buytbl where groupName in('서적','전자');
-- 6.상품(prodName)이 책이거나  userId가 W로 끝나는 행출력
select *from buytbl where prodname='책' or userid like'%w';
-- 7.groupname이 비어있지 않는 행만출력
select * from buytbl;
select *from buytbl where groupname != 'null'; 


-- 04 Select 조건절 - 서브쿼리
-- 김경호보다 큰키를 가지는 모든열의 값 
select height from usertbl where name='김경호'; -- 김경호의 키

select * from usertbl where height>=(select height from usertbl where name='김경호'); 

-- 성시경보다 나이가 많은 모든열의 값
select birthyear from usertbl where name='성시경'; -- 성시경 나이
select *from usertbl where birthyear<=(select birthyear from usertbl where name='성시경');

-- 지역이 '경남'dls heiegt보다 큰 행 출력 
select *from usertbl where addr='경남';
-- all(모든 조건을 만족하는) 
select *from usertbl where height >all(select height from usertbl where addr in ('경남'));
-- any(어느 조건이든 하나이상 만족)
select *from usertbl where height >any(select height from usertbl where addr in ('경남'));

-- 문제 buytbl;
use shopdb;
select * from buytbl;
-- 1.amount가 10인 행의 price보다 큰 행을 출력하세요
select *from buytbl where price > (select price from buytbl where amount=10);
-- 2.userid가 k로 시작하는 행의 amount 보다 큰 행을 출력하세요
select * from buytbl where amount > any(select amount from buytbl where userid like'K%');  
-- 3.amount가 5인 행의 price보다 큰 행을 출력하세요
select * from buytbl where price > all(select price from buytbl where amount=5);
