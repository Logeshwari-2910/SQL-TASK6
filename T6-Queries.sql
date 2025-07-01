use companydb;
-- 1. Scalar Subquery in SELECT
-- Show each employee's salary and the average company salary
SELECT emp_id, first_name, salary,
  (SELECT AVG(salary) FROM employee) AS avg_salary
FROM employee;

-- 2. Correlated Subquery in WHERE
-- Find employees earning more than the average of their branch
SELECT emp_id, first_name, salary, branch_id
FROM employee e
WHERE salary > (
  SELECT AVG(salary)
  FROM employee
  WHERE branch_id = e.branch_id
);

-- 3. Subquery using IN
-- List employees who work in the same branches as clients
SELECT emp_id, first_name, branch_id
FROM employee
WHERE branch_id IN (
  SELECT DISTINCT branch_id FROM client
);

-- 4. Subquery using EXISTS
-- List employees who have worked with at least one client
SELECT emp_id, first_name
FROM employee e
WHERE EXISTS (
  SELECT 1 FROM works_with w
  WHERE w.emp_id = e.emp_id
);

-- 5. Subquery in FROM clause
-- Show average salary by branch using a subquery in FROM
SELECT branch_id, avg_salary
FROM (
  SELECT branch_id, AVG(salary) AS avg_salary
  FROM employee
  GROUP BY branch_id
) AS branch_avg;

--  6. Using = with Scalar Subquery
-- Find employees with the highest salary in the company
SELECT emp_id, first_name, salary
FROM employee
WHERE salary = (
  SELECT MAX(salary) FROM employee
);

-- 7. Using > ALL
-- Find employees whose salary is greater than all employees in branch 2
SELECT emp_id, first_name, salary
FROM employee
WHERE salary > ALL (
  SELECT salary FROM employee WHERE branch_id = 2
);

-- 8. Using > ANY
-- Find employees whose salary is greater than any employee in branch 3
SELECT emp_id, first_name, salary
FROM employee
WHERE salary > ANY (
  SELECT salary FROM employee WHERE branch_id = 3
);
