/* 
Question: What are the most optimal skills for data engineers, balancing both demand and salary?
    - Create a ranking column that combines demand count and median salary to identify the most valuable skills for data engineers.
    - Focus on remote job postings with specific salary information.
    - Why? This analysis will help identify skills that not only have high demand but also offer competitive salaries, providing a more comprehensive view of skill development priorities for data engineers.
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) , 1) AS median_salary
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title LIKE '%Data Engineer%' AND jpf.job_location = 'Anywhere'
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;
