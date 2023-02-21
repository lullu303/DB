-- crud(creat, read, update, delete)
-- database 사용하는 언어: SQL (Structured Query Language) 표준, Stroed Procedure
show databases;
-- 주석(단문 주석)
/* 복문주석
	여러 라인 주석
*/
-- 데이터베이스 생성
-- create database [IF NOT EXISITS] 데이터베이스명;
create database IF NOT EXISTS SCHOOLDB;

-- 사용할 데이터베이스를 지정 
-- USE 데이터베이스명;
-- 지금부터 이 데이터베이스를 사용하겠으니, 모든 쿼리(SQL문)는 이 DB에서 실행하란 의미
use SCHOOLDB;

-- 해당 데이터베이스의 테이블 목록을 확인해보자.
-- SHOW TABLES;

SHOW TABLES;

/*
학생 테이블 생성
학생(Entity ==> Table) 테이블 생성
	- 학번 (Attibute==> 필드, 컬럼) => 유니크한 값을 갖는 식별자 역할. Primary key
    - 이름
    - 연락처
    - 주소
    - 등록일
    - 학급명
	- 교실번호
*/

-- creat table 테이블명(
-- 	컬럼명 자료형(크기),
--     컬럼명 자료형(크기),
--     컬럼명 자료형(크기),
--     제약조건
-- );

create table student(
	num int primary key, -- PK 식별자 역할을 한다. (unique + NOT NULL)
    name varchar(30) not null, -- NN 제약조건
    tel varchar(15) not null, 
    addr varchar(100), 
    cname varchar(50),
    croom int 
);

-- 테이블 삭제
-- drop table 테이블명;
drop table student;

show tables;
-- 테이블 내용 확인 
desc student;

-- 학생 등록
-- INSERT문 이용
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2,...)
-- 	VALUES(값1, 값2,...);
-- CRUD 중 create문

INSERT INTO student(num, name, tel,addr,cname,croom)
values(4,'핑핑이','010-1111','부산시', '빅데이터sw반',201);

-- Read 조회
-- SELECT 컬럼명1, 컬럼명2 FROM 테이블명;

select NUM, NAME, CNAME, CROOM FROM STUDENT;

SELECT * FROM STUDENT;

insert into STUDENT(NUM, NAME, TEL)
VALUES(5, '징징이','AI서비스반');

insert into STUDENT(NUM, NAME, CNAME,TEL)
VALUES(6, '집게사장','AI서비스반','010-1212');
-- 컬럼명을 생략하고 INSERT하면 VALUES에 모든 값을 다 기술해야 한다.
INSERT INTO STUDENT
VALUES(7, '김영희', '010-6666', '김해시', 'AI서비스반',202);

INSERT INTO student(num, name, tel,addr,cname,croom)
VALUES(8, '퐁퐁부인', '010-6667', '창원시', '빅데이터SW반', 203);

insert into student(num, name, tel, addr, cname,croom)
values(9, '플랑크론', '010-6668', '밀양시', '빅데이터sw반', 204);

insert into student(num, name, tel, addr, cname, croom)
values(10, '선장님', '010-6669', '울산시', '빅데이터sw반', 205);

insert into student
values(11, '뚱이', '010-6670', '비키니시티', 'AI서비스반', 206);

insert into student
values(12, '조개소년','010-6671', '비키니시티', 'AI서비스반',207);

insert into student
values(13, '인어맨','010-6671', '비키니시티', 'AI서비스반',207);

insert into student
values(14, '파인애플 집','010-6672', '비키니시티', '풀스택 개발자반',207);

SELECT * FROM STUDENT order by NUM DESC;

-- 총학생 수
SELECT COUNT(NUM) FROM STUDENT;

-- 빅데이터SW반의 학생 수
select COUNT(NUM) FROM STUDENT 
where CNAME='빅데이터SW반'; -- 6명

select count(NUM) FROM STUDENT
where CNAME='AI서비스반'; -- 5명

select count(*) from STUDENT
WHERE CNAME LIKE '%풀스택%';

-- 학급별 인원수
select CNAME, count(*) from STUDENT
group by CNAME;

select * FROM STUDENT order by NAME ASC;

-- UPDATE 수정
-- update 테이블명 SET 컬럼명=수정할 값, 컬럼명2=수정할 값2
-- WHERE 조건절;

