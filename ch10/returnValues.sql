-- ----------
-- 반환값 지정
-- ----------
use shopdb;
delimiter $$
create procedure proc_output_01(in h_val int,out o_val char(100))
begin
	select userid from usertbl where height =h_val;

end$$
delimiter ;

select *from usertbl;
set @o_values ='';
call proc_output_01(176,@o_values);
select @o_values;