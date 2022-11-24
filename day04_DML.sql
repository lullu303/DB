-- day04_DML.sql

-- dept테이블에 50 Education Seoul
-- insert into 테이블명(컬럼명1, 컬럼명2, ...) values(값1, 값2, ...)

insert into dept (deptno, dname, loc)
values(50, 'EDUCATION', 'SEOUL');
commit; -- transaction

-- mysql은 디폴트가 auto commit
select @@autocommit;

-- auto commit 해제
set autocommit =0;

-- 60 planning busan
insert into dept 
values (60,'planning', 'busan');
-- commit;  -- 데이터베이스에 영구히 반영.
rollback; -- 취소
commit;

select * from dept;

delete from dept;

-- 다른 테이블로부터 복사
-- insert into 테이블명 subquery
create table emp_10
as select empno, ename, job, sal, deptno from emp
where 1=0;

select * from emp_10;

-- 테이블 구조만 복사
-- drop table emp_10;

show tables;

select * from emp_10;

insert into emp_10
select empno, ename, job, sal, deptno from emp where deptno=10;

-- member 테이블을 카피해서 member_20을 만드세요. 단 테이블 구조만 복사하세요.
-- 고객 테이블에서 20세 이상인 회원정보들만 가져와서 member_20에 삽입하세요

create table member_20
as select *from member
where 1=0;

select *from member_20;

insert into member_20
select * from member where age >= 20;

commit;

-- insert 해서 회원정보 3명을 추가하세요
insert into member_20(num, userid, name, passwd, age, reg_date, addr, mileage)
values(11,'hong','홍길동', '3333',22,curdate(), '부산시', 3300);

select * from member_20 order by num desc;

insert into member_20
values(12,'kim','김철수', '1212',24,1500, '학생','경주시',curdate());

insert into member_20
values(13,'kim110','이순신', '1213',28,1500, '장군','해운대',curdate());
commit;

desc member_20;

-- update 문
-- 데이터 수정 시 사용.
-- update 테이블명 set 컬럼명1=값1, 컬럼명2=값2,...;
-- update 테이블명 set 컬럼명1=값1, 컬럼명2=값2,... where 조건='값'

-- emp를 카피해서 emp2로 만들고, 데이터와 구조를 모두 복사하세요
create table emp2
as select *from emp;

select * from emp2;

-- emp2테이블에서 사번이 7788인 사원의 부서번호를 10으로 수정하세요.
select *from emp2 where empno=7788;
update emp2 set deptno=10 where empno=7788;
rollback;
commit;
select * from emp2;
 
-- emp2 테이블에서 사번이 7788인 사원의 부서를 20, 급여를 3500으로 변경하여라. 
update emp2 set deptno=20, sal=3500 where empno=7788;
select *from emp2 where empno=7788;
commit;

-- emp2테이블에서 부서를 모두 10으로 변경하여라.
update emp2 set deptno=10;
select * from emp2;
rollback;

-- 1] 고객 테이블 중 이름이 '김길동'인 사람의 이름을 박길동으로 변경하세요.
-- ...김길동이 2명일 경우...where조건절을 좀 더 구체적으로 하여 변경한다.
create table member3
as select *from member;

select * from member3;

update member3 set name='박길동' where name='김길동';
select *from member3 where name='박길동';
commit;
-- 	 2] 등록된 고객 정보 중 고객의 나이를 현재 나이에서 모두 5를 더한 값으로 
-- 	      수정하세요.
update member3 set age= age+5;
rollback;

-- 	 2_1] 고객 중 13/09/01이후 등록한 고객들의 마일리지를 350점씩 올려주세요
select * from member3;
commit;

update member3 set mileage=mileage+350
where reg_date > '2013-03-01';
rollback;

-- 등록되어 있는 고객 정보 중 이름에 '김'자가 들어있는 모든 이름을 '김' 대신
-- '최'로 변경하세요.
update member3 set name=replace(name, '김', '최');

select * from member3;
rollback;

update member3 set name=replace(name, '김', '최')
where name like '김%';

use schooldb;
show tables;

-- delete 문
-- delete from 테이블; => 모든 레코드 삭제
-- delete from 테이블 where 조건절;

select @@autocommit;
set autocommit=0; -- 수동 커밋을 설정

create table if not exists emp2
as select * from emp;

select * from emp2;

-- EMP2테이블에서 사원번호가 7499인 사원의 정보를 삭제하라.
delete from emp2 where empno = 7499;

-- EMP2테이블에서 입사일자가 83년인 사원의 정보를 삭제하라.
delete from emp2 where year( hiredate )='1983';
delete from emp2 where date_format(hiredate, '%y')='83';
rollback;

-- EMP2테이블의 자료 중 부서명이 'SALES'인 사원의 정보를 삭제하라.
select * from emp2;
select * from dept;
	delete from emp2 where deptno=30;
    delete from emp2 where deptno= (select deptno from dept where dname='sales');
	
    rollback;
-- 1] 상품 테이블에 있는 상품 중 상품의 판매 가격이 10000원 이하인 상품을 모두 
-- 	      삭제하세요.
	delete from products where output_price <= 10000;
    select * from products;
    rollback;
-- 	2] 상품 테이블에 있는 상품 중 상품의 대분류가 도서인 상품을 삭제하세요.
select * from category;
delete from products where category_fk=
(select category_code from category where category_name='도서');
delete from products where category_fk like '0003%';

rollback;
delete from products where category_fk like
concat((select substring(category_code,1,4 )
from category where category_name='도서'), '%');

select substring(category_code,1,4 )from category where category_name='도서';
rollback;

-- emp2에 있는 모든 사원정보를 삭제하세요
delete from emp2;
select * from emp2;

-- truncate: delete와 기능이 같으나 더 빠르다.
truncate emp2;

create table dept2
as
select * from dept;

select * from dept2;

insert into emp2
select * from emp;

select * from emp2;

-- dept2테이블에 deptno를 pk로 제약조건 주기
alter table dept2 add constraint primary key (deptno);

desc dept2;

-- emp2에 empno에 pk제약조건을 추가.
alter table emp2 add constraint primary key (empno);
desc emp2;

-- emp2의 deptno에 fk 제약조건을 추가하기
alter table emp2 add constraint foreign key (deptno) references dept2 (deptno);
desc emp2;

select * from dept2;
select * from dept;

drop table dept2;
SELECT * FROM DEPT;
create table dept2 AS SELECT * FROM DEPT;
select * from dept2;

-- 부모테이블 dept2, 자식테이블 emp2
-- 사원은 부서에 소속되어 있다. 1대 다 관계

-- dml 작업 시 발생할 수 있는 문제

insert into emp2(empno, ename, job, deptno)
values(8000,'PETER', 'MANAGER',40);

insert into emp2(empno, ename, job, deptno)
values(8002,'TOM', 'MANAGER',70);
/*Error Code: 1452. Cannot add or update a child row:
 a foreign key constraint fails 
 (`schooldb`.`emp2`, CONSTRAINT `emp2_ibfk_1` 
 FOREIGN KEY (`DEPTNO`) REFERENCES `dept2` (`DEPTNO`))
*/
select * from emp2;
select * from dept2;

-- 7369번 사원의 부서번호를(20) 40번 부서로 수정하세요
update emp2 set deptno=40 where empno=7369;
select * from emp2;

update emp2 set deptno=80 where empno=7499;

select * from dept2;

select * from emp2 where deptno=30;

-- dept2에서 60번 부서를 삭제하시오
delete from dept2 where deptno=60;
rollback;
select * from dept2;

-- dept2에서 30번 부서를 삭제하세요
delete from dept2 where deptno=30;
/*Error Code: 1451. Cannot delete or update a parent row:
 a foreign key constraint fails (`schooldb`.`emp2`,
 CONSTRAINT `emp2_ibfk_1` FOREIGN KEY (`DEPTNO`) 
 REFERENCES `dept2` (`DEPTNO`))
*/

-- 외래키 제약조건을 줄 때,  on delete cascade, on update cascade 옵션을 
-- 주면 자식 레코드가 있어도 부모 레코드를 삭제 또는 수정할 수 있다.
