use testdb;
create table tbl_file(
	title varchar(50),
    filedata longblob
);

desc tbl_file;
select * from tbl_file;

insert into tbl_file values(
'practice',load_file("c\\sql\\sfd.svg")
);
insert into tbl_file values(
'practice2',load_file("c\\sq\\3조 - 넷플릭스 - 스타일가이드.pdf")
);

select * from tbl_file;

select filedata from tbl_file where title='practice2'
into dumpfile 'c:/sql/down1.exe';