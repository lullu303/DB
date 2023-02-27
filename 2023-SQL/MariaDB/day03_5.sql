-- 날짜 및 시간함수

-- adddate(날짜,차이), subdate(날짜,차이)
select adddate('2022-01-01',interval 31 day), 
adddate(2022-01-01, interval 1 month);

select subdate('2022-01-01',interval 31 day), 
subdate(2022-01-01, interval 1 month);

-- 현재 년월일, 현재 시분초, 현재년월일시분초: now, sysdate
select curdate(), curtime(), now(), sysdate()

select current_time()

select date(now()), time(now());

select datediff('2023-01-01', now()),
timediff('23:23:59', '12:11:10');

select dayofweek(curdate()), monthname(curdate()),
dayofyear(curdate());
-- 2, february, 58

select last_day(curdate());
select last_day('2022-02-01');

select makedate(2023, 58); -- 2023-02-27

select maketime(12,11,10); -- 12:11:10

--  시스템정보함수
select * from usertbl;

select * from buytbl;

select found_rows();

select row_count(); -- insert, update 몇개 했나?

select version(); -- mariaDB의 버전