select char_length('ABC'), length('abc')
select char_length('가나다'), length('가나다') -- 3, 9(byte)

select concat('abc','ABC'), concat_ws('/','2023','02','27')

select * from usertbl

select concat(userID, name), concat_ws('-',userID, name, addr)
from usertbl

select format(123456.7890,4)

select elt(2,'하나','둘','셋'), -- 둘
		field('둘','하나','둘','셋'), -- 2 , 위치 리턴
		find_in_set('둘','하나,둘,셋'), -- 2
		instr('하나둘셋','둘'), -- 3번째에 있다(문자열이기때문)
		locate('둘','하나둘셋') -- 3 