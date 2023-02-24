use employees

select count(*) from salaries;

select * from salaries
limit 100;

desc dept_emp;

select distinct dept_no from dept_emp;

select *
from dept_manager
order by emp_no, emp_nodepartments


