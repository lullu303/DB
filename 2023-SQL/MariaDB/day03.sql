select if(100>200, '참', '거짓')

select ifnull(null, '널!'), ifnull(100, '널')

select * from saltbl

select ifnull(comm,0)
from saltbl

-- null은 계산이 안되기 때문에, 0으로 바꾸면 계산가능.
select sal*12+ifnull(comm,0)
from saltbl

select no, sal *12+ifnull(comm,0) as annualSal
from saltbl

