USE sqldb;

desc sample01;

select * from sample01;

insert into sample01(no, a, b)
values(last_insert_id()+1,'fff', current_date())

select last_insert_id() + 1

insert into sample01(a)
values('fff')

select last_insert_id()

ALTER TABLE sqldb MODIFY(d DATE DEFAULT SYSDATE);