-- 제약조건

-- PK
create table tbl_a(
	id int primary key,
    name varchar(45)
    );
desc tbl_a;
insert into tbl_a values(2,'홍길동');
insert into tbl_a values(1,'홍길동');
select *from tbl_a;

create table tbl_b(
	id int,
    name varchar(45) not null,
    primary key(id)
);
desc tbl_b;

create table tbl_c(
	id int,
    name varchar(45) not null,
    primary key(id,name)
);
desc tbl_c;
select * from information_schema.columns where table_schema='shopdb' and column_key='pri';

create table tbl_d(
	id int,
    name varchar(45) not null
);
-- pk 추가 
desc tbl_d;
alter table tbl_d add constraint pk_tbl_d primary key(id,name);
desc tbl_d;

-- pk 삭제
alter table tbl_d drop primary key;
desc tbl_d;

-- 문제 buytbl을 buytbl_copy로 구조+데이터 복사(create table select)하고 num을 priamry key로 설정 하기
create table buytbl_copy(select *from buytbl); -- table 복사
select *from buytbl_copy;
alter table buytbl_copy add constraint pk_buytbl_copy primary key(num);
desc buytbl_copy;

-- FK
-- 프라이머리키랑 왜리키랑은 자료형 일치해야한다 
create table tbl_a( 
	num int primary key,
    name varchar(45)    
    );
desc tbl_a;
create table tbl_b(
	num int primary key,
    tbl_a_id int,
    name varchar(45),
    constraint FK_tbl_b_tbl_a foreign key(tbl_a_id) references tbl_a(id)
);
desc tbl_b;

-- FK option
-- RESTRICT		:  PK,FK열의 값의 변경 차단 처음 입력된값으로 고정 되어있다 
-- cASCADE		:  pk열의 값 on update,on delete 이 변경시 FK 열의값도 함께변경'
-- SET SULL		: PK열의 값이 변경시 FK열의 값을 NULL로 설정
-- SET DEFAULT  : PK열의 값이 변경시 FK열의 값은 Defalut 로 설정된 기본값을 적영
-- NO ACTION	: PK열의 값이 변경시 FK 열의 값은 변경 되지 않음으로 설정

create table tbl_c(
	num int primary key,
    tbl_a_id int,
    name varchar(45),
    constraint FK_tbl_c_tbl_a foreign key(tbl_a_id) references tbl_a(id)
    on update cascade
    on delete set null
);
desc tbl_c;

-- 문제
-- buytbl을 copy_buytbl로 구조 +데이터 복사 이후
-- num을 pk 설정
-- userid를 fk 설정(on delete restrict on update cascade)
create table copy_buytbl(select*from buytbl);
desc copy_buytbl;
alter table copy_buytbl add constraint pk_copybuy primary key(num);
desc copy_buytbl;
alter table copy_buytbl add constraint FK_buytbl_FK_copy foreign key(userID) references buytbl(userID)
on update restrict on delete cascade;
desc copy_buytbl;

-- UNIQUE(중복허용x,null o) -email 등록
create table tbl_a
(
	id int primary key,
    name varchar(45),
    email varchar(100) unique
);

create table tbl_b
(
	id int primary key,
    name varchar(45),
    email varchar(100),
    constraint uk_email unique(email)
);
desc tbl_b;

create table tbl_c
(
	id int primary key,
    name varchar(45),
    email varchar(100) 
);
desc tbl_c;
alter table tbl_c add constraint uk_tbl_c_email unique(email);
alter table tbl_c drop constraint uk_tbl_c_email;
desc tbl_c;

-- CHECK
use shopdb;
create table tbl_d(
	id int primary key,
    name varchar(45),
    age int check(age>=20 and age<=50),
    addr varchar(5) ,
    constraint  ck_addr check(addr in('대구','부산','대전'))
);
desc tbl_d;
select *from information_schema.check_constraints;
select *from tbl_d;

alter table tbl_d drop check ck_addr;
select *from information_schema.check_constraints;

-- DEFAULT
create table tbl_e(
	id int primary key,
    name varchar(45) default '이름없음',
    addr varchar(100)
);
desc tbl_e;
insert into tbl_e values(1,'홍길동',null);
select *from tbl_e;
insert into tbl_e(id) values(2);
select *from tbl_e;

alter table tbl_e alter column  addr set default '대구';
select *from tbl_e;
alter table tbl_e alter column addr drop default;
select *from tbl_e;
