-- ---------------------------------------------------------------------------------------------------------------------------
-- What I am doing: Extract the appropriate data from the dim_HR database, and INSERT it into the HR_management_DW database --
-- ---------------------------------------------------------------------------------------------------------------------------

-- populating dim_employees --
INSERT INTO `HR_management_DW`.`dim_employees`
(`employee_key`,
`first_name`,
`last_name`,
`email`,
`phone_number`,
`hire_date`,
`job_key`,
`salary`,
`manager_key`,
`department_key`)
SELECT `employees`.`employee_id`,
    `employees`.`first_name`,
    `employees`.`last_name`,
    `employees`.`email`,
    `employees`.`phone_number`,
    `employees`.`hire_date`,
    `employees`.`job_id`,
    `employees`.`salary`,
    `employees`.`manager_id`,
    `employees`.`department_id`
FROM `HR_management`.`employees`;

# validating #
SELECT * FROM HR_management_DW.dim_employees;


-- populating dim_departments -- 
INSERT INTO `HR_management_DW`.`dim_departments`
(`department_key`,
`department_name`,
`location_key`)
SELECT `departments`.`department_id`,
    `departments`.`department_name`,
    `departments`.`location_id`
FROM `HR_management`.`departments`;

# validating #
SELECT * FROM HR_management_DW.dim_departments;


-- populating dim_jobs --
INSERT INTO `HR_management_DW`.`dim_jobs`
(`job_key`,
`job_title`,
`min_salary`,
`max_salary`)
SELECT `jobs`.`job_id`,
    `jobs`.`job_title`,
    `jobs`.`min_salary`,
    `jobs`.`max_salary`
FROM `HR_management`.`jobs`;

# validating #
SELECT * FROM HR_management_DW.dim_jobs;


-- populating dim_locations -- 
INSERT INTO `HR_management_DW`.`dim_locations`
(`location_key`,
`street_address`,
`postal_code`,
`city`,
`state_province`,
`country_key`)
SELECT `locations`.`location_id`,
    `locations`.`street_address`,
    `locations`.`postal_code`,
    `locations`.`city`,
    `locations`.`state_province`,
    `locations`.`country_id`
FROM `HR_management`.`locations`;


# validating #
SELECT * FROM HR_management_DW.dim_locations;

-- populating fact table -- 
INSERT INTO `HR_management_DW`.`fact`
(`fact_key`,
`employee_key`,
`job_key`,
`department_key`,
`location_key`,
`hire_date`,
`salary`
)
SELECT e.employee_id,
e.employee_id,
j.job_id,
d.department_id,
l.location_id,
e.hire_date,
e.salary

FROM HR_management.jobs j
INNER JOIN HR_management.employees e
ON j.job_id = e.job_id
INNER JOIN HR_management.departments d
ON e.department_id = d.department_id
INNER JOIN HR_management.locations l
ON d.location_id = l.location_id ;


# validating # 
SELECT * FROM HR_management_DW.fact;



/* practice aggregation that I put on Jupyter Notebooks, just wanted to visualize it better through SQL 

SELECT dj.job_title AS job_title, 
	AVG(min_salary) AS avg_min_salary, 
	AVG(max_salary) AS avg_max_salary
	
FROM HR_management_DW2.event_fact ef
INNER JOIN HR_management_DW2.dim_employees de
ON ef.job_key = de.job_key
INNER JOIN HR_management_DW2.dim_jobs dj
ON de.job_key = dj.job_key

GROUP BY dj.job_title
ORDER BY avg_min_salary ASC;

*/

