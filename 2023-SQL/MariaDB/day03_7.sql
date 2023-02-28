use sqldb

-- ansi join DBMS 공통 표준 문법
-- left outer join
select u.userid, u.name, b.prodName,u.addr, concat(u.mobile1, u.mobile2) as mobile
from usertbl u LEFT OUTER JOIN buytbl b ON u.userid = b.userid
order by u.userid;

-- inner outer join
select u.userid, u.name, b.prodName,u.addr, concat(u.mobile1, u.mobile2) as mobile
from usertbl u INNER JOIN buytbl b ON u.userid = b.userid
order by u.userid;

-- right outer join
select u.userid, u.name, b.prodName,u.addr, concat(u.mobile1, u.mobile2) as mobile
from usertbl u RIGHT OUTER JOIN buytbl b ON u.userid = b.userid
order by u.userid;

-- 서브쿼리
select name, height
from usertbl
where height > (select height from usertbl where name = '김경호')

-- 다중행 서브쿼리 in any/some, all
-- [1]
select name, height
from usertbl
where height in (select height from usertbl where addr = '경남')

-- [2]
select name, height
from usertbl
where height >= any (select height from usertbl where addr = '경남');

-- [3]
select name, height
from usertbl
where height >= all (select height from usertbl where addr = '경남');

-- 인라인뷰
select *
from (select * from usertbl where addr = '서울') us,
(select * from buytbl) b
where us.userid = b.userid;

with abc(userid, total)
as
	(
		select userid, sum(price*amount) as total
		from buytbl
		group by userid
	)
select * from abc order by total desc;

-- 스칼라 서브쿼리
use employees

select e.emp_no, e.first_name, e.last_name, AVG(salary) AS salary,
	(select round(AVG(salary), -1) FROM salaries) AS avg_salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no AND e.emp_no=10001;	