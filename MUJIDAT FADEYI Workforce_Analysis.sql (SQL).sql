SELECT * FROM hr;

DESCRIBE hr;
select * from hr;
ALTER TABLE hr

CHANGE COLUMN id emp_id VARCHAR(20) NULL;
SELECT * FROM hr;
describe hr

SELECT birthdate FROM hr;
SET sql_safe_updates = 0;
UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,   '%m/%d/%Y'),  '%Y-%m-%d')
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,   '%m-%d-%Y'),  '%Y-%m-%d')
    ELSE birthdate
END;

SELECT * FROM hr

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,   '%m/%d/%Y'),  '%Y-%m-%d')
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,   '%m-%d-%Y'),  '%Y-%m-%d')
    ELSE birthdate
END;
SELECT hire_date from hr;

-- change hire_date colimn to date
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;




ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- dropping termdate column
ALTER  TABLE hr
DROP COLUMN termdate;

-- Add age column
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());
SELECT * from hr;

SELECT
min(age) AS youngest,
max(age) AS oldest
FROM hr;

-- QUESTIONS
-- 1 What is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count
FROM hr
GROUP BY gender;


-- % OF FEMALE EMPLOYEES
SELECT 
    CONCAT(
        ROUND(
            (SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 
            2),
        '%'
    ) AS percent_female
FROM hr;


-- % OF MALE EMPLOYEES
SELECT 
    ROUND(
        (SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 
        2
    ) AS percent_male
FROM hr;

-- show with % in front of the number
SELECT 
    CONCAT(
        ROUND(
            (SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) / COUNT(*) * 1.0) * 100,
            2
        ),
        '%'
    ) AS percent_male
FROM hr;




SELECT 
    gender,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM hr)) * 100, 2) AS percent_of_total
FROM hr
GROUP BY gender;


-- 2. What is the race or ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS count

FROM hr
GROUP BY race
order by count(*) desc;

-- 2.Count and percentage of each race/ethnicity group

SELECT
    race,
    COUNT(*) AS count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr),
        2
    ) AS percentage
FROM hr
GROUP BY race
ORDER BY count DESC;


-- 3. What is the age distribution of employees in the company

-- Find youngest and oldest
SELECT
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr;

-- . Grouping employees into age ranges
SELECT
    CASE
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age >= 55 THEN '55+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS employee_count
FROM hr
GROUP BY age_group
ORDER BY age_group;

-- count of employees in each age group

SELECT CASE
            WHEN age BETWEEN 18 AND 24 THEN '18-24'
            WHEN age BETWEEN 25 AND 34 THEN '25-34'
            WHEN age BETWEEN 35 AND 44 THEN '35-44'
            WHEN age BETWEEN 45 AND 54 THEN '45-54'
            WHEN age >= 55 THEN '55+'
            ELSE 'Unknown' END AS age_group,
       COUNT(*) AS employee_count
FROM hr
GROUP BY age_group
ORDER BY age_group;

-- 4. comparing number of HQ VERSUS remote employees
SELECT location, 
COUNT(*) AS employee_count
FROM hr
GROUP BY location;

-- 5.Gender count by department and job title.
SELECT gender, department, jobtitle,
COUNT(*) AS gender_count
FROM hr
GROUP BY gender, department, jobtitle
ORDER BY gender, department, jobtitle;

select * from hr;

-- 6. Frequency of each job title

SELECT jobtitle, 
COUNT(*) AS frequency
FROM hr
GROUP BY jobtitle
ORDER BY frequency DESC;

-- 7. Average age by department

SELECT department,
ROUND(AVG(age), 1) AS average_age
FROM hr
GROUP BY department
ORDER BY average_age DESC;



-- 8. Count of employees by city and state
SELECT
    location_state,
    location_city,
    COUNT(*) AS employee_count
FROM hr
GROUP BY
    location_state,
    location_city
ORDER BY
   location_state,
   location_city;
   
-- 9. Hiring Trends Over the Years

SELECT
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS hires_count
FROM hr
GROUP BY YEAR(hire_date)
ORDER BY hire_year;








