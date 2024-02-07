-- ----------------
-- Stroed Procedure
-- ----------------
-- 데이터베이스에서 실행 가능한 저장 프로그램이다
-- SQL문들의 논리적인 묶음
-- Function(함수)와 유사하나 턱정부분에서의 차이점이 존재한다.

-- -----------------------------
-- Stroed Procedure 와Funtion과의 공통점
-- -----------------
-- 01재사용성
-- 02 모듈화
-- 03 매개변수의 존재
-- 04 흐름제어처리(if,case,while 사용가능)
-- 05 트렌젝션 처리
-- 06 커서사용
-- 07 반환값 존재
-- 08 동적 SQL문 실행가능(prepare-execute)


-- ----------------------
-- Stroed Procedure와 Funtion과의 차이점
-- ------------------------

 -- 반환값: 
	-- 프로시저에서(Procedure)는 반환값이 실수가 아니다
	-- 함수(Funtion)에서는 항상 값을 반환한다
    
-- 허용되는 문제
	-- 프로시저는 select,insert,update,delete문과 같은 SQL문 내에서 직접 호출가능하다.
    -- 함수는 주로 select 문이나 where 절에서 호출되어 사용 SQL문에서 직접호출되는 경우가 적다.
    
-- 트렌잭션
	-- 프로시저:트렌잭선 내에서 여러 SQL문을 실행할 수 있다.
    -- 함수: 주로 읽기전용 작업에 사용되며,트랜잭션에서 변경 사항을 가지지 않도록 설계
    
-- 예외처리
	-- 프로시저: 프로시저 내에서 예외처리 가능
	-- 함수: 예외처리가 가능하지만 주로 SELECT 문을 사용하기 떄문에 (조회) 예외 처리를 적용하는 경우가적다.
    
-- -----------
-- 예제 01
-- --------

DELIMITER $$
CREATE PROCEDURE PRO1()
BEGIN 
	-- 변수 선언
    DECLARE VAR1 INT;
    -- 값 삽입
    SET VAR1=100;
    -- IF문
    IF VAR1=100 
		THEN 
			SELECT 'VAR1은 100입니다';
         else
			SELECT 'VAR1은 100이 아닙니다.';
	END IF;

END $$
DELIMITER ;
SHOW PROCEDURE STATUS WHERE DB='SHOPDB';

CALL PRO1();

-- ------------
-- 02 파라미터 (외부에서 값 받기)
-- ------------
DELIMITER $$
CREATE PROCEDURE PRO2(IN PARAM INT)
BEGIN 
    -- IF문
    IF PARAM=100 
		THEN 
			SELECT PARAM,'은 100입니다';
         else
			SELECT PARAM,'은 100이 아닙니다.';
	END IF;

END $$
DELIMITER ;

CALL PRO2(105);
CALL PRO2(100);
CALL PRO2(99);

--
-- 테이블적용
-- 
DELIMITER $$
CREATE PROCEDURE PRO3(IN AMT INT)
BEGIN 
	SELECT *FROM BUYTBL WHERE AMOUNT>=AMT;
    
END $$
DELIMITER ;

CALL PRO3(4);
CALL PRO3(6);

DELIMITER $$
CREATE PROCEDURE PRO4(IN AMT INT,IN ISGT INT)
BEGIN 
	IF ISGT !=0
		THEN
			SELECT *FROM BUYTBL WHERE AMOUNT>= AMT;
		ELSE
			SELECT *FROM BUYTBL WHERE AMOUNT<=AMT;
	END IF;
END $$
DELIMITER ;
CALL PRO4(4,1);
CALL PRO4(4,0);
-- ------------
DELIMITER $$
CREATE PROCEDURE PRO5()
BEGIN 
	DECLARE AVG_TOTAL_PRICE INT;
    SET AVG_TOTAL_PRICE =(SELECT AVG(AMOUNT) FROM BUYTBL);
    SELECT *,PRICE*AMOUNT,IF(PRICE*AMOUNT>=@AVG_TOTAL_PRICE,'평균이상','평균이하') AS '평균값' FROM BUYTBL;
END $$
DELIMITER ;

CALL PRO5();

SET @AVR=(SELECT AVG(AMOUNT*PRICE) FROM BUYTBL);
SELECT *,PRICE*AMOUNT,IF(PRICE*AMOUNT>=@AVR,'평균이상','평균이하') AS '평균값' FROM BUYTBL;
SELECT AVG(AMOUNT*PRICE) FROM BUYTBL;

-- 문제
-- USERTBL에서 출생년도를 입력받아 해당 출생년도보다 나이가 많은 행만 출력
-- BIRTHYEARD을 이용
-- 프로시저명 ORDER(IN PARAM INT)
DELIMITER $$
CREATE PROCEDURE ORDER1(IN PARAM INT)
BEGIN
	SELECT *FROM USERTBL WHERE BIRTHYEAR < PARAM;
