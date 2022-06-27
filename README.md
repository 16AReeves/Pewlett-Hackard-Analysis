# Pewlett-Hackard-Analysis
---
## Module 7: Performing analysis on PH employee data to determine what employees could be retiring using PostGres SQL
---
### Data analysis on current employees born between 1952 and 1955
---
#### Background
---
##### Pewlett-Hackard is looking toward the future and trying to determine who will be retiring soon. Bobby, an HR analyst, needed help to answer a few questions. This analysis covers how many will be retiring by department, how many positions will need to be filled, and how many employees in the departments can help train the on-boarding staff. This analysis will help HR and the company prepare for the "silver tsunami" as the older generation begins to retire. The employees with birth years between 1952 and 1955 were used in this analysis for potential retirees, and mentoring employees were screened with the birth year of 1965. 
---
#### Results

---
* ##### The below table is the number of employees retiring by department:
![retirement_count](https://user-images.githubusercontent.com/98365963/163651723-d91e2214-d4d0-45a4-9d1c-f05d167c0f64.PNG)
##### The above table was determined using the following code; which joins csv files in SQL to determine who currently works at the company, what department the retirees are in, and counting each employee by department.
```
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


-- Export the new data, employees elibible to retire by department, into a table:
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_count
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
```
---
* ##### The below table is the number of employees retiring by title:
![retiring_titles](https://user-images.githubusercontent.com/98365963/163650637-1a59b185-5726-48af-acd7-2b128cf4dca5.PNG)
##### The above table was determined using the following code; which takes all of the retiring employees from 1952-1955, after making sure all employees are currently at the company, and counting them by title.
```
-- Use DISTINCT ON to remove duplicate rows

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_title as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;


-- Retrieve number of employees retiring based on title

SELECT COUNT(ut.title) as "Title Count", ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY "Title Count" DESC;
```
---
* ##### 30.2% of employees will be retiring soon at PH. This was found using the following code:
```
--number of employees retiring: 72,458

-- Find number of current employees

SELECT COUNT(DISTINCT e.emp_no)
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (to_date = '9999-01-01')

-- current employees: 240,124

-- Percentage of employees retiring: 30.2%
```
---
* ##### The below table is the number of employees who're eligible to mentor the on-boarding staff:
![mentor_lists](https://user-images.githubusercontent.com/98365963/163650693-4a72225a-aa70-4e7e-91d8-06def4c24260.PNG)
##### The above table was created using the following code; which generates a list of employees by department that were born in 1965 and who're still with the company.
```
-- Query to create a Mentorship Eligibility table

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
```
---
#### Summary
---
##### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
* ##### The following queries were coded to answer this question:
```
-- Count the number of retiring employees by title and by year:
SELECT e.emp_no,
	e.birth_date,
	ut.title
INTO employee_titles
FROM employees as e
INNER JOIN unique_titles as ut
ON (e.emp_no = ut.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
GROUP BY ut.title, e.emp_no
ORDER BY e.emp_no DESC;

-- 1952
SELECT COUNT(et.title) AS "Title_Count", et.title
INTO firstround_retirees
FROM employee_titles as et
WHERE (et.birth_date BETWEEN '1952-01-01' AND '1952-12-31')
GROUP BY et.title
ORDER BY "Title_Count" DESC;

--1953
SELECT COUNT(et.title) AS "Title_Count", et.title
INTO secondround_retirees
FROM employee_titles as et
WHERE (et.birth_date BETWEEN '1953-01-01' AND '1953-12-31')
GROUP BY et.title
ORDER BY "Title_Count" DESC;

--1954
SELECT COUNT(et.title) AS "Title_Count", et.title
INTO thirdround_retirees
FROM employee_titles as et
WHERE (et.birth_date BETWEEN '1954-01-01' AND '1954-12-31')
GROUP BY et.title
ORDER BY "Title_Count" DESC;

--1955
SELECT COUNT(et.title) AS "Title_Count", et.title
INTO fourthround_retirees
FROM employee_titles as et
WHERE (et.birth_date BETWEEN '1955-01-01' AND '1955-12-31')
GROUP BY et.title
ORDER BY "Title_Count" DESC;
```
##### The output from these queries are as follows: 
1952 Retirees | 1953 Retirees | 1954 Retirees | 1955 Retirees
---|---|---|---|
![1952_retirees](https://user-images.githubusercontent.com/98365963/163652083-7f76084e-5767-4a0e-8c01-3fca3987f59d.PNG) | ![1953_retirees](https://user-images.githubusercontent.com/98365963/163652086-486e11d0-165d-4c11-b88a-3d01e88ca987.PNG) | ![1954_retirees](https://user-images.githubusercontent.com/98365963/163652092-fb7a52f0-9b2a-4b39-a1c9-e97388f17eeb.PNG) | ![1955_retirees](https://user-images.githubusercontent.com/98365963/163652097-eec32be0-d04d-4925-b0fe-c4de91789c8d.PNG)
##### From 1952-1955, 72,458 employees will need to be replaced. The first round of retirees, the employees born in 1952, 16,981 will need to be replaced. The second round of retirees, the employees born in 1953, 18,328 will need to be replaced. The third round of retirees, the employees born in 1954, 18,612 will need to be replaced. The fourth round of retirees, the employees born in 1955, 18,537 will need to be replaced. Ideally, if all employees retired in the same order as when they were born, less than 19,000 people will need to be replaced yearly. 
--- 
##### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of PH employees?
* ##### The following query was coded to answer this question:
```
-- Count how many can Mentor from each department:

SELECT COUNT(me.title) AS "Title Count", me.title
INTO mentor_list
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY "Title Count" DESC;
```
##### The output from the above query is as follows:
![mentor_lists](https://user-images.githubusercontent.com/98365963/163652553-279d6ad2-8b77-4364-8401-d626405995c8.PNG)
##### Looking at all of the data along with the above chart, no managers meet the requirements to mentor. The other six titles have very few people in them to train and, which meet the requirement of seniority, to on-board all of the necessary personnel. No, there doesn't seem to be enough senior personnel to train new employees.
