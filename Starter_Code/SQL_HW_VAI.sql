CREATE TABLE departments(
	dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY(dept_no)
);

CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(30) NOT NULL,
	emp_no INTEGER NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	empt_title VARCHAR(30) NOT NULL,
	birth_date DATE,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(30),
	hire_date  DATE,
	PRIMARY KEY (emp_no)
);

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles(
	title_id VARCHAR(30) NOT NULL,
	title VARCHAR(30) NOT NULL,
	PRIMARY KEY(title_id)
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--Creating the first list for the assignment
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e, salaries s 
WHERE e.emp_no = s.emp_no;

--Second list for assignment
SELECT first_name, last_name, hire_date
FROM employees
WHERE to_char(hire_date,'YYYY-MM-DD') LIKE '1986%';

--Third list
CREATE VIEW managers AS
SELECT dept_manager.dept_no,
	departments.dept_name, 
	dept_manager.emp_no
FROM departments, dept_manager
WHERE departments.dept_no = dept_manager.dept_no;

SELECT * FROM managers;

SELECT managers.dept_no, 
	managers.dept_name, 
	managers.emp_no,
	employees.last_name, 
	employees.first_name
FROM employees, managers
WHERE managers.emp_no = employees.emp_no;

--4th list
CREATE VIEW emp_dep AS
SELECT dept_emp.dept_no,
	departments.dept_name, 
	dept_emp.emp_no
FROM departments, dept_emp
WHERE departments.dept_no = dept_emp.dept_no;

SELECT * FROM emp_dep;

SELECT emp_dep.dept_no,
	emp_dep.emp_no,
	employees.last_name,
	employees.first_name,
	emp_dep.dept_name
FROM emp_dep, employees
WHERE emp_dep.emp_no = employees.emp_no;

--5th list
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

--6th list
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no = 'd007'
);

--7th list
CREATE VIEW only_dev_and_sales AS
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no = 'd007' OR dept_no = 'd005'
);
SELECT * FROM only_dev_and_sales;
SELECT * FROM emp_dep;

SELECT o.emp_no, o.last_name, o.first_name, e.dept_name
FROM emp_dep e, only_dev_and_sales o
WHERE o.emp_no = e.emp_no 
AND (e.dept_name = 'Development' or e.dept_name = 'Sales')

--8th list
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;