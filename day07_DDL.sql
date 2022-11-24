-- day07_DDL.sql
-- DDL : create, alter, drop
-- 테이블 생성
/* [1] 컬럼 수준에서 제약
	create table 테이블명(
		컬럼명 컬럼타입 제약조건
        ....
	);
	
    [2] 테이블 수준에서 제약
	create table 테이블명(
		컬럼명 컬럼타입,
        ....,
        제약조건
	);

*/
-- 테이블 수준에서 제약
create table test_tab1(
	id int,
    name varchar(10),
    constraint test_tab1_id_pk primary key (id)
);

desc test_tab1;

-- 컬럼 수준에서 제약.
create table test_tab2(
	id int primary key,
    name varchar(10)
);
-- 제약 조건 삭제
-- alter table 테이블명 drop 제약조건 유형

-- test_tab1에서 primarykey 제약조건을 삭제하세요
alter table test_tab1 drop primary key;

desc test_tab1;

-- 제약 조건 추가
-- alter table 테이블명 add 제약조건 유형 (컬럼명)
-- test_tab1에 primary key 제약조건을 다시 추가하세요
alter table test_tab1 add primary key (id);
alter table test_tab1 add constraint test_tab1_id_pk primary key (id);

desc test_tab1;

-- 예약 테이블을 아래와 같은 조건으로 생성하세요
/*
	num int 
    userid varchar(16)
    reserve_date date
    room_num smallint
    room_type enum('single', 'double')
    
    num 컬럼에 primary key 제약조건을 테이블 수준에서 주세요.
    
*/
create table reservation(
	num int,
    userid varchar(16),
    RESERVE_DATE date default (current_date),
    room_num smallint unsigned,
    room_type enum ('single', 'double'),
    primary key (num)
);
INSERT INTO RESERVATION
VALUES(1, 'HONG', CURDATE(), 101, 'SINGLE');

select * from RESERVATION;
insert into reservation(num, userid, room_num, room_type)
values(2, 'KIM', 201, 'DOUBLE');

DESC RESERVATION;

-- 2. forein key (외래키) 제약 조건
-- 		부모 테이블의 기본키를 참조하는 컬럼 또는 컬럼.
-- 		기본키의 컬럼과 외래키의 자료형이 일치해야 한다.
-- 		외래키에 의해 참조되고 있는 기본키는 삭제할 수 없다.
-- 		on delete cascade / on update cascade 옵션을 주면,
-- 		정의된 외래키는 그 기본키가 삭제/수정 될 때 같이 삭제/수정 된다.

-- master 테이블
create table dept_tab(
	deptno int,
    dname char(14),
    loc char(15),
    primary key (deptno)
);
desc dept_tab;
create table emp_tab(
	empno int primary key,
    ename varchar(10), 
    job varchar(10),
    mgr int,
    hiredate datetime default now(),
    sal decimal(7,2),
    comm decimal(7,2),
    deptno int,
    foreign key (deptno) references dept_tab (deptno) on delete cascade,
    -- mgr 컬럼을 외래키로 제약하세요 empno를 참조하도록
    foreign key (mgr) references emp_tab (empno)
);

-- detail 테이블

desc emp_tab;

drop table emp_tab;

insert into emp_tab(empno, ename, deptno)
values(1111, 'scott',10);

insert into emp_tab(empno, ename, deptno)
values(1112, 'smith',20);
commit;

select * from emp_tab;

select * from dept_tab;

insert into dept_tab
values(10,'accounting','new york');
insert into dept_tab
values(20,'sales','new york');
insert into dept_tab
values(30,'operation','seoul');

delete from dept_tab where deptno=30;
delete from dept_tab where deptno=10;
rollback;
-- on delete cascade 를 주면 해당 부서의 소속된 사원이 있어도 
-- 해당 부서를 삭제할 수 있다.

select * from dept_tab;
select * from emp_tab;

create table uni_tab(
	num int auto_increment primary key,
    name varchar(10) not null,
    userid varchar(8), 
    unique (userid)
);

desc uni_tab;

insert into uni_tab
values(null, '김영희', null);
/*
Error Code: 1062. Duplicate entry 'hong' for key 'uni_tab.userid'

*/
select * from uni_tab;

-- 4. not null 제약조건
-- null 값이 들어가는것을 방지한다.

create table nn_tab(
	deptno int not null,
    dname varchar(10)
);

desc nn_tab;

insert into nn_tab values(1,null);

/*-- insert into nn_tab values(null,'tom');
Error Code: 1048. Column 'deptno' cannot be null

*/
select * from nn_tab;

alter table nn_tab add loc char(10);

desc nn_tab;

-- dname에 not null 추가하기
alter table nn_tab modify column dname varchar(10) not null;

delete from nn_tab;
commit;
select * from nn_tab;

-- 5. check 제약 조건
-- 행이 만족해야 하는 조건을 정의한다

create table member_tab(
	num int auto_increment primary key,
    name varchar(20) not null,
    age tinyint unsigned null check (age >19),
    phone char(13)
);
desc member_tab;

insert into member_tab
values(null, '홍길동',20,'1111');

/*-- insert into member_tab values(null, '홍길동',2,'1112');

Error Code: 3819. Check constraint 'member_tab_chk_1' is violated.

*/

select * from member_tab;

use schooldb;

create table if not exists user_tab(
	no int, 
    name varchar(20),
    userid varchar(15),
    tel char(13),
    email varchar(50),
    primary key (no),
    unique (userid)
);
-- name 컬럼에 not null 제약조건 추가
-- not null 제약조건을 컬럼 수준에서 제약해야 한다.
alter table user_tab modify name varchar(20) not null;

desc user_tab;

create table if not exists board(
	idx int auto_increment primary key,
    userid varchar(15),
    title varchar(100),
    content varchar(1000),
    writedate datetime default now(),
    foreign key (userid) references user_tab (userid)
);
desc board;
-- subquery를 이용한 테이블 생성

-- create table 테이블명 as subquery

-- 사원 테이블에서 30번 부서에 근무하는 사원의 정보만 추출하여 EMP_30 테이블을 생성하여라. 
-- 단 열은 사번,이름,업무,입사일자, 급여,보너스를 포함한다
create table emp_30 
as select empno,ename,job,hiredate,sal,comm
from emp
where deptno = 30;

-- [문제1]
-- 		EMP테이블에서 부서별로 인원수,평균 급여, 급여의 합, 최소 급여,
-- 		최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
create table emp_state
as
select deptno, count(*) CNT, avg(sal) AVG_SAL, 
sum(sal) SUM_SAL, min(sal) MIN_SAL, max(sal) MAX_SAL
from emp
group by deptno;

select * from emp_state;

-- 	[문제2]	EMP테이블에서 사번,이름,업무,입사일자,부서번호만 포함하는
-- 		EMP_TEMP 테이블을 생성하는데 자료는 포함하지 않고 구조만 생성하여라.
create table emp_temp
as
select empno, ename, job, hiredate, deptno
from emp where 1=4;

select * from emp_temp;

-- drop table [if exists] 테이블명;
drop table if exists emp_temp;

-- alter 문장 
-- 컬럼 추가/ 변경 / 삭제하고자 할 때 사용

-- alter table 테이블명 add 추가할 컬럼정보
-- alter table 테이블명 modify 수정할 컬럼정보
-- alter table 테이블명 drop column 삭제할 컬럼명
-- alter table 테이블명 rename column 예전 컬럼명 to 새 컬럼명

create table test_tab(
no int);

-- test_tab에 name 컬럼을 추가. varchar(20)
alter table test_tab add name varchar(20) not null;

desc test_tab;

-- test_tab의 no 컬럼의 자료형을 char(2) 로 수정하세요
alter table test_tab modify no char(2);

-- test_tab의 name 컬럼을 삭제하세요
alter table test_tab drop column name;

