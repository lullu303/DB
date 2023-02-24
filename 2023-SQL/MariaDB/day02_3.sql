select userid, name, addr
from usertbl
where addr not in('경남' , '전북')
-- where addr = '경남' or addr = '전북'

select userid, name, height
from usertbl
-- where height between 180 and 186;
where height >+ 180 and height <= 186

select * from usertbl where name like '윤%';
select * from usertbl where name like '_비%';

use employees
select * from employees where first_name like '%AM%';

select * from employees where last_name not like '%AM%';

use sqldb;
-- select * from buytbl where groupname = null;
select * from buytbl where groupname is null;
select * from buytbl where groupname is not null;

use employees
select * from employees
limit 100;

select * from employees
limit 0,5;

select * from employees
limit 5,10;
