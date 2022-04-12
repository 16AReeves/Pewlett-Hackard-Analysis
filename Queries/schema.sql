-- Delete tables, if they exist

DROP TABLE departments IF EXISTS;
DROP TABLE employees IF EXISTS;
DROP TABLE dept_manager IF EXISTS;
DROP TABLE salaries IF EXISTS;
DROP TABLE dept_employees IF EXISTS;
DROP TABLE titles IF EXISTS;


-- Creating tables for PH-EmployeeDB

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

CREATE TABLE dept_employees (
     emp_no INT NOT NULL,
     dept_no VARCHAR(4) NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
     FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
     PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
      emp_no INT NOT NULL,
      title VARCHAR NOT NULL,
      from_date DATE NOT NULL,
      to_date DATE NOT NULL,
      FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
      PRIMARY KEY (emp_no)
);

-- View all of the charts/data
-- NOTE: Use SELECT count(*) FROM (table_name): to count all rows, after import

SELECT * FROM departments;
SELECT * FROM dept_employees;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

