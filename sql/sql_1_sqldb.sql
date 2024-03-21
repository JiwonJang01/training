-- sqldb에서 연습
-- 기본적인 조회
select * from usertbl where name = '김경호';

-- 조건을 여러개 두어 검색 가능
select userid, name from usertbl where birthYear >= 1970 and height >= 180;

-- between ... and
select name, height from usertbl where height between 180 and 183;

-- IN()
select name, addr from usertbl where addr in ('경남', '전남', '경북');

-- like()
select name, height from usertbl where name like '김%'; -- 김으로 시작
select name, height from usertbl where name like '%김%'; -- 김이 들어감
select name, height from usertbl where name like '%원'; -- 원으로 끝남

-- 서브쿼리
-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력
-- 김경호의 키를 알려면 정보가 있는 usertbl에서 정보를 확인
select * from usertbl where userID = 'KKH';

select name, height 
from usertbl 
where height>=(select height from usertbl where userID = 'KKH');

select name, height 
from usertbl 
where height >= any (select height from usertbl where userID like'K%'); -- some도 동일

select name, height 
from usertbl 
where height >= all (select height from usertbl where userID like'K%'); -- some도 동일

-- 정렬 order by
select name, height from usertbl order by height, name;

-- 수도권에 사는 연예인들을 나이가 많은 순서대로 출력하세요
select * from usertbl;
select * from usertbl 
where addr = '서울' or addr = '경기' order by birthYear;

-- T code
select * from usertbl 
where addr in ('서울','경기') order by birthYear;


-- select
-- distinct 중복제거(출력문의 중복제거)
select distinct addr from usertbl;
select distinct addr, name from usertbl; -- 이름을 다 출력하기 때문에 중복제거의 의미가 없음

-- limit 시작,끝(시작라인부터 끝라인에 해당하는 값만 나옴)
select distinct addr, name from usertbl limit 3,7;

-- 테이블 복사 쿼리
create table usertbl_copy (select * from usertbl);
-- 15:08:49	create table usertbl_copy (select * from usertbl)	10 row(s) affected Records: 10  Duplicates: 0  Warnings: 0	0.047 sec
select * from usertbl_copy;

create table usertbl_copy2 (select name, addr from usertbl);
select * from usertbl_copy2;

create table usertbl_copy3  as select name, addr from usertbl;
select * from usertbl_copy3;

-- 테이블 구조 복사
create table usertbl_copy4  (select * from usertbl where 1=0);
select * from usertbl_copy4;

-- 집계 함수
select * from buytbl;

select sum(price) as total_price from buytbl; -- 별칭 total_price

-- 구매 총액을 구하시오
select sum(price*amount) total_buy_price from buytbl; -- 별칭을 줌 total_buy_price 

-- GROUP BY
select addr, avg(height) avg_height from usertbl group by addr;

-- 고객별 평균 구매 갯수
select userID, avg(amount) as avg_amount from buytbl group by userID;
-- 고객별 총 구매 갯수
select userID, sum(amount) as sum_amount from buytbl group by userID;
-- 고객별 평균 구매액
select userID, avg(price*amount) from buytbl group by userID;

-- 키가 가장 큰 사람과 가장 작은 사람의 이름과 키 출력
-- 가장 작은 키와 가장 큰 키
select max(height),min(height) from usertbl;
select name, height from usertbl where height = 166
union
select name, height from usertbl where height = 186;

select name, height 
from usertbl 
where height = (select max(height) from usertbl)
		or height = (select min(height) from usertbl);
        
-- having절
-- 사용자별 총 구매액
select *
	from
    (
		select userid, sum(price*amount) totalprice
			from buytbl group by userid
		) T -- 테이블을 새로 정의(서브쿼리)
	where T.totalprice>=1000;

select userid, sum(price*amount) totalprice
	from buytbl group by userid
    having sum(price*amount) > 1000;


-- ROLLUP : 총합 또는 중간 합계가 필요할 경우 사용
select *
from buytbl
group by groupName, num;

select groupName,num,sum(price*amount)
from buytbl
	group by groupName, num
    with rollup;
    
    
-- insert문 : 테이블에서 정한 순서대로 값을 다 줘야함
create table testtbl1 (id int, userName char(3), age int);
INSERT INTO testtbl1 VALUES (1, '홍길동', 25); -- 속성의 값을 다 준다면 생략 가능
INSERT INTO testtbl1 (id, userName) VALUES (2, '설현'); -- 일부만 넣을 때는 속성 지정 필요
INSERT INTO testtbl1 (userName, age, id)VALUES('홍길동', 26, 3);
select * from testtbl1;

-- AUTO_INCREMENT : 자동 증가, NULL로 표현
create table testtbl2 
	(id int auto_increment primary key, 
    userName char(3),
    age int);
INSERT INTO testtbl2 VALUES (NULL, '지민', 25); 
INSERT INTO testtbl2 VALUES (NULL, '유나', 22);
INSERT INTO testtbl2 VALUES (NULL, '유경', 21);
select * from testtbl2;

-- 대량 샘플 데이터 생성
insert into testtbl2
	select null, username, age from testtbl2;
    


-- update
update testtbl2 set username = '김', age from testtbl2; -- 테이블의 모든 내용이 바뀌는 문장이지만 safe모드 사용시 변경되지 않고 에러 처리된다.
update testtbl2
	set username = '김', age = 10
    where id =1; -- id가 1번인 사람이 김으로 바뀜
    
-- delete
delete from testtbl2
    where id =1; -- id가 1번인 사람 삭제

-- 업데이트 딜리트 할 때 실수 방지 하는 법
-- 백업정책을 가져간다 table_copy
-- 조회를 한다. 그래서 원하는 데잍터만 나오는지 확인하고 그상태에서 업데이트 딜리트로 변경하고 실행

update testtbl2
set username = '아무개'
where id = 3;
