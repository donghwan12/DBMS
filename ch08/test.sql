create database test3db;
create table tbl_member(
	member_id int  ,
    member_nmae varchar(10)  ,
    member_identity varchar(10)  not null,
    member_grade char(3) ,
    member_addr varchar(100),
    member_phone varchar(20) not null
);
alter table tbl_member modify member_grade char(3);
desc tbl_member;
create table tbl_book(
	book_code int,
    classification int,
    bookc_author varchar(45) not null,
    book_name varchar(45) not null,
	publisher varchar(45) not null,
    isrental char(1)
);
desc tbl_book;

create table tbl_rental(
	rental_id int,
    book_code int,
    member_id int
);
desc tbl_rental;
alter table tbl_member add primary key(member_id);
desc tbl_member;
alter table tbl_book add primary key(book_code);
desc tbl_book;
alter table tbl_rental add primary key(rental_id);
desc tbl_rental;

alter table tbl_rental
add constraint FK_book_rental
foreign key(book_code)
references tbl_book(book_code)
on update restrict
on delete cascade;
desc tbl_rental;

alter table tbl_rental
add constraint FK_member_rental
foreign key(member_id)
references tbl_member(member_id)
on update cascade
on delete cascade;
desc tbl_rental;

INSERT INTO tbl_member VALUES
(111, 'aaa', '111', '일반', '대구', '010-111-2222'),
(222, 'bbb', '222', 'VIP', '울산', '010-111-2222'),
(333, 'ccc', '333', 'VIP', '인천', '010-111-2222'),
(444, 'ddd', '444', '일반', '부산', '010-111-2222'),
(555, 'eee', '555', 'VIP', '서울', '010-111-2222'),
(666, 'fff', '666', '일반', '경기', '010-111-2222');

select *from tbl_member;
insert into tbl_book values
(1010,1,'윤성우','열혈C','오렌지미디어','1'),
(1011,1,'남궁성','JAVA의정석','00미디어','1'),
(1012,2,'남길동','이것이리눅스다','한빛미디어미디어','1'),
(2010,2,'데일카네기','인간관계론','00미디어','1'),
(2011,2,'홍길동','미움받을용기','00미디어','1');
select *from tbl_book;
insert into tbl_rental values
(1,1010,111),
(2,1011,222),
(3,1012,333);
select *from tbl_rental;

SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'tbl_member'
  AND CONSTRAINT_NAME = 'PRIMARY';

SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'tbl_book'
  AND CONSTRAINT_NAME = 'PRIMARY';
  
select *from 
information_schema.table_constraints where table_name='tbl_rental';

create Index idx_tbl_member
on tbl_member(member_addr);
show index from tbl_member;

create index idx_book
on tbl_book(bookc_author,book_name,publisher);
show index from tbl_book;

create or replace view View_showREntal
as
select rental_id,member_nmae,book_name
from tbl_rental r
inner join tbl_member m
on r.member_id=m.member_id
inner join tbl_book b
on r.book_code=b.book_code;
select *from view_showREntal;

