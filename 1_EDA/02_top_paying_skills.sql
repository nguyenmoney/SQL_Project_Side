/*
Question: What are the top highest paying skills for data engineers?
    - Calculate the median salary for each skill in job postings for data engineers.
    - Focus on remote job postings with specific salary information.
    - Include skill frequency to identify both salary and demand.
    - Why? Help identify which skills are providing a more complete picture for skill development priorities.
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

/*
Here is a breakdown of the top highest paying skills in remote job postings for data engineers:
    - Rust is the highest paying skill with a median salary of $200,000, indicating a strong demand for expertise in this language.
    - Golang and GDPR also show high median salaries, reflecting the value of proficiency in these areas.
    - Other skills like Terraform, Neo4j, Redis, and Zoom also command high salaries, suggesting that specialized knowledge in cloud infrastructure, database management, and communication tools is highly valued in the data engineering field.
    - There are skills with very low demand, particularly under 100 postings, which may indicate niche areas or emerging technologies that are not yet widely adopted.
    - Skills like Airflow, BigQuery, and Kafka are not only in high demand but also offer competitive salaries, making them attractive for data engineers looking to maximize their earning potential.
┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ rust       │          277 │      200000.0 │
│ golang     │          847 │      184000.0 │
│ gdpr       │          645 │      180500.0 │
│ terraform  │         4058 │      180000.0 │
│ neo4j      │          455 │      171500.0 │
│ redis      │          731 │      171500.0 │
│ zoom       │          139 │      165000.0 │
│ django     │          292 │      157500.0 │
│ c          │          518 │      157250.0 │
│ mongo      │          355 │      156763.3 │
│ graphql    │          448 │      155000.0 │
│ ruby       │          762 │      155000.0 │
│ spring     │          424 │      155000.0 │
│ crystal    │          132 │      154223.5 │
│ bitbucket  │          582 │      152500.0 │
│ node       │          183 │      152500.0 │
│ atlassian  │          305 │      151500.0 │
│ cassandra  │         1403 │      151000.0 │
│ dynamodb   │         1453 │      151000.0 │
│ kubernetes │         5106 │      150857.5 │
│ typescript │          442 │      150000.0 │
│ airflow    │        12322 │      150000.0 │
│ bigquery   │         4477 │      150000.0 │
│ kafka      │         8312 │      150000.0 │
│ css        │          260 │      148750.0 │
└────────────┴──────────────┴───────────────┘
*/