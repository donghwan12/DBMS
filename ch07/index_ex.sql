-- 인덱스가 있으면 처리가 빠르다.

use employees;
select * from employees.salaries;
select * from employees.salaries where to_date ='1986-01-01';
create index to_date_index on employees.salaries(to_date);
show index from employees.salaries;
alter table employees.salaries drop index to_date_index;
select *from employees.salaries where to_date='1986-12-01';