-- ------------
-- 내장함수
-- ------------
-- concat(),concat_ws()

select concat('hello','-','world');

select concat_ws("-",'hello','world',5,6); -- 구분되는곳마다 -삽입

-- SubString()
select substring("HELLO WORLD",6); -- 6 index 부터 마지막 index 까지 표시
select substring("HELLO WORLD",1,6); -- 6 index 부터 6개문자 index 까지 표시

select substring_index("HELLO MY NAME IS JUNG"," ",3);
select userid,substring_index(mDate,'-',2) as '가입연월' from usertbl;

-- Length()
select length("HELLOWORLD"); -- 문자 길이 확인
select length(lastname) from classicmodels.employees;

-- trim()
select trim("        HELLO WORLD"); -- 공백제거

-- bin,oct,hex
select bin(1);
select bin(2);
select bin(3);
select bin(4);
select bin(5);
select bin(6);
select bin(7);
select bin(8);
select bin(9);
select bin(10);
select bin(11);
select bin(12);
select bin(13);
select bin(14);
select bin(15);

-- 날짜관련 함수 생략
select year(mdate) from usertbl;
select month(mdate) from usertbl;
select day(mdate) from usertbl;

select now();
select date(now());
select curdate();
select time(now());
select curtime();

-- 현재 날짜 시간에서  연,월,일,시,분,초를 각각 추출해내고
-- 다음과 같은 포맷팅으로 출력하세요
select now();
select year(now());
select month(now());
select day(now());
select curtime();

select replace(curdate(),'-','#');
select replace(curdate(),'-','#');
select concat(replace(curdate(),'-','#')," ",replace(curtime(),'-','|'));

