-- employees db에서 연습
-- CRUD
-- C : insert
-- R : select
	--	where, group by, having , sub-query, order by
-- U : update
-- D : delete

-- table create
	-- table copy : 구조와 데이터, 구조만
-- view create
-- describe 테이블 : 테이블 구조
-- use 데이터 베이스 : 데이터베이스 활성화
-- department 테이블 조회 
use employees;
describe departments;
select * from departments;
select * from dept_emp;
select * from employees;
describe employees;

-- employess 성별 카운드.. 남자는 : 명 여자는 : 명
select gender, count(gender) ccnt
from employees
group by gender;

-- 남성직원 정보 조회
select *
from employees
where gender="M";

-- 1955년 이후 출생한 직원
select *
from employees
where birth_date > '1955-01-01';

-- 이름이 'John'직원조회
select *
from employees
where first_name = "John";

-- 이름이 'Parto' 또는 'Smith' 직원조회
select *
from employees
where first_name = "Parto" or first_name = "Smith";

-- 직원번호가 10001 직원 조회
select *
from employees
where emp_no = 10001;

-- 입사일이 2000년 이후인 직원
select *
from employees
where hire_date > '2000-01-01';

-- 이름이 'A'로 시작하는 직원의정보 조회
select *
from employees
where first_name like 'A%';

-- 출생연도별 직원 수 조회
select year(birth_date) year,count(*)
from employees
group by year(birth_date);

-- max를 이용해서 가장 최근에 입사한 직원 정보 찾
select *
from employees
where hire_date = (select max(hire_date) from employees);

-- 각 성별로 가장 나이가 많은 직원
select gender, min(birth_date)
from employees
group by gender;

select *
from employees
where birth_date in (
	select min(birth_date) from employees group by gender
    );

-- first_name 정렬(오름차순) 만약 같은 이름이면 last_name 별로 정렬(오름차순)
-- order by
select *
from employees
order by first_name, last_name;

select *
from employees
order by first_name, last_name desc;