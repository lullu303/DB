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

select nullif(100,100), nullif(200,100)

select
	case 10
		when 1 then '일'
		when 5 then '오'
		when 10 then '십'
		else '글쎄요'
	end
	
	
select * from usertbl

select 
	case height
		when 182 then '180보다 크다'
		when 170 then '170이다'
		else height
	end
from usertbl

select 
	case sal
		when 1000 then sal * 12 + comm
		when 500 then sal * 12
		else sal
	end as annualSal
from saltbl