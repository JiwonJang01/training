use sqldb;

-- 1. 변수 선언 및 값 대입
set @myVar1 = 5;
set @myVar2 = 3;
set @myVar3 = 4.25;
set @myVar4 = '가수 이름 ==>';
-- 2. 변수의 값 출력
select @myVar1; -- mysql 버전 오라클: select @myVar1 from dumy
select @myVar2 + @myVar3;
select @myVar4, name from usertbl;

-- 2.
-- buytbl에서 평균 구매 갯수
select avg(amount) from buytbl;

-- 타입을 강제적으로 변환(명시적 형변환) 수동
select cast(avg(amount) as signed integer) vagAmount from buytbl; -- from 앞에 컬럼명을 줄수도 있음
select convert(avg(amount), signed integer) vagAmount from buytbl; -- 함수처럼 사용

-- 자연스럽게 형 변환이 되는 경우(암시적 형변환)
select '100' + '200'; -- 문자 + 문자지만 정수로 변환되서 연산됨
select concat('100' + '200'); -- 문자, 문자 지만 정수로 처리(둘 중 하나가 정수일때도 마찬가지)
select 1>'2mega'; -- 정수인 2로 변환되어서 비교
select 0 = 'mega2'; -- 문자는 0으로 변환됨 결과:1

-- 제어흐름 (자주 사용)
select if (100>200, true, false) ispossible;
select ifnull(null,'null 입니다');
select prodName, ifnull(groupName,'기타') from buytbl; -- groupName이 null이면 기타로 출력

-- 제어함수
-- case ~ when ~ else ~ end
select case 10
		when 1 then '일'
		when 2 then '이'
		when 3 then '삼'
		else '일이삼이 아님'
	end '연습';
    
select
prodName,
	case groupname
		when '전자' then 'electric'
        else 'non electric'
	end groupname
from buytbl;

-- trim
select trim('   공백    '),
	trim(both 'ㅋ' from 'ㅋㅋ공백말고도 설정가능ㅋㅋ');

-- 피벗 - 데쉬보드 .. 통계성 데이터
create table pivotTest(
	uname varchar(5),
    season varchar(2),
    amount int
);
insert into pivotTest values
	('a', '봄',20),('b', '여름',20),('c', '가을',20),
    ('a', '봄',20),('b', '여름',20),('c', '가을',20)
    ;
select * from pivotTest;
select
sum(if(season='봄', amount, 0)) '봄',
sum(if(season='여름', amount, 0)) '여름',
sum(if(season='가을', amount, 0)) '가을',
sum(if(season='겨울', amount, 0)) '겨울'
from pivotTest;

drop table pivotTest;

select
	uname, -- 여러개이므로 group by가 필요함.
	sum(if(season='봄', amount, 0)) '봄',
	sum(if(season='여름', amount, 0)) '여름',
	sum(if(season='가을', amount, 0)) '가을',
	sum(if(season='겨울', amount, 0)) '겨울'
 from pivotTest
group by uname;

select * from usertbl;
select * from buytbl;

-- join
select *
from usertbl ut -- ut:별칭
	join buytbl bt -- bt:별칭
    on ut.userID = bt.userID
where ut.name = "바비킴"
;
-- 외부 조인 left
use sqldb;
select *
from usertbl U
	left join buytbl B
		on U.userID = B.userID
	order by U.userID;

-- cross 조인
create table usertbl_copy
	select * from usertbl limit 1
    ;
select * from usertbl_copy;

select
*
from usertbl_copy
	cross join buytbl
;

-- self 조인
create table emptbl
(
	emp varchar(10),
    maneger varchar(10),
    tel varchar(10)
);

insert into emptbl values
('우대리','이부장','111'),('이부장','김전무','222');
select * from emptbl;
select *
from emptbl A
	join emptbl B
    on A.emp = B.maneger;
    
-- 스토어드 프로시저
drop procedure if exists ifProc;
DELIMITER $$
create procedure ifProc()
begin
	declare var1 int;
    set var1 = 100;
    if var1 = 100 then
		select '100입니다.';
	else
		select '100입니다';
    end if;
end $$
DELIMITER ;
call ifProc;