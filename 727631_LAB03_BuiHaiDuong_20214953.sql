--Student Name: Bui Hai Duong 20214953

--Date and Time Functions
--1
SELECT first_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1987-06-01' and '1987-07-30';

--2
SELECT first_name, last_name
FROM employees
WHERE MONTH(hire_date) = 'June';

--3
SELECT first_name
FROM employees
WHERE YEAR(hire_date) = '1987';

--4
SELECT d.department_name, m.first_name, m.last_name, m.salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
WHERE TIMESTAMPDIFF(YEAR, hire_date, NOW()) > 5;

--5
SELECT employee_id, last_name, DATEADD(month, DATEDIFF(month, 0, hire_date)+1, 0) AS first_salary_date
FROM employees

--6
SELECT first_name, hire_date, GETDATE() - hire_date AS experience
FROM employees

--7
SELECT d.department_id, YEAR(e.hire_date), COUNT(e.employee_id)
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, YEAR(e.hire_date);

--String
--1
SELECT REPLACE(phone_number, '124', '999')
FROM employees;

--2
SELECT CONCAT(email, '@example.com')
FROM employees;

--3
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS name, MONTH(hire_date)
FROM employees;

--4
SELECT employee_id, SUBSTRING(email, 1, CHAR_LENGTH(email) - 3) AS email_id
FROM employees;

--5
SELECT * 
FROM employees 
WHERE UPPER(first_name) = first_name

--6
SELECT SUBSTRING(phone_number, CHAR_LENGTH(phone_number) - 3)
FROM employees;

--7
SELECT SUBSTRING_INDEX(TRIM(street_address), ' ', -1)
FROM locations;

--8
SELECT l.street_address
FROM locations l
WHERE CHAR_LENGTH(street_address) = (
	SELECT MIN(CHAR_LENGTH(street_address))
	FROM locations
);

--9
SELECT DISTINCT SUBSTRING_INDEX(job_title, ' ', 1)
FROM jobs
WHERE CHAR_LENGTH(job_title) - CHAR_LENGTH(REPLACE(job_title, ' ', '')) >= 1;

--10
SELECT DISTINCT CHAR_LENGTH(first_name)
FROM employees
WHERE SUBSTRING(first_name, 3) LIKE '%c%';

--11
SELECT DISTINCT first_name, CHAR_LENGTH(first_name)
FROM employees
WHERE first_name LIKE 'A%'
OR first_name LIKE 'J%'
OR first_name LIKE 'M%'
ORDER BY first_name;

--12
SELECT first_name, LPAD(salary, 10, '$') AS SALARY
FROM employees;

--13
SELECT SUBSTRING(first_name, 1, 8), REPEAT('$', salary/1000) AS salary_signs
FROM employees
ORDER BY LENGTH(salary_signs) DESC;

--14
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE DAY(hire_date) = 7
OR MONTH(hire_date) = 7;