-- ---------
-- INDEX
-- -----
-- 데이터 베이스 데이블의 검색 성능을 향상시키기 위해 사용되는 데이터 구조이다.
-- where 이하 조건절열에 index로 지정된 열을 사용한다.
-- index로 지정된 열은 기본적으로 정렬 처리가 된다(모든 DBMS는 아님)


-- -------
-- MYSQL INDEX 알고리즘 종류
-- -------
-- B-Tree: 기본값,데이터의 index에 잘 적용되어 사용
-- Hash: 해시 함수를 이용한 index, 정확한 일치 검색에 사용(포함검색에는 다소 성능이 저하뒬수 있다)
-- Full-text:전체 텍스트 검색에 사용된s index,텍스트 검식기능 향상시 유리
-- Spatial :공간데이터(위도/경도등을 담는 지도데이터)을 처리하기 위한 index, 지리정보 검색에 유리

-- -------------------
-- MYSQL INDEX TYPE
-- ---------------
-- 클러터스(Primary)형 인덱스		:PK열에 기본적으로 적용된s index, 사전편찬 순서에 맞게 정렬이된다.한테이블에 한개만 설정. 보조 인덱스보다 빠른속도다[기본:B-Tree]

-- 보조(Secondrey) 인덱스		:PK이외 다른 제약조건이나 수동으로 설정시 적용되는 index이다. 검색알고리즘에 맞게 검색한다,한테이블에 여러 Index를 생성한다. [기본:B-tree]

-- 01 제약조건 Pk설정시 uique index 확인
use testdb;
create table tbl_a(
	col1 int primary key,
    col2 int
);

desc tbl_a;
show index from tbl_a;

-- 02 제약조건 uique 설정시 uique index 확인
create table tbl_b(
	col1 int primary key,
    col2 int unique,
    cor3 int
);

desc tbl_b;
show index from tbl_b;

-- 03 index 삭제
use testdb;
show index from tbl_b;
desc tbl_b;
alter table tbl_b drop primary key;
desc tbl_b;
show index from tbl_b;
alter table tbl_b drop constraint col2;
show index from tbl_b;

-- 보조 인덱스 추가
create table tbl_c(
	col1 int primary key,
    col2 int,
    col3 int,
    unique index col2_index(col2)
);

show index from tbl_c;

create table tbl_d(
	col1 int primary key,
    col2 int,
    col3 int,
    unique index col2_3_index(col2,col3)
);

show index from tbl_d;

-- 테이블 생성이후 인덱스 생성
create table tbl_e(
	col1 int primary key,
    col2 int,
    col3 int
);

create index col2_index on tbl_e(col2);
show index from tbl_e;

create table tbl_f( -- 외래키 인덱스 설정
	col1 int primary key,
	col2_e int,
    col3 int,
    constraint FK_tbl_f_tbl_e foreign key(col2_e) reference tbl_e(col1)
    on update cascade
    on delete cascade
);