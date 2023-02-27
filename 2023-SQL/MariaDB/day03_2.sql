select INSERT('abcdefghi',3,3,'@@@@')

select LEFT('abcdefghi',3), RIGHT('abcdefghi',3)

select LOWER('abcdEFGHI'), UPPER('abcdEFGHI')

select lpad('연초코',5,'&&'), rpad('연초코',5,'##')

select ltrim('      연초코  '),rtrim('  연초코           ')

select trim('연초코'),trim(both'ㅋ'from'ㅋㅋㅋ사랑합니다 ㅋㅋㅋ')
-- both : 양 옆
select trim('연초코'),trim(leading'ㅋ'from'ㅋㅋㅋ사랑합니다 ㅋㅋㅋ')
-- leading : 앞
select trim('연초코'),trim(trailing'ㅋ'from'ㅋㅋㅋ사랑합니다 ㅋㅋㅋ')
-- trailing : 뒤