-- test_tab의 no 컬럼명을 num 으로 변경하세요
-- alter table test_tab modify num char(2); [x]
/* 
Error Code: 1054. Unknown column 'num' in 'test_tab'

*/
-- alter table 테이블명 rename column old_col to now_col

alter table test_tab rename column no to num;

desc test_tab;

-- view 
-- 가상의 테이블
-- 데이터의 복잡성을 감소시킴
-- 복잡한 질의문을 단순화시킨다
-- 테이블 데이터를 다양한 관점으로 보여준다.

-- create view 뷰이름
-- as select 컬럼명1, 컬럼명2 from 테이블명 where 조건절

-- emp 테이블에서 20번 부서의 모든 컬럼을 포함하는 emp20_view를 생성하라.
drop view emp20_view;
create view emp20_view
as
select * from emp where deptno=20;

select * from emp20_view;

-- EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
-- 	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라
create view emp30_view
as
select empno emp_no, ename name, sal salary from emp where deptno=30;

-- 고객테이블의 고객 정보 중 나이가 19세 이상인 고객의 정보를
-- 	확인하는 뷰를 만들어보세요.
-- 	단 뷰의 이름은 MEMBER_19로 하세요.
create or replace view member_19_vw
as
select * from member where age>=19 ;

select * from member_19_vw;

-- category와 products, supply_comp 3개의 테이블을 join하여
-- view를 생성하세요. products_info_view
create or replace view products_info_view
as
select c.*, p.*, s.*
from category c join products p 
on c.category_code = p.category_fk
join supply_comp s
on p.ep_code_fk =s.ep_code;

select * from products_info_view;

-- with check option 절 이용

create or replace view emp10_view
as 
select * from emp
where deptno=10 with check option; -- 뷰를 만들 때, 조건이 강조됨.

select * from emp10_view;
select * from emp where empno=7782;
update emp10_view set job='salesman' where empno=7782;

-- view를 수정하면 원본 테이블도 변경이 된다.
/* -- update emp10_view set deptno=20 where empno=7782;
Error Code: 1369. CHECK OPTION failed 'schooldb.emp10_view'
*/

-- 원본 테이블 수정
update emp set deptno=20 where empno=7782;

-- 뷰 소스 확인
show create view emp10_view;

-- 뷰 삭제
-- drop view 뷰이름

drop view emp10_view;

-- index 생성
-- create index 인덱스명 on 테이블명 (컬럼명1[, 컬럼명2])

-- emp 의 ename 컬럼에 대해 인덱스를 생성하세요 emp_ename_indx

create index emp_ename_index on emp (ename); -- [방법1]

-- index 확인: show index from 테이블명
show index from emp;

-- alter로 인덱스 추가 [방법2]
alter table member add index member_name_indx (name);
show index from member;

select * from member where name like '%홍%';

-- 인덱스 삭제
-- drop index 인덱스명; ==> oracle
-- alter table 테이블명 drop index 인덱스명 ==> mysql

alter table member drop index member_name_indx;

show index from member;

-- 상품 테이블에서 인덱스를 걸면 좋을 컬럼을 찾아 인덱스를 생성하세요
create index products_category_indx on products (category_fk);
create index products_ep_code_indx on products (ep_code_fk);

show index from products;

-- products_category_indx /products_ep_code_indx  삭제하세요
alter table products drop index products_category_indx;

alter table products drop index products_ep_code_indx;

show index from products;

-- ---------------------------------------------------------------------------------

create table if not exists zipcode (
	post1 char(3),
    post2 char(3),
    addr varchar(100) not null,
    constraint zipcode_pk primary key (post1,post2)
);

desc zipcode;

create table member_tab(
	id varchar(16) primary key,
    name varchar(30) not null,
    gender char(1),
    jumin1 char(6),
    jumin2 char(7),
    tel varchar(15),
    post1 char(3),
    post2 char(3),
    addr1 varchar(100),
    addr2 varchar(100),
    foreign key(post1, post2) references zipcode(post1, post2),
    constraint members_tab_jumin1_jumin2 unique(jumin1, jumin2),
    check (gender in ('M','F'))
);

desc member_tab;

