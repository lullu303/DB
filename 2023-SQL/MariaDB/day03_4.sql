-- 수학함수

select abs(-100) -- 절대값

select ceiling(4.7),floor(4.7) , round(4.7) 
-- 올림, 내림, 반올림

select mod(157,10) , 157%10, 157 mod 10 -- 나머지

select rand() -- 0-1 사이의 실수

-- 숫자가 양수, 0, 음수인지를 구함
select sign(100), sign(0), sign(-100.123) -- 1, 0, -1

- 숫자를 소수점기준으로 정수위치까지 구하고 나머지를 버림
select truncate(12345.12345,2), truncate(12345.12345,-2)

use sqldb;
select * from saltbl;

select truncate(sal,2), truncate(sal,-2)
from saltbl