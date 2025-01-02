--https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1
--
--Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.
--
--
-- Table: worker
--
--worker_id:    int
--first_name:   varchar
--last_name:    varchar
--salary:       int
--joining_date: datetime
--department:   varchar
--
--
-- Table: title
--
--worker_ref_id:    int
--worker_title:     varchar
--affected_from:    datetime


SELECT t.worker_title
FROM
    worker h
    LEFT JOIN title t ON h.worker_id = t.worker_ref_id
WHERE h.salary IN (SELECT MAX(salary) FROM worker)