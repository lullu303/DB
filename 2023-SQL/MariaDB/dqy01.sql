
USE sqldb;

CREATE TABLE sample01 (
	no INTEGER NOT NULL,
	a VARCHAR(30),
	b DATE;

DESC sample01;

INSERT INTO sample01(a)
values('eee');


INSERT INTO sample01(a,b)
SELECT a, b
FROM sample02

SELECT * FROM sample01;

SELECT LAST_INSERT_ID() -- OUTO INCREMENT의 수가 무엇이냐?

DELETE FROM SAMPLE01;

TRUNCATE TABLE sample01; -- 깨끗하게 비워줌


UPDATE sample01
SET a = 'bbb'
WHERE no = 1;

UPDATE sample01
SET a = 'ccc'
WHERE no = 2;

UPDATE sample01
-- SET b = CURRENT_DATE()
SET b = (SELECT b FROM sample01 WHERE no = 2)
WHERE no = 1

SELECT * FROM sample01;
