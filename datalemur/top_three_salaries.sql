-- https://datalemur.com/questions/sql-top-three-salaries

-- As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying high earners in each department. A 'high earner' within a department is defined as an employee with a salary ranking among the top three salaries within that department.

-- You're tasked with identifying these high earners across all departments. Write a query to display the employee's name along with their department name and salary. In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. If multiple employees have the same salary, then order them alphabetically.

-- Note: Ensure to utilize the appropriate ranking window function to handle duplicate salaries effectively.


-- employee Schema:

-- employee_id     integer
-- name            string
-- salary          integer
-- department_id	integer
-- manager_id      integer


-- department Schema:

-- department_id   integer
-- department_name	string


WITH ft AS (
  SELECT 
    e.name
    , e.salary
    , e.department_id
    , d.department_name
    , DENSE_RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) as rank
  FROM employee e
    LEFT JOIN department d
    ON e.department_id = d.department_id
)

SELECT 
    department_name
    , name
    , salary
FROM ft
WHERE rank <= 3
ORDER BY 
    department_name ASC
    , salary DESC
    , name ASC;