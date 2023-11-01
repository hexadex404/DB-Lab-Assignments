--Student Name: Bui Hai Duong 20214953

--Subquery
--1
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
	SELECT salary 
	FROM employees
	WHERE last_name = 'Bull'
);

--2
SELECT first_name, last_name
FROM employees
WHERE department_id = ( 
	SELECT department_id
	FROM departments
	WHERE department_IT = 'IT'
);

--3
SELECT first_name, last_name
FROM employees
WHERE manager_id IS NOT NULL AND department_id IN (
	SELECT department_id
	FROM departments d
		JOIN locations l ON d.location_id = l.location_id
		JOIN countries c ON l.location_id = c.country_id
	WHERE country_name = 'United States of America'
);

--4
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (
	SELECT manager_id
	FROM employees
);

--5
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employee
);

--6
SELECT first_name, last_name, salary 
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees	
AND department_id IN (
	SELECT department_id
	FROM departments
	WHERE department_name LIKE 'IT%'
);

--7
SELECT first_name, last_name, salary 
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees 
	WHERE last_name = 'Bell'
);

--8
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

--9
SELECT first_name, last_name, salary
FROM employees 
WHERE salary > ALL(
	SELECT AVG(salary)
	FROM employees
	GROUP BY department_id
);

--10
SELECT first_name, last_name, job_id, salary
FROM employees
WHERE salary > ALL(
	SELECT salary
	FROM employees
	WHERE job_id = 'SH_CLERK')
ORDER BY salary;

--11
SELECT b.first_name, b.last_name
FROM employees b
WHERE NOT EXISTS
        (SELECT 'X'
         FROM employees a
         WHERE a.manager_id = b.employee_id
);

--12
SELECT employee_id, first_name, last_name, salary
FROM employees b
WHERE salary > ALL(
	SELECT AVG(employees.salary)
	FROM employees a
	WHERE a.department_id = b.department_id
);

--13
SELECT *
FROM employees
WHERE employee_id % 2 = 0;

--14
SELECT DISTINCT salary
FROM employees a
WHERE 5 =(
	SELECT COUNT(DISTINCT salary)
	FROM employees b
	WHERE a.salary <= b.salary
);

--15
SELECT DISTINCT salary
FROM employees a
WHERE 4 =(
	SELECT COUNT(DISTINCT salary)
	FROM employees b
	WHERE a.salary >= b.salary
);

--16
SELECT *
FROM(
	SELECT *
	FROM employees
	ORDER BY employee_id DESC
	LIMIT 10) AS tbl
ORDER BY tbl.employee_id;

--17
SELECT *
FROM employees
WHERE department_id NOT IN(
	SELECT department_id
	FROM departments
	WHERE manager_id = 0 
);

--18
SELECT DISTINCT salary
FROM employees
ORDER BY 1 DESC
LIMIT 3;

--19
SELECT DISTINCT salary
FROM employees
ORDER BY 1 ASC
LIMIT 3;

--20
SELECT DISTINCT salary
FROM employees e1
WHERE n =(
	SELECT COUNT(DISTINCT salary)
	FROM employees e2
	WHERE e1.salary <= e2.salary
);
