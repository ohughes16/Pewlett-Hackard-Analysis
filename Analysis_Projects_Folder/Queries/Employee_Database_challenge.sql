
-- Module 7 Deliverable 1 Number of Retiring Employees by Title

SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO ret_info_by_title
FROM employees as e
    LEFT JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Distinct retiring employees by title
SELECT DISTINCT ON (ribt.emp_no) ribt.emp_no,
    ribt.first_name,
    ribt.last_name,
    ribt.title,
    ribt.from_date,
    ribt.to_date
INTO unique_titles
FROM ret_info_by_title as ribt
ORDER BY ribt.emp_no, ribt.to_date DESC;

SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

--DELIVERABLE 2 Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999/1/1')
ORDER BY e.emp_no, de.to_date ASC;