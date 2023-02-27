select char_length('ABC'), length('abc')
select char_length('가나다'), length('가나다') -- 3, 9(byte)

select concat('abc','ABC'), concat_ws('/','2023','02','27')

select * from usertbl

select concat(userID, name), concat_ws('-',userID, name, addr)
from usertbl