-- day11_함수와트리거.sql
-- stored function
-- 프로시저와 비슷하지만 차이점은 함수의 경우 return 값을 반환해야 한다
-- 함수의 매개변수는 모두 in 파라미터다. in 을 붙이지 않는다.
-- 프로시저는 호출시 call을 이용하지만, 함수는 select문안에서 호출된다. 

-- 2개의 정수를 매개변수로 받아서 두 정수의 합을 반환하는 함수 

delimiter //
create function plus(X int, Y int)
returns int
begin
	return X+Y;
end //
delimiter ;

-- 함수 호출
select plus(10,20);

/*
Error Code: 1418. This function has none of DETERMINISTIC,
 NO SQL, or READS SQL DATA in its declaration and binary 
 logging is enabled (you *might* want to use the less safe 
 log_bin_trust_function_creators variable)

*/
set global log_bin_trust_function_creators=1; -- [함수 권한 생성]
-- 저장함수를 사용하기 위해서는 함수 생성 권한을 허용해주어야 한다.

-- [문제1] 인파라미터로 사원명을 전달하면 해당 사원의 사번을 반환해주는
--       스토어드 함수를 작성하시오.
delimiter //
create function get_no(pname varchar(10))
returns int
begin
	declare VENO int;
    select empno
    into veno
    from emp where ename=pname;
    return veno;
end //
delimiter ;

select get_no('james');

-- [문제2] member테이블에서 회원이 가입한 년도(REG_DATE)이후 현재 시점까지 몇년이 되었는지
-- 	계산해서 반환해주는 함수를 작성하시오.

delimiter //
create function calcYear(pnum int)
returns int
begin
	declare yy1 int; -- 가입년도 
    declare gap_year int; -- ( 현재년도 - 가입년도 )
    
    select year(reg_date)
    into yy1
    from member where num=pnum;
    set gap_year = (year(curdate()) - yy1);
    return gap_year;
end //
delimiter ;

select calcYear(4);
select name,reg_date from member where num=4;

-- trigger
-- insert/update/delete 등 dms 문장이 수행될 때 자동으로 수행되는 일종의 프로시저이다.
-- emp2에서 사원정보를 삭제하면 삭제된 사원정보가 retired_emp 테이블에 저장되도록 
-- 트리거를 구현해보자. 

create table retired_emp
as select * from emp2 where 1=2;

select * from retired_emp;

drop trigger if exists emp_del_trg;

delimiter // -- [delete문]
create trigger emp_del_trg 
	after delete on emp2
    for each row
begin
	-- 트리거에서 사용하는 임시 테이블: old, new
    insert into retired_emp
    values(old.empno, old.ename, old.job, old.mgr, old.hiredate,
    old.sal, old.comm, old.deptno);
end //
delimiter ;

-- emp2의 레코드를 삭제하면 자동으로 trigger가 수행된다.

select * from emp2;
select * from retired_emp;

delete from emp2 where empno=7499;

-- insert 문: 새로 들어온 데이터 ==> new에 보관한다. "new.컬럼명"
-- delete 문: 기존에 삭제된 데이터 ==> old에 보관함 "old.컬럼명"
-- update 문: 수정된 새로운 데이터 ==> new에 보관
-- 			 수정되기 전의 데이터 ==> old에 보관

create table emp_log
as select empno, ename, job, deptno from emp2
where 1=0;
select * from emp_log;

-- emp_log 테이블에 컬럼 추가하기 
-- modtype : i, d, u char(1)
-- moddate : 데이터 수정일 date
-- moduser : 변경할 사용자 varchar(30)

alter table emp_log add modtype char(1);
alter table emp_log add moddate date;
alter table emp_log add moduser varchar(30);
desc emp_log;

-- emp2를 수정할 때 발생되는 트리거를 작성하되 
-- 수정된 사원의 사번, 이름, 업무, 부서번호, 'u', 현재날짜, current_user()
-- emp_log에 insert하는 트리거를 작성하세요.
delimiter //  -- [update문]
create trigger emp_log_trg 
after update on emp2 for each row
begin
	insert into emp_log
    values(old.empno, old.ename, old.job, old.deptno, 'u', curdate(), current_user());
end //
delimiter ;

delimiter // -- [insert문]
create trigger emp_log_trg2 
after insert on emp2 for each row
begin
	insert into emp_log
    values(new.empno, new.ename, new.job, new.deptno, 'i', curdate(), current_user());
end //
delimiter ;

DROP TRIGGER emp_log_trg2;

select * from emp2;
-- update emp2 set --
update emp2 set deptno=20 where empno=7521;

desc emp_log;
select * from emp_log;

insert into emp2(empno, ename, job, deptno)
values(9004, 'queen2', 'manager',20);

select * from emp2;
select * from emp_log;
DELETE FROM EMP_LOG;

show tables;
desc demo;





