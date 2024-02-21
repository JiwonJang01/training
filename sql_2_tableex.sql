drop database if exists tabledb;
create database tabledb;
use tabledb;

-- 테이블 생성
drop table if exists usertbl;
create table usertbl
(
	userid varchar(10) not null primary key,
    name varchar(10) not null,
    birthyear int not null,
	addr varchar(10) not null,
    mobile1 varchar(10),
    mobile2 varchar(10),
    height int,
    mdate date
);
drop table if exists buytbl;
create table buytbl
(
	num int auto_increment not null primary key,
    userid varchar(10) not null,
    prodnum varchar(10) not null,
    groupname varchar(10),
    price int not null,
    amount int not null
    -- ,foreign key(userid) references usertbl(userid)
);

-- 데이터 입력
insert into usertbl values('LSG','이승기',1987,'서울','011','1111111',182,'2024-2-21');
insert into usertbl values('KBS','김범수',1979,'경남','011','0000000',173,'2024-2-20');
insert into usertbl values('KKH','김경호',1971,'전남','011','2222222',177,'2024-2-19');

insert into buytbl values 
(null, 'KBS','운동화', null, 30, 2),
(null, 'KBS','모니터', '전자', 30, 2)
-- ,(null, 'LKY','모니터', '전자', 30, 2)
;

-- unique 제약조건
create table buytbl
(
	num int auto_increment not null primary key,
    userid varchar(10) not null,
    prodnum varchar(10) not null,
    groupname varchar(10),
    price int not null,
    amount int not null,
    email varchar(20) null unique
);

-- check 제약조건
create table pertbl
(
	num int auto_increment not null primary key,
    userid varchar(10) not null,
    uname varchar(10) not null,
    phoneNum int not null,
    birthYear int check (birthYear >= 1900 and birthYear <=2023),
);

-- 임시 테이블
create temporary table if not exists t_temtbl(id INT,name char(5));

-- 열 이름 및 데이터 형식 변경
alter table usertbl
	change column name uname varchar(10) not null; -- 기본이 null허용
;

-- 열삭제
alter table usertbl
	drop column mobile1;
    
-- 제약 조건 추가
alter table buytbl
	add constraint FK_abc
    foreign key(userid) references usertbl(userid)
    ;
    
alter table usertbl
		add homepage varchar(30)
        default 'http://daum.net'
        null #notnull도 됨
;
select * from usertbl;

alter table usertbl
	drop primary key;
    
-- view 생성
create view v_user_buy
as
select U.*, B.prodnum, B.groupname, B.price per_price, B.amount, B.price*B.amount price
from usertbl U
	left join buytbl B
		on U.userid = B.userid
;
select * from v_user_buy
where addr in ('서울','전남');
-- create view v_user_buy

-- 인덱스
use sqldb;
create table tbl1
(
	a int primary key
	, b int 
	, c int
);
show index from tbl1;

create table tbl2
(
	a int primary key
	, b int 
	, c int unique
    , d int
);
show index from tbl2;

create table tbl4
(
	a int unique not null
	, b int unique
	, c int unique
    , d int
);
show index from tbl4;

create table tbl5
(
	a int unique not null
	, b int unique
	, c int unique
    , d int primary key
);
show index from tbl5;

-- 데이터 조회는 인덱스를 기준으로 오름차순으로 정렬
create database if not exists testdb;
use testdb;

create table usertbl1
(
	userid varchar(10) primary key
    , name varchar(10) not null
    , birthyear int not null
    , addr varchar(10) not null
);
show index from usertbl1;
insert into usertbl1 values
('hhhh','홍길동1',2024,'서울')
,('ccc','홍길동2',2024,'서울')
,('aaa','홍길동3',2024,'서울')
;
select * from usertbl1;
alter table usertbl1
	drop primary key;
alter table usertbl1
		add constraint pk_birthyear primary key(name);
select * from usertbl1;

-- 인덱스 실습
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl -- Cluster Table 약자
( userID  CHAR(8) ,
  name    VARCHAR(10)
);
INSERT INTO clustertbl VALUES('LSG', '이승기');
INSERT INTO clustertbl VALUES('KBS', '김범수');
INSERT INTO clustertbl VALUES('KKH', '김경호');
INSERT INTO clustertbl VALUES('JYP', '조용필');
INSERT INTO clustertbl VALUES('SSK', '성시경');
INSERT INTO clustertbl VALUES('LJB', '임재범');
INSERT INTO clustertbl VALUES('YJS', '윤종신');
INSERT INTO clustertbl VALUES('EJW', '은지원');
INSERT INTO clustertbl VALUES('JKW', '조관우');
INSERT INTO clustertbl VALUES('BBK', '바비킴');
show index from clustertbl;
select * from clustertbl;
-- 클러스터형 인덱스로 변경
alter table clustertbl
	add constraint pk_userid
		primary key(userID);
select * from clustertbl;

-- 보조 인덱스 만들기
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl -- Secondary Table 약자
( userID  CHAR(8),
  name    VARCHAR(10)
);
INSERT INTO secondarytbl VALUES('LSG', '이승기');
INSERT INTO secondarytbl VALUES('KBS', '김범수');
INSERT INTO secondarytbl VALUES('KKH', '김경호');
INSERT INTO secondarytbl VALUES('JYP', '조용필');
INSERT INTO secondarytbl VALUES('SSK', '성시경');
INSERT INTO secondarytbl VALUES('LJB', '임재범');
INSERT INTO secondarytbl VALUES('YJS', '윤종신');
INSERT INTO secondarytbl VALUES('EJW', '은지원');
INSERT INTO secondarytbl VALUES('JKW', '조관우');
INSERT INTO secondarytbl VALUES('BBK', '바비킴');
alter table secondarytbl
	add constraint uk_secondary
		unique(userid);
show index from secondarytbl;
-- 인덱스 삭제는 drop

-- 인덱스 실습
create database if not exists indexdb;
use indexdb;
select count(*) from employees.employees;

create table emp
	select * from employees.employees order by rand(); -- rand() 임의의 순서로 정렬
create table emp_c
	select * from employees.employees order by rand();
create table emp_s
	select * from employees.employees order by rand();
select * from emp limit 5;
select * from emp_c limit 5;
select * from emp_s limit 5;

show table status;

-- 클러스터 인덱스 추가
alter table emp_c add primary key(emp_no);
alter table emp_s add index idx_emp_no(emp_no);
select * from emp_s limit 5;

-- 프로시저
use sqldb;
call userProc();
-- 입력 매개 변수 지정 in
-- 출력 매개 변수 지정 out
call userproc1('바비킴');

-- birth_date > 1950 직원 중에 남성만 추출하는 프로시저
select * from employees.employees;
call mypro1('1955-01-01');
select * from employees.employees where birth_date>'1950-01-01' and gender = 'M';

call mypro1('1960');

