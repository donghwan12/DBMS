-- ---------
-- TRANSACTION
-- --------
-- 데이터베이스의 상태를 변환시키는 작업 단위

-- -----------
-- 트랜잭션 성질
-- ---------
-- 원자성
-- 	1.원자성이란 트랜잭션이 안전성 보장을 위해 가져야 할 성질 중의 하나이다.
-- 	2.원자성이란 시스템에서 한 트랜잭션의 연산들이 모두 성공하거나, 반대로 전부 실패되는 성질을 말한다.
-- 	3.원자성은 작업이 모두 반영되거나 모두 반영되지 않음으로서 결과를 예측할 수 있어야 한다.

-- 일관성
-- 1.일관성은 데이터베이스의 상태가 일관되어야 한다는 성질이다.
-- 2.일관성은 하나의 트랜잭션 이전과 이후, 데이터베이스의 상태는 이전과 같이 유효해야 한다.
-- 다시 말해, 트랜잭션이 일어난 이후의 데이터베이스는 데이터베이스의 제약이나 규칙을 만족해야 한다는 뜻이다.

-- 독립성,격리성
-- 1.격리성은 모든 트랜잭션은 다른 트랜잭션으로부터 독립되어야 한다는 뜻이다.
-- 실제로 동시에 여러 개의 트랜잭션들이 수행될 때, 각 트랜젝션은 고립(격리)되어 있어 연속으로 실행된 것과 동일한 결과를 나타낸다.

-- 영속성,지속성
-- 1.지속성은 하나의 트랜잭션이 성공적으로 수행되었다면, 해당 트랜잭션에 대한 로그가 남아야하는 성질을 말한다.
-- 만약 런타임 오류나 시스템 오류가 발생하더라도, 해당 기록은 영구적이어야 한다는 뜻이다.

-- 
create table tbl_tx(
	no int primary key,
    name varchar(20),
    age int,
    gender char(1)
);

select *from tbl_tx; 
insert into tbl_tx values(1,'aa',55,'W'); -- auto commit
insert into tbl_tx values(2,'bb',44,'M'); -- auto commit
select *from tbl_tx;

start transaction;
	insert into tbl_tx values(3,'cc',55,'W'); 
	insert into tbl_tx values(4,'bb',44,'M'); 
	insert into tbl_tx values(5,'bb',44,'M'); 
	rollback; -- 전체 롤백 commit 전으로
drop table tbl_tx;

select *from tbl_tx;
start transaction;
	savepoint s1;
    insert into tbl_tx values(3,'cc',55,'W'); 
	insert into tbl_tx values(4,'bb',44,'M'); 
    savepoint s2;
	insert into tbl_tx values(5,'cc',55,'W'); 
	insert into tbl_tx values(6,'bb',44,'M'); 
    savepoint s3;
	insert into tbl_tx values(7,'cc',55,'W'); 
	insert into tbl_tx values(8,'bb',44,'M'); 
    rollback to s2;
    
drop procedure TX_test;
select *from tbl_tx;
delete from tbl_tx;
delimiter $$
create procedure Tx_test()
begin
	declare continue handler for sqlexception
    begin
		show errors;
        rollback;
    end;
	start transaction;
        insert into tbl_tx values(1,'bb',44,'M'); 
        insert into tbl_tx values(2,'bb',44,'M'); 
        insert into tbl_tx values(2,'bb',44,'M'); 
    commit;
end $$
delimiter ; 

call Tx_test();
select *from tbl_tx; -- rollbakc으로 인해 아무것도 안나옴 