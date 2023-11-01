--Student Name: Bui Hai Duong 20214953

--Basic SELECT Statements
--1
SELECT first_name AS "First Name",
	 last_name AS "Last Name",
FROM employees;

--2
SELECT DISTINCT department_id
FROM employees;

--3
SELECT * 
FROM employees 
WHERE hire_date BETWEEN '2022-01-01' AND '2022-12-31';

--4
SELECT first_name, last_name, salary, salary*0.15 AS PF 
FROM employees;

--5
SELECT first_name, last_name, salary, salary*0.15 AS PF 
FROM employees 
WHERE salary*0.15 > 10000;

--6
SELECT e.*, d.* 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id;

--7
SELECT 171*214+625;

--8
SELECT SUM(salary)
FROM employees;

--9
SELECT MAX(salary), MIN(salary) 
FROM employees;

--10
SELECT AVG(salary), COUNT(*) 
FROM employees;

--11
SELECT COUNT(*) FROM employees;

--12
SELECT COUNT(DISTINCT job_id) 
FROM employees;

--13
SELECT first_name || ' ' || last_name AS name 
FROM employees;

--14
SELECT TRIM(first_name) 
FROM employees;

--15
SELECT * 
FROM table 
LIMIT 10;

--16
SELECT ROUND(salary/12, 2) AS monthly_salary
FROM employees;

--17
SELECT ROUND(salary/12, 2) AS monthly_salary 
FROM employees 
WHERE salary/12 < 5000;

--Joins

--1
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name 
FROM locations l 
JOIN countries c ON l.country_id = c.country_id;

--2
SELECT e.first_name, e.last_name, e.department_id, d.department_name 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id;

--3
SELECT e.first_name, e.last_name, e.job_id, e.department_id, d.department_name 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
WHERE l.city = 'London';

--4
SELECT e.employee_id, e.last_name, 
       m.employee_id AS manager_id, 
       m.last_name AS manager_last_name 
FROM employees e 
JOIN employees m ON e.manager_id = m.employee_id;

--5
SELECT e.first_name, e.last_name, e.hire_date 
FROM employees e 
JOIN (SELECT hire_date FROM employees WHERE last_name = 'Jones') j ON e.hire_date > j.hire_date;

--6
SELECT jh.employee_id, j.job_title, 
	 jh.end_date - jh.start_date AS days 
FROM job_history jh 
JOIN jobs j ON jh.job_id = j.job_id 
WHERE jh.department_id = 90;

--7
SELECT d.department_id, d.department_name, m.first_name 
FROM departments d 
JOIN employees m ON d.manager_id = m.employee_id;

--8
SELECT d.department_name, m.first_name || ' ' || m.last_name AS manager_name, l.city 
FROM departments d 
JOIN employees m ON d.manager_id = m.employee_id 
JOIN locations l ON d.location_id = l.location_id;

--9
SELECT j.job_title, e.employee_id, e.first_name, e.last_name, 
	 e.salary-j.min_salary AS difference 
FROM employees e 
JOIN jobs j ON e.job_id=j.job_id;

--10
SELECT * 
FROM job_history 
WHERE employee_id IN (SELECT employee_id FROM employees WHERE salary > 10000);

--11


--Aggregate Functions and Group by

--1
SELECT COUNT(DISTINCT job_id) 
FROM employees;

--2
SELECT department_id, SUM(salary) 
FROM employees GROUP BY department_id;

--3
SELECT job_id, MIN(salary) 
FROM employees GROUP BY job_id;

--4
SELECT MAX(salary) 
FROM employees 
WHERE job_id = (SELECT job_id FROM jobs WHERE job_title = 'Programmer');

--5
SELECT AVG(salary), COUNT(*) 
FROM employees WHERE department_id = 90;

--6
SELECT MAX(salary), MIN(salary), SUM(salary), AVG(salary) 
FROM employees;

--7
SELECT MAX(salary) - MIN(salary) 
FROM employees;

--8
SELECT manager_id, MIN(salary) 
FROM employees GROUP BY manager_id;

--9
SELECT job_id, AVG(salary) 
FROM employees 
WHERE job_id != (SELECT job_id 
		     FROM jobs 
		     WHERE job_title = 'Programmer') GROUP BY job_id;

--10
SELECT job_id, MAX(salary) 
FROM employees GROUP BY job_id HAVING MAX(salary) >= 4000;

--11
SELECT department_id, AVG(salary) 
FROM employees GROUP BY department_id HAVING COUNT(*) > 10;