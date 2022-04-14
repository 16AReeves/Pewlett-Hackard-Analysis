-- Drop table, if needed
DROP TABLE retirement_title;

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

