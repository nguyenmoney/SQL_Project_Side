/* 
Question: What are the top demanded skills in job postings for data engineers?
    - Indentify the top 10 in-demand skills for data engineers based on job postings.
    - Focus on remote job postings.
    - Why? Retrieve the top 10 skills with the highest demand in the remote job postings for data engineers, 
    providing  insights into the current trends and requirements in the field of data engineering.
*/
 
SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
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
ORDER BY
    demand_count DESC
LIMIT 10;

/*
The breakdown of the top 10 demanded skills in remote job postings for data engineers:
    - SQL and Python are the most sought-after skills, indicating a strong demand for proficiency in database management and programming. 
    - Cloud platforms like AWS and Azure are also highly valued, reflecting the industry's shift towards cloud-based solutions. 
    - Additionally, skills in Spark, Airflow, Snowflake, Databricks, Java, and Kafka highlight the importance of big data processing, workflow orchestration, and real-time data streaming in modern data engineering roles. These insights can guide aspiring data engineers in prioritizing their skill development to align with current market demands.
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        34601 │
│ python     │        34368 │
│ aws        │        22161 │
│ azure      │        16890 │
│ spark      │        15972 │
│ airflow    │        12322 │
│ snowflake  │        10777 │
│ databricks │        10068 │
│ java       │         8893 │
│ kafka      │         8312 │
└────────────┴──────────────┘
*/