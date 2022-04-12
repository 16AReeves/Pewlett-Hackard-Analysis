-- Query to find employees born between 1952-1955 (7.3.1):
SELECT first_name, last_name
FROM employees
WHERE birth_date 
BETWEEN '1952-01-01' 
AND '1955-12-31';

-- Query to find employees born just in 1952:
SELECT first_name, last_name
FROM employees
WHERE birth_date 
BETWEEN '1952-01-01' 
AND '1952-12-31';

-- -- Query to find employees born just in 1953:
SELECT first_name, last_name
FROM employees
WHERE birth_date 
BETWEEN '1953-01-01' 
AND '1953-12-31';

-- Query to find employees born just in 1954:
SELECT first_name, last_name
FROM employees
WHERE birth_date 
BETWEEN '1954-01-01' 
AND '1954-12-31';

-- Query to find employees born just in 1955:
SELECT first_name, last_name
FROM employees
WHERE birth_date 
BETWEEN '1955-01-01' 
AND '1955-12-31';

-- Retirement eligibility (1952-1955 and hired 1985-1988):
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Export eligible employees for retirement into a new table:
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- View new exportable table (7.3.1):
SELECT * FROM retirement_info;




