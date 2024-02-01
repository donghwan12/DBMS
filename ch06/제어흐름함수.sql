-- 제어흐름함수

set @var1=100;
set @var2=200;

select if(@var1>@var2,concat(@var1,'이 더큽니다'),concat(@var2, '이 더 큽니다'));

select *,if(amount>5,'우수고객','일반고객') as '등급'from buytbl;

-- 키가 170이상이면 170이상 170이하면 170이하로 표시

select *,if(height>=170,'170이상','170이하') as '평균키'from usertbl;

select case 7
when 1 then '일'
when 5 then '오'
when 10 then '십'
else '몰라'
end as 'casetest';

select *, case
	when amount>=10 then 'VIP'
    when amount>=5 then '우수'
	else '일반고객' 
end as '등급'
from buytbl;

