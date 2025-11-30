/*
**Question: What are the top-paying data analyst jobs, and what skills are required?** 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
  helping job seekers understand which skills to develop that align with top salaries
*/

-- Gets the top 10 paying Data Analyst jobs 


WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg,
        job_via
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND (job_location = 'Anywhere' or job_location like '%london%')
    ORDER BY
        salary_year_avg DESC 
    LIMIT 10
)


-- Skills required for data analyst jobs
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
	INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
	INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
High-paying data analyst roles in 2023 show a clear skill hierarchy.
SQL is the top requirement, proving that companies still depend heavily on relational databases and need analysts strong in querying and data extraction.

Python comes next, showing that analysts are expected to handle automation, data cleaning, and basic machine-learning workflows. Libraries like Pandas and NumPy appearing separately strengthen its importance.

Tableau follows in third place, highlighting the need for strong visualization and dashboard-building abilities for business reporting.

R appears moderately, mainly for statistics-heavy or research-focused roles.

Skills like Snowflake, Pandas, and Excel form the next tier, reflecting the shift toward cloud data warehouses, advanced data manipulation, and the ongoing relevance of spreadsheets.

Less frequent but valuable differentiator skills include Azure, Bitbucket, and Go, which show increasing overlap between analytics and engineering.

Finally, tools such as PySpark, Databricks, Hadoop, Git, and Jupyter appear in more specialized roles, usually involving big-data or advanced technical workflows.
*/
