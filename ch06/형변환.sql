-- 01 변수
-- 변하는 수
-- 수는 기본 선저장, 후처리를 원칙으로 한다
-- 저장된 수가 특정상황에 있어 바뀔가능성이 있는경우 이수를 변수라고한다.

use shopdb;
set @var1=5;
set @var2=4.56;
set @var3="가수이름=>";

select @var1;
select @var2;
select @var3;
select @var1+@var2; -- 정수+실수=실수

select @var3 as 'TITLE',name,addr from usertbl;

-- LIMIT에서 변수 사용
set @rowcount=5;
prepare sqlQuery01
from 'select * from usertbl order by height limit ?';


execute sqlQuery01 using @rowcount;


-- 형변환 
-- 연산작업시(ex대입연산,비교연산,논리연산 ...)자료형이(data type)이 불일치시 자료형을 일치 시키는 작업
-- 자동형변환(암시적형변환) :시스템에 의한 형변환(데이터 손실을 최소화 방향)
-- 강제형변환(명시적형변환)	:프로그래머에 의한 형변환(프로그램 제작 목적에 따른->데이터 손실 우려가 비교적 크다.)

select mdate from usertbl;
select cast('2024&01&01' as date); -- 문자열 데이터를 날짜로 변경한다.

select num,
concat(cast(price as char(10)),'X',cast(amount as char(10))) as '가격X수량' 
,price*amount as '결과값'

from buytbl;
select 100 +200;
select '100' +200;
select '100'+'200';
select '100a'+'200'+'300';

select 1>2; -- 0 false
select 2 >'1'; -- 1 ture 자료형을 일치 시켜주는 작업을 먼저한다 문자형>int 형으로

-- 문제
-- 1. usertbl의 평균키를 구하라 (cast를 이용,평균키 정수형으로 형변환 할것)
select name,height from usertbl;
select
cast(avg(height) as signed int) as '평균키' from usertbl;
-- 2.'2020년 5월7일'문자열을 date 자료형으로 출룍하세요
select mdate from usertbl;
select cast('2020&5&7' as date);

