use sqldb;
-- join
select * from usertbl, buytbl
order by name;

select * 
from usertbl U, buytbl B
where u.userid = b.userid
order by u.userid;

from usertbl, buytbl
where usertbl.userid = buytbl.userid

-- self join [1]
select a.emp as '부하직원', 
b.emp as '직속상관', b.empTel as '직속상관 연락처'
from emptbl a inner join emptbl b on a.manager = b.emp;

-- self join [2]
select a.emp as '부하직원', 
b.emp as '직속상관', b.empTel as '직속상관 연락처'
from emptbl a, emptbl b
where a.manager = b.emp


