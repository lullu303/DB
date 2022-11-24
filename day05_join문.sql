-- day05_join문.sql

-- 사원의 부서 이름을 결정하기 위해 EMP테이블의 DEPTNO와 DEPT테이블의 DEPTNO와 값을 비교해야 한다.
-- 	EMP테이블과 DEPT테이블 사이의 관계는 양쪽 테이블의 DEPTNO열이 같아야 한다. 
-- # equi join 또는 inner join

-- 명시적 join문을 이용한 조인 => 표준. [방법 1]
select dept. deptno, dname, empno, ename, job, loc
from dept join emp
on dept.deptno = emp.deptno order by 1;

select D.*, E.*
from dept D join emp E
using(deptno) order by 1;


-- [방법 2]
select D.deptno, dname, ename, job
from dept D,  emp E
where D.deptno = E.deptno order by 1;

-- JOIN조건에  AND 를 이용해서 추가적인 조건을 준다. WHERE 절을 이용해서 추가적인 조건을 줄 수도 있다.
-- SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.( emp/ dept )
select empno, ename, sal, dname, loc, job -- [1. where 를 사용한 조인]
from emp E join dept D
using (deptno) 
where job='salesman';

select empno, ename, sal, dname, loc, job -- [2. on 을 사용한 조인]
from emp E join dept D
on E.deptno = D. deptno and job ='salesman';

-- 상품 정보를 보여주되 해당 상품의 카테고리명을 함께 보여주세요
select P.*, CATEGORY_NAME 
from category C, products P
where C.CATEGORY_CODE = P.CATEGORY_FK;

-- 카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
-- 제조업체가 삼성인 상품의 정보만 추출하여 카테고리 이름과 상품이름, 상품가격 제조사 등의 정보를 화면에 보여주세요.
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY -- [1. where 를 사용]
FROM CATEGORY C, PRODUCTS P
WHERE C.CATEGORY_CODE = P.CATEGORY_FK AND COMPANY='삼성';

SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY -- [2. on 을 사용]
from category C join products p
on C.CATEGORY_CODE = P. CATEGORY_FK and company='삼성';

-- 각 상품별로 카테고리 및 상품명, 가격을 출력하세요. 단 카테고리가 'TV'인 것은 
-- 제외하고 나머지 정보는 상품의 가격이 저렴한 순으로 정렬하세요.
SELECT PRODUCTS_NAME, CATEGORY_NAME, OUTPUT_PRICE, COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK 
WHERE CATEGORY_NAME <> 'TV';

-- 2. non=equi join
-- equal(=) 이 아닌 연산자나 기호를 이용해서 조인 조건을 준 경우.

-- 직원의 정보를 보여주되, 직원 급여의 등급과 등급 구간정보도 함께 보여주세요.

select * from salgrade;

-- between A and B 연산자 이용해서 풀어보기.
select E.empno, ename, sal, grade, losal, hisal
from emp E join salgrade S
on E.sal between S.losal and S.hisal order by grade;

-- 3. outer join
-- 부서와 사원 정보를 함께 보여주되, 사원이 없는 부서 정보도 함께 보여주세요.
-- left outer join : 왼쪽에 있는 테이블을 기준으로 출력
-- right outer join : 오른쪽에 있는 테이블을 기준으로 출력

select D.deptno, dname, ename, job
from dept D left outer join emp E
on D.deptno = E. deptno order by 1;

select E.DEPTNO, D. DEPTNO
from emp E join dept D
using(deptno);


-- full outer join
-- union 연산자를 이용하여 양쪽 테이블에 다 outer join을 걸 수 있다.

-- left outer join 을 구하고
-- right outer join 을 구한 뒤
-- 그 두 결과를 union으로 합친다.

select distinct(A.deptno), B.deptno
from emp A left outer join dept B
using (deptno)
union
select distinct(A.deptno), B.deptno
from emp A right outer join dept B
using (deptno) order by 2;

-- products(ep_code_fk) supply_comp(ep_code)
-- 상품테이블의 모든 상품을 공급업체, 공급업체코드, 상품이름, 상품공급가, 상품 판매가 순서로 출력하되 공급업체가 없는
-- 상품도 출력하세요(상품을 기준으로=right / 공급업체 관점=left).
select s.ep_code, ep_name, p.ep_code_fk,
company,products_name,input_price,output_price
from products p left outer join supply_comp s
on p.ep_code_fk = s.ep_code;

select * from supply_comp;
select * from products;

-- category, products, supply_comp
-- 상품테이블의 모든 상품을 공급업체, 카테고리명, 상품명, 상품판매가 순서로 출력하세요. 단, 공급업체나 상품 카테고리가 없는
--  상품도 출력합니다. (상품 관점)

select category_name, products_name, OUTPUT_PRICE, ep_name
from category C right outer join products P
on C.category_code = P.category_fk
left outer join supply_comp S
on P.ep_code_fk = S.ep_code;

-- 4. self join
-- 자기 테이블과 자체적으로 조인하는 경우

-- 사원 테이블에서 "누구의 관리자는 누구입니다"는 내용을 출력하세요
-- "smith의 관리자는 ford입니다"
select * from emp;
select concat( E.ename, '의 관리자는',E1.ename)
from emp E join emp E1
on E.MGR=E1.EMPNO;

-- 5. cross join (cartesian product)
-- 모든 가능한 행들을 결합
-- 조인 조건을 걸지 않을 경우
-- 조인 조건을 잘못 걸었을 경우

select D.*, ename, job
from dept D, emp E order by 1;
-- 6 x 14 = 84 개의 레코드가 나옴.

-- 2. emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
--     부서명을 출력하는 SELECT문을 작성하세요
select dname, ename, job, sal, loc
from emp E join dept D 
using (deptno)
where loc='new york';

-- 3. EMP테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는
--     SELECT문을 작성하세요
select ename, dname, loc, sal, comm
from emp E join dept D
using (deptno)
-- where comm >=0;
where comm is not null;

-- 4. EMP테이블에서 이름 중 L자가 있는 사원에 대해 이름,업무,부서명,위치를 
--    출력하는 문장을 작성하세요.
select ename, dname, loc, job
from emp E join dept D
using (deptno)
where ename like '%L%';
--    
-- 5. 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
-- 	모든 사원을 출력)

-- 	---------------------------------------------
-- 	Emplyee		Emp#		Manager	Mgr#
-- 	---------------------------------------------
-- 	KING		7839
-- 	BLAKE		7698		KING		7839
-- 	CKARK		7782		KING		7839
-- 	.....
-- 	---------------------------------------------

select e.ename "Employee", e.empno "Emp#",
m.ename "Manager", m.empno "Mgr#"
from emp e left outer join emp m
on e.mgr = m.empno order by 3;

