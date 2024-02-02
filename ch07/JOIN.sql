use testdb;
-- ------------
-- join
-- ---------
-- 두개 이상의 테이블을 서로 묶어서 하나의 조회결과를 만드는데 사용

-- ---------
-- join 종류
-- --------
-- INNER JOIN	:  ON이하의 조건절을 만족하는 행만 JOIN
-- OUTER JOIN	:  ON이하의 조건절을 만족하지 않는 행도 JOIN
	-- LEFT OUTER JOIN	: 조건을 만족하지 않는 왼쪽TABLE의행도 JOIN
    -- RIGHT OUTER JOIN	: 조건을 만족하지 않는 오른쪽 TABLE의 행도 JOIN
    -- FULL JOIN 	: 조건을 만족하지않는 왼쪽,오른쪽 TABLE 의 행도 JOIN
-- CROSS JOIN	: 한쪽테이블 모든행과 반대쪽테이블의 모든행을 조인 조건절X
-- SELF JOIN	: 자기자신의 한테이블내에서 JOIN

-- INNER JOIN 기본
USE SHOPDB;
SELECT * FROM USERTBL;
SELECT * FROM BUYTBL;

SELECT * 
FROM USERTBL 
INNER JOIN BUYTBL
ON USERTBL.USERID=BUYTBL.USERID;

-- INNER JOIN 원하는 열만출력 (열이름 중복시 특정테이블.열이름(USERTBL.USERID)으로 사용)
USE SHOPDB;
SELECT * FROM USERTBL;
SELECT * FROM BUYTBL;

SELECT USERTBL.USERID,NAME,ADDR,MOBILE1,MOBILE2,PRODNAME,PRICE,AMOUNT 
FROM USERTBL 
INNER JOIN BUYTBL
ON USERTBL.USERID=BUYTBL.USERID;

-- INNER JOIN(별칭지정)
SELECT U.USERID,NAME,ADDR,MOBILE1,MOBILE2,PRODNAME,PRICE,AMOUNT 
FROM USERTBL U -- 별칭
INNER JOIN BUYTBL B -- 별칭
ON U.USERID=B.USERID;

-- WHERE 조건절 적용
SELECT U.USERID,NAME,ADDR,MOBILE1,MOBILE2,PRODNAME,PRICE,AMOUNT 
FROM USERTBL U -- 별칭
INNER JOIN BUYTBL B -- 별칭
ON U.USERID=B.USERID
WHERE AMOUNT<=5;

-- 문제	
-- 1. 바비킴의 USERID,BIRTHYEAR,PRODNAME,GROUPNAME 을 출력하세요


SELECT * FROM USERTBL;
SELECT *FROM BUYTBL;
SELECT U.USERID NAME,BIRTHYEAR,PRODNAME,GROUPNAME
FROM USERTBL U
INNER JOIN BUYTBL B
ON U.USERID=B.USERID -- B.USERID 인이유는 외래키라서 그런가?
WHERE U.NAME='바비킴';

-- 2.AMOUNT*PRICE 의 값이 100 이상인 행의 NAME,ADDR,PRODNAME,MOBILE1- MOBILE2를 출력하세요 (CONCAT()함수 사용)
SELECT U.USERID,NAME,ADDR,PRODNAME, CONCAT(MOBILE1,'-',MOBILE2) AS 'MOBILE'
FROM USERTBL U
INNER JOIN BUYTBL B
ON U.USERID=B.USERID
WHERE B.AMOUNT * B.PRICE>=100;

-- 3.GROPNAME이 전자인 행의 USERID,NAME,BIRTHYEAR PRODNAME을 출력하세요.
SELECT U.USERID,NAME,BIRTHYEAR,PRODNAME
FROM USERTBL U
INNER JOIN BUYTBL B
ON U.USERID=B.USERID
WHERE B.GROUPNAME='전자';

-- OUTERJOIN
-- Left Outer Join(on 조건을 만족하지 않는 left 테이블의 행도 출력한다.)
select *
from usertbl u -- left 테이블
left outer join buytbl b -- right 테이블
on u.userid=b.userid; -- 구매하지 않은 고객도 나옴

-- Right Outer Join(on 조건을 만족하지 않는 right 테이블의 행도 출력)
select *
from buytbl b -- left테이블 
right outer join usertbl u -- right 테이블
on u.userid=b.userid; -- 구매하지않는 고객이나옴 (left 랑 순서가 바꼇다고생각)

-- Full Outer join(on 조건을 만족하지 않는 left,right 테이블의 행도 출력)
-- mysql에서는 full outer join을 지원하지 않는다.
-- 대신 union을 사용해서 left,right outer join 을 연결한다
select * from usertbl left outer join buytbl on usertbl.userid=buytbl.userid
union
select * from usertbl right outer join buytbl on usertbl.userid=buytbl.userid;

-- 여러 테이블들 join
use classicmodels;

select *from products;
select *from orderdetails;
select* from orders;

-- inner join
select p.productCode,productName,quantityordered,priceEach,orderdate,o.status
from orderdetails od
inner join products p
on p.ProductCode=od.productCode
inner join orders o
on o.orderNumber=od.orderNumber;

-- right outer join

select p.productCode,productName,quantityordered,priceEach,orderdate,o.status
from orderdetails od
right outer join products p
on p.ProductCode=od.productCode
inner join orders o
on o.orderNumber=od.orderNumber;




