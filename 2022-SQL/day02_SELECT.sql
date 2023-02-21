-- Ctrl +T :  새로운 sql탭이 열림
-- Ctrl + Enter : 커서가 있는 위치의 쿼리문을 실행시킨다.
-- Ctrl + Shift + Enter: 전체 실행.
-- day02_SELECT.sql
/*
*/
show databases;
use schooldb;
show tables;
select * from dept;
select * from emp;
select * from salgrade;
select * from category;
select * from products;
select * from supply_comp;

SELECT empno, ename, sal, comm, hiredate from emp;
select ename from emp;
select * from emp; -- 모두 보고자 할 때

select ename, sal, comm, sal+comm from emp;

-- null을 가진 컬럼을 연산에 사용하면 그 결과는 null이다.
-- ifnall(컬럼, 값)
select ename, sal, comm, job, sal*12+ ifnull(comm,0) as "연 봉" from emp;

-- concat(컬럼1, 컬럼2) : 컬럼1과 컬럼2를 결합하고자 할 때 사용한다.
select concat('My','S', 'QL');

select concat(ename, ' Is A', job)from emp;

-- 문제] EMP테이블에서 이름과 연봉을 "KING: 1 YEAR SALARY = 60000"
-- 	형식으로 출력하라.
select concat (ename, ': 1 YEAR SALARY = ',sal*12+ifnull(comm,0)) as "사원의 연봉"
from emp order by sal*12+ifnull(comm,0) desc;

-- DISTINCT: 중복된 행을 제거하고 하나로 보여준다.
-- EMP에서 업무(JOB)를 모두 출력하세요
select job from emp;
-- EMP에서 담당하고 있는 업무의 종류를 출력하세요.
select distinct job from emp;


select distinct name, age from member;


-- emp에서 중복되지 않는 부서번호(deptno)를 출력하세요
select distinct deptno from emp;

-- member테이블에서 이름, 나이, 직업을 보여주세요
select name, age, job from member order by name;
 
-- member 테이블에서 회원의 이름과 적립된 마일리지를 보여주되,
--       마일리지에 13을 곱한 결과를 "MILE_UP"이라는 별칭으로
-- 	      함께 보여주세요.
select name, ifnull(mileage,0)*13  as "MILE_UP" from member;

-- where절을 이용해서 조건을 걸 수 있다.
-- emp에서 급여가 3000이상인 사원의 사번 이름, 업무, 급여를 출력하세요
select empno, ename, job, sal from emp 
where sal >= 3000;


-- WGHOL 순서로 기술.
-- WHERE, GROUP BY, HAVING, ORDER BY, LIMIT 순서

-- 문자열, 날짜는 ''를 붙여서 사용한다.
-- JOB이 MANAGER인 사원의 이름, 업무 입사일을 보여주세요
select ename, job, hiredate from emp 
where job='MANAGER';
    
    -- EMP테이블에서 1982년 1월1일 이후에 입사한 사원의 
	-- 사원번호,성명,업무,급여,입사일자를 출력하세요.
select empno, ename, job, sal, hiredate from emp 
where hiredate >'1982.01.01';

	-- emp에서 급여가 1300~1500 사이인 사원의 이름, 업무, 급여, 부서번호 출력하세요.
select ename, job, sal, deptno from emp 
where sal between 1300 and 1500;

    -- emp테이블에서 사원번호가 7902,7788,7566인 사원의 사원번호,
	-- 이름,업무,급여,입사일자를 출력하세요.
 select empno, ename, job, hiredate 
 from emp 
 where empno= 7902 or empno=7788 or empno=7566;
 
 select empno, ename, job, hiredate 
 from emp 
 where empno in(7902, 7788, 7566);
 
    -- 10번 부서가 아닌 사원의 이름,업무,부서번호를 출력하세요
select ename, job, deptno 
from emp 
where deptno <>10 order by deptno;

select ename, job, deptno 
from emp 
where deptno !=10 order by 3; 

-- [문제]
-- 	emp테이블에서 업무가 SALESMAN 이거나 PRESIDENT인
-- 	사원의 사원번호,이름,업무,급여를 출력하세요.
select empno, ename, job, sal 
from emp
where job='salesman' or job='president';

