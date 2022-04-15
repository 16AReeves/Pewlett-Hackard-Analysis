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


-- Drop retirement_info table, to recreate it and add in emp_no column (7.3.2):
DROP TABLE retirement_info;


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Take the above inner join code and turn it into an alias for easier understanding:
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_employees tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
    retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;


-- Use alias coding to shorten names, making the code easier to read (7.3.3):
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no;


-- Use a left join on retirement_info and dept_emp to find the current employees of the company:
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- Export the new data, employees elibible to retire by department, into a table and export (7.3.4 Skill Drill):
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_count
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- Take a look at the salaries table:
SELECT * FROM salaries;


-- Reorder the salaries table to look for recent data:
SELECT * FROM salaries
ORDER BY to_date DESC;


-- Create new table to show Employee Information (7.3.5):
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    s.salary,
    de.to_date
-- INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);


-- Each department retirees
SELECT ce.emp_no,
    ce.first_name,
    ce.last_name,
    d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


-- Create table to query all employees leaving the sales team
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
INTO retirement_sales
FROM retirement_info AS ri
INNER JOIN dept_info AS di
ON (ri.emp_no = di.emp_no)
WHERE di.dept_name = 'Sales';

-- DROP TABLE IF INCORRECT:
DROP TABLE retirement_sales CASCADE;



-- Create query for retirees in Sales and Development Teams:
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
INTO retirement_SalesDevelopment
FROM retirement_info AS ri
INNER JOIN dept_info AS di
ON (ri.emp_no = di.emp_no)
WHERE di.dept_name IN ('Sales', 'Development');


--number of employees retiring: 72,458

-- Find number of current employees
SELECT COUNT(DISTINCT e.emp_no)
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (to_date = '9999-01-01')
-- current employees: 240,124
-- Percentage of employees retiring: 30.2%