END $$
DELIMITER ;

CALL ORDER1(1970);
DELIMITER $$
CREATE PROCEDURE ORDER2(IN PARAM INT)
BEGIN
	IF PARAM>=(SELECT BIRTHYEAR FROM USERTBL)
		THEN
        SELECT *FROM USERTBL;
	ELSE
			SELECT PARAM,'년생은 나이가 더 어립니다';
	END IF;
END $$
DELIMITER ;

CALL ORDER2(1980);
-- 문제
-- 근태일, 가입일로부터 지난일 구하기(USERTBL)
-- 가입일로부터 지난날짜 확인(테이블 조회시 열하나 추가해서 보여주세요)
-- SELECT URDATE(); --현재날짜
-- SELECT NOW --현재 날자시간
-- SELECT CURTIME() --현재 시간
-- SELECT *,CEIL(DATEDIFF(CURDATE(),MDATE)/365) AS 'RMSTHRSUSTN' FROM USERTBL;
 SELECT *,CEIL(DATEDIFF(CURDATE(),MDATE)/365) AS '근속년수' FROM USERTBL;
SELECT *,ceil(DATEDIFF(CURDATE(),MDATE)) AS '근속일수' FROM USERTBL;
SELECT *FROM USERTBL;

DELIMITER $$
CREATE PROCEDURE TMP()
BEGIN
	SELECT *,ceil(DATEDIFF(CURDATE(),MDATE)) AS '가입일로부터 N일' FROM 
END &&
DELIMITER;

-- -----------
-- 인자 2개
-- ------------
DELIMITER $$
CREATE PROCEDURE PRO6(IN ARG1 INT, IN ARG2 INT)
BEGIN
	SELECT * FROM USERTBL WHERE HEIGHT BETWEEN ARG1 AND ARG2; 
END $$
DELIMITER ;


CALL PRO6(170,180);

select *,
case 
	when amount>=10 then 'vip'
    when amount>=5 then '우수'
    when amount>=1 then '일반'
	else '구매없음'
end as 'Grade'
from buytbl;

DELIMITER $$
CREATE PROCEDURE PRO7(IN ARG1 INT, IN ARG2 INT, IN ARG3 INT)
BEGIN
	SELECT *,
		CASE 
			WHEN ARG1 >= 10 THEN 'VIP'
			WHEN ARG2 >= 5 THEN '우수'
			WHEN ARG3 >= 1 THEN '일반'
			ELSE '구매없음'
		END AS 'Grade'
	FROM buytbl;
END $$
DELIMITER ;


call pro7(5,3,1);

-- ----------
-- 프로시저+반복문
-- ---------

delimiter $$
create procedure prco_while_01()
begin
	-- hello word를 10회 반복출력
    declare i int;
    set i=1;
    while i<=10 do 
		select 'hello world';
        set i=i+1;
	end while;
end $$
delimiter ;

call prco_while_01();

delimiter $$
create procedure prco_while_02(in n int)
begin
	-- hello word를 10회 반복출력
    declare i int;
    set i=1;
    while i<=n do 
		select 'hello world';
        set i=i+1;
	end while;
end $$
delimiter ;

call  prco_while_02(3);

delimiter $$
create procedure proc_while_03()
begin
	declare sum int;
    declare i int;
    set i=1;
    set sum=0;
	while i<=10 do
		set sum=sum+i;
		set i=i+1;
     end while;
     select sum;
end $$;
delimiter ;

call proc_while_03();

-- 1-n합
delimiter $$
create procedure prco_whlie_04(in n int)
begin
	declare sum int;
    declare i int;
    set i=1;
    set sum=0;
    while i<=n do
		set sum=sum+i;
        set i=i+1;
        select sum;
	end while;
end $$
delimiter ;

call prco_whlie_04(15);

-- n-m합
delimiter $$
create procedure prco_while_05(in n int,in m int)
begin
	declare sum int;
    declare i int;
    set sum=0;
    if n<m
		then
        while n<m do
			set sum=sum+m;
            set n=n+1;
            select sum;
		end while;
	end if;
end $$;
delimiter ;

call prco_while_05(4,9);

-- 구구단
DELIMITER $$
CREATE PROCEDURE prco_while_06()
BEGIN
	DECLARE i INT;
    DECLARE j INT;
    DECLARE m INT;
    SET i = 2;

	WHILE i <= 9 DO
		SET j = 1;
		WHILE j <= 9 DO
			SET m = i * j;
			SELECT CONCAT(i, ' * ', j, ' = ', m) as '구구단';
			SET j = j + 1;
		END WHILE;
		SET i = i + 1;
	END WHILE;
END$$
DELIMITER ;

call  prco_while_06();