-- 	커미션(COMM)이 300이거나 500이거나 1400인 사원정보를 출력하세요
select empno, ename, job, sal, comm
from emp
where comm=300 or comm=500 or comm=1400;

-- 	커미션이 300,500,1400이 아닌 사원의 정보를 출력하세요
select empno, ename, job, sal, comm
from emp
where comm !='300' and comm !='500' and comm !='1400';

-- like 연산자 //게시판 검색할 때 사용. 
-- where 컬럼명 like '조건'
-- where 컬럼명 like '%조건'
-- where 컬럼명 like '조건%'
-- where 컬럼명 like '%조건%'

select ename, job
from emp
where ename like 's%';

select ename, job
from emp
where ename like '%s';

select ename, job
from emp
where ename like '%s%'; -- 이름 어디에든 s가 들어가면 다 나옴.

-- 이름 두번째에 O자가 들어가는 사원정보
-- '_'는 하나의 문자와 대치된다.
select ename, job
from emp where ename like '_O%'; 

-- EMP테이블에서 입사일자가 82년도에 입사한 사원의 사번,이름,업무
-- 	   입사일자를 출력하세요.	 
select empno, ename, job, hiredate from emp 
where hiredate like '1982%';

select empno, ename, job, hiredate from emp 
where date_format(hiredate, '%Y') like '82';

select date_format(hiredate,'%Y'), date_format(hiredate,'%y')
from emp;

-- 고객(member) 테이블 가운데 성이 김씨인 사람의 정보를 보여주세요.
select * from member 
where name like '김%';

-- 고객 테이블 가운데 '강남구'가 포함된 정보를 보여주세요.
select * from member 
where addr like '%강남구%';

-- emp에서 comm이 null인 사원의 사번, 이름, 커미션을 가져와 출력하세요
-- null 값을 비교할 때는:  =로 비교하면 데이터를 가져오지 못함. [1]
-- 					: is null연산자를 사용한다. [2]
select empno, ename, comm from emp -- [1]
where comm = null;

select empno, ename, comm from emp -- [2]
where comm is null;

select empno, ename, comm from emp -- [3]
where comm is not null;

-- AND : 양쪽 조건이 TRUE이면 TRUE를 반환
-- OR : 하나라도 TRUE이면 TRUE를 반환
-- NOT : FALSE는 TRUE

-- EMP테이블에서 급여가 1100이상이고 JOB이 MANAGER인 사원의
-- 	사번,이름,업무,급여를 출력하세요.
select empno, ename, sal from emp
where (sal>=1100) and (job='manager');

-- EMP테이블에서 급여가 1100이상이거나 JOB이 MANAGER인 사원의
-- 	사번,이름,업무,급여를 출력하세요.
select empno, ename, sal from emp
where (sal>=1100) or (job='manager');

-- EMP테이블에서 JOB이 MANAGER,CLERK,ANALYST가 아닌
-- 	  사원의 사번,이름,업무,급여를 출력하세요.
select empno, ename, sal from emp
where job not in( 'manager' ,'clerk' ,'analyst');

-- [문제]
-- 	- EMP테이블에서 급여가 1000이상 1500이하가 아닌 사원의 모든 정보를 출력하세요
select * from emp
where sal not between 1000 and 1500;

--  - EMP테이블에서 이름에 'S'자가 들어가지 않은 사람의 이름을 모두 출력하세요.
select ename from emp
where ename not like  '%s%';

-- 	- 사원테이블에서 업무가 PRESIDENT이고 급여가 1500이상이거나
-- 	   업무가 SALESMAN인 사원의 사번,이름,업무,급여를 출력하세요.
select empno, ename, job, sal from emp
where (job='president' and sal >=1500) or job ='salesman';

-- 	- 고객 테이블에서 이름이 홍길동이면서 직업이 학생이 정보를 
-- 	    모두 보여주세요.
select * from member
where name='홍길동' and job='학생';

-- 	- 고객 테이블에서 이름이 홍길동이거나 직업이 학생이 정보를 
-- 	모두 보여주세요.
select * from member
where name='홍길동' or job='학생' order by name asc;

-- 	- 상품(products) 테이블에서 제조사(COMPANY)가 삼성 또는 대우 이면서 
-- 	   판매가가 100만원 미만의 상품 목록을 보여주세요.
select * from products
where (company ='삼성' or company='대우') and output_price < 1000000;

-- 연산자 우선순위
-- 비교 연산자> not > and > or
-- WGHOL

-- ORDER BY 절
-- ASC : 오름차순(디폴트)
-- DESC: 내림차순
-- NULL: 오름차순에서는 제일 뒤에, 내림차순에서는 제일 먼저 온다.

-- EMP에서 사번, 이름, 업무, 입사일을 가져와 출력하되 입사일자 순으로 가져오세요
select empno, ename, job, hiredate from emp
order by hiredate asc;

select empno, ename, job, hiredate from emp
order by hiredate desc;

select empno, ename, sal, sal*12 annsal
from emp order by sal*12 desc;

select empno, ename, sal, sal*12 annsal
from emp order by annsal asc;

select empno, ename, sal, sal*12 annsal
from emp order by 4 desc;

-- 사원 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우
-- 	급여가 많은 순으로 정렬하여 사번,이름,업무,부서번호,급여를
-- 	출력하세요.
    select empno, ename, job, deptno, sal
    from emp 
    order by deptno, sal desc;
    
-- 사원 테이블에서 첫번째 정렬은 부서번호로, 두번째 정렬은
-- 	업무로, 세번째 정렬은 급여가 많은 순으로 정렬하여
-- 	사번,이름,입사일자,부서번호,업무,급여를 출력하세요.
  select * from emp 
    order by deptno, job, sal desc;

-- 1] 상품 테이블에서 판매 가격이 저렴한 순서대로 상품을 정렬해서 보여주세요.
select * from products
order by output_price;

-- 2] 고객 테이블의 정보를 이름의 가나다 순으로 정렬해서 보여주세요.
--       단, 이름이 같을 경우에는 나이가 많은 순서대로 보여주세요.
select * from member
order by name, age desc;

-- 3] 상품 테이블에서 배송비의 내림차순으로 정렬하되, 
--     같은 배송비가 있는 경우에는 마일리지의 내림차순으로 정렬하여 보여주세요.
select * from products
order by trans_cost desc, mileage desc;

-- 상품 테이블에서 공급가가 가장 비싼 순으로 top3안에 드는 상품을 보여주세요
select products_name, input_price, output_price
from products
order by 2 desc limit 3;

select products_name, input_price, output_price
from products
order by 2 desc limit 3 offset 3;

select products_name, input_price, output_price
from products
order by 2 desc;

-- 1] 사원테이블에서 급여가 3000이상인 사원의 정보를 모두 출력하세요.
select * from emp
where sal >=3000;

-- 2] 사원테이블에서 사번이 7788인 사원의 이름과 부서번호를 출력하세요
select ename, deptno, empno from emp
where empno = '7788';

-- 3] 사원테이블이서 입사일이 1981 2월20일 ~ 1981 5월1일 사이에
--     입사한 사원의 이름,업무 입사일을 출력하되, 입사일 순으로 출력하세요.
select ename, job, hiredate from emp
where hiredate between '1982-02-20' and '1981-05-01' order by hiredate;

-- 4] 사원테이블에서 부서번호가 10,20인 사원의 이름,부서번호,업무를 출력하되
-- 	    이름 순으로 정렬하시오.
select ename, deptno, job from emp
where (deptno =10 or deptno=20) order by ename;

-- 	5] 사원테이블에서 1982년에 입사한 사원의 모든 정보를 출력하세요.
select * from emp
where hiredate like '1982%';

-- 	6] 사원테이블에서 보너스가 급여보다 10%가 많은 사원의 이름,급여,보너스
-- 	    를 출력하세요.
select ename, sal, comm from emp
where sal*1.1 < comm;

-- 7] 사원테이블에서 업무가 CLERK이거나 ANALYST이고
-- 	     급여가 1000,3000,5000이 아닌 모든 사원의 정보를 
-- 	     출력하세요.
select * from emp
where job in( 'clerk' ,'analyst') and sal not in (1000,3000,5000);

-- 	8] 사원테이블에서 이름에 L이 두자가 있고 부서가 30이거나
-- 	    또는 관리자가 7782번인 사원의 정보를 출력하세요.
select * from emp
where ename like '%LL%' and deptno = 30 or mgr =7782;
