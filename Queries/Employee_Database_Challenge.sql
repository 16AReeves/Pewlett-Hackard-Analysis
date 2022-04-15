-- Deliverable 1:

-- Drop table, if needed
DROP TABLE retirement_title;
DROP TABLE unique_titles;
DROP TABLE retiring_titles;


-- Create table of retiring employees by title
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_title
FROM employees as e, titles as ti
WHERE (e.emp_no = ti.emp_no)
AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, ti.emp_no DESC;


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



--Deliverable 2:

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


--Deliverable 3:

-- Count how many can Mentor from each department:

SELECT COUNT(me.title) AS "Title Count", me.title
INTO mentor_list
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY "Title Count" DESC;


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