UPDATE STUDENT SET TEL='010-8989', CNAME='AI서비스반'
WHERE NUM=5;


-- DELETE 문
DELETE FROM 테이블명 WHERE 조건절;

DELETE FROM STUDENT WHERE NUM =8;

select * FROM STUDENT;

INSERT INTO STUDENT(NUM, NAME, TEL, CNAME,CROOM)
VALUES(15, '친칠라', '011-7777','빅데이터반', 203);

select * FROM STUDENT
WHERE CROOM =201;
-- WHERE CNAME='빅데이터SW반';

delete from STUDENT;

select * from STUDENT;

DROP TABLE STUDENT;

SHOW TABLES;

-- 학급테이블

CREATE TABLE MCLASS(
	CNUM INT auto_increment primary KEY, -- 4BYTE
    CNAME varchar(30) NOT NULL,
    CROOM smallint -- 2BYTE
);
SHOW TABLES;

DESC MCLASS;

INSERT INTO MCLASS(CNUM, CNAME,CROOM)
VALUES(NULL,'빅데이터SW반',201);

SELECT * FROM MCLASS;

SELECT @@auto_increment_increment;

INSERT INTO MCLASS(CNAME,CROOM)
VALUES('AI서비스반',202);

INSERT INTO MCLASS(CNAME,CROOM)
VALUES('풀스택반',203);

select * from MCLASS;

COMMIT;
-- rollback;
-- ORACLE : 수동 커밋
-- MYSQL : 자동 커밋

SELECT * FROM MCLASS;

select @@autocommit;

-- 학생 테이블(학급 테이블의 학급번호를 외래키로 참조한다)

create table STUDENT(
	NUM INT auto_increment primary KEY,
    NAME VARCHAR(30) NOT NULL,
    TEL VARCHAR(15) NOT NULL,
    ADDR VARCHAR(100),
    CNUM_FK INT,
    -- 외래키 제약 조건
    foreign key (CNUM_FK) references MCLASS (CNUM)
);
SHOW TABLES;

DESC STUDENT;

-- 홍길동 부산시 1번학급
INSERT INTO STUDENT(NAME, TEL, ADDR)
VALUES('홍길동', '010-1111', '부산시');

SELECT * FROM STUDENT;

INSERT INTO STUDENT(NAME, TEL, ADDR, CNUM_FK)
VALUES('김길동', '010-1111', '부산시',1);

INSERT INTO STUDENT(NAME, TEL, ADDR, CNUM_FK)
VALUES('홍길동', '010-1111', '부산시',2);

INSERT INTO STUDENT(NAME, TEL, ADDR, CNUM_FK)
VALUES('이수진', '010-3211', '서울시',3);

INSERT INTO STUDENT(NAME, TEL, ADDR, CNUM_FK)
VALUES('김수진', '010-3211', '서울시',1);

-- 2개의 테이블로 정규화
-- JOIN 문을 이용해서 하나로 합칠 수 있다.

-- SELECT 컬럼명1, 컬럼명2, ... FROM 테이블1
-- JOIN
-- 테이블2
-- ON 테이블1PK =테이블2FK;

select CNUM, CNAME, NAME, TEL, ADDR, CNUM_FK, CROOM
from MCLASS JOIN STUDENT
on MCLASS.CNUM = STUDENT.CNUM_FK AND MCLASS.CNUM=2;

SELECT * FROM STUDENT;
SELECT * FROM MCLASS;

-- MCLASS의 2번 학급의 명칭을 'AI웹서비스반'으로 수정하세요
UPDATE MCLASS SET CNAME='AI서비스반' WHERE CNUM=2;


select * from dept;

select * from emp;

-- 사번, 사원명, 급여, 입사일
select empno, ename, sal, hiredate
from emp;

-- 산술표현식
select ename, sal, sal+300 from emp;

select empno, ename, sal, comm, sal+comm from emp;


-- null 값이 연산에 사용될 경우 결과는 null로 나온다.
-- null 값을 0으로 치환하여 변환하는 함수 ifnull()을 이용해야 한다.
select empno, ename, sal, comm, sal+comm, sal+ifnull(comm,0) as "1년 월급" from emp;


select * from salgrade;

select * from member;
select * from category;
select * from products;
select * from supply_comp;




