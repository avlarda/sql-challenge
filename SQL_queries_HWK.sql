---paso 1 Data Modeling: see png
---paso 2 Data Engineering:
CREATE TABLE department (
  dept_no character varying(50),
  dept_name character varying(50)
);

CREATE TABLE employees (
  emp_no int,
  birth_date date,
	first_name character varying(50),
	last_name character varying(50),
	gender character varying(50),
	hire_date date
);

CREATE TABLE dept_manager (
  dept_no character varying(50),
  emp_no int,
	from_date date,
	to_date date
);

CREATE TABLE titles (
  emp_no int,
  title character varying(50),
	from_date date,
	to_date date
);

CREATE TABLE salaries (
  emp_no int,
  salary int,
	from_date date,
	to_date date
);

CREATE TABLE dept_emp (
  emp_no int,
  dept_no character varying(50),
	from_date date,
	to_date date
);

---paso 2 Data Engineering: añadir informacion a la tabla (import)

---paso 3 Data Analysis 

select * from salaries as b
--1. details of each employee: employee number, last name, first name, gender, and salary
Select
a.emp_no as employee_number,
a.last_name,
a.first_name,
a.gender,
b.salary

from employees as a
left join salaries as b
  on a.emp_no=b.emp_no
;


--2. employees hired in 1986
Select
a.emp_no as employee_number,
a.last_name,
a.first_name,
a.gender,
a.hire_date
from employees as a
where (extract(year from hire_date)=1986)

--3. manager of dpt: department number, department name, the manager's employee number, 
--   last name, first name, and start and end employment dates
Select 
a.dept_no,
b.dept_name,
a.emp_no,
c.first_name,
c.last_name,
d.from_date,
d.to_date

from dept_manager a
left join department b
  on a.dept_no=b.dept_no
left join employees c
  on a.emp_no=c.emp_no
left join dept_emp d
  on a.emp_no=d.emp_no
  and a.dept_no=d.dept_no;


--4. dpt for each employee:employee number, last name, first name, and department name
select
a.emp_no,
b.first_name,
b.last_name,
c.dept_name

from dept_emp a
left join employees as b
on a.emp_no=b.emp_no
left join department as c
on a.dept_no=c.dept_no;

--5.List all employees whose first name is "Hercules" and last names begin with "B."
select
a.emp_no,
a.first_name,
a.last_name

from employees a
where a.first_name in ('Hercules')
and a.last_name like 'B%';

--6.List all employees in the Sales department, including their employee number,
--  last name, first name, and department name.
--how is sales dept named
Select distinct dept_name from department
--'Sales' 'Development'

Select 
a.emp_no,
b.last_name,
b.first_name,
c.dept_name

from dept_emp a
left join employees b
on a.emp_no=b.emp_no
left join department c
on a.dept_no=c.dept_no

Where dept_name = 'Sales';

--7. List all employees in the Sales and Development departments,
--   including their employee number,last name, first name, and department name.
--'Sales' 'Development'
Select 
a.emp_no,
b.last_name,
b.first_name,
c.dept_name

from dept_emp a
left join employees b
on a.emp_no=b.emp_no
left join department c
on a.dept_no=c.dept_no

Where dept_name in('Sales','Development');

--8. In descending order, list the frequency count of employee last names, 
--   i.e., how many employees share each last name.

Select 
a.last_name,
count(a.last_name)
from employees a
group by 1
order by count(a.last_name) DESC;
