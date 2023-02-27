select repeat('연초코',3);

select replace('연초코는 5살입니다','5살','6살');
select replace('연초코는 5살입니다','5','6');

use sqldb;
select * from usertbl;

select replace(name, '비','*')
from usertbl; -- 바*킴

select insert(name, 2, 1, '*')
from usertbl; -- 2번째에 1개를 *로 바꿔줘

select concat('Trust',space(10),'your power')
-- 중간에 공백으로 연결(concat)

select substring('Trust your power',3,2)
-- substring(문자열, 시작위치, 길이)

select substring_index('www.naver.com','.',2), substring_index('www.naver.com','.',-2)
--www.naver / naver.com