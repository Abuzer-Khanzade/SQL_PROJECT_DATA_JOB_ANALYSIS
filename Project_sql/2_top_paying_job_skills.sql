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
1. SQL Dominates the Skill Landscape

SQL appears the most, confirming it is still the core requirement for top-paying analyst roles. Companies rely heavily on relational databases, and high salaries go to analysts who can extract, transform, and analyze large datasets efficiently. In 2025, SQL remains the foundation of every strong analytics workflow.

2. Python Is Essential in Modern Analytics

Python is the second most requested skill, showing how analysts are expected to move beyond spreadsheets into automation, advanced data manipulation, and basic ML tasks. With tools like Pandas and NumPy, Python enables analysts to deliver faster and deeper insights, making it a must-have for high-impact roles.

3. Engineering Skills Are Rapidly Growing (Go, Node, Kubernetes)

The presence of Go, Node.js, and Kubernetes shows that analyst roles are shifting closer to analytics engineering. Companies want analysts who understand backend systems, APIs, and scalable data pipelines, blurring the line between analysts and engineers. These skills heavily increase earning potential.

4. Visualization Tools Remain Critical (Tableau, Looker, Power BI)

Visualization tools still matter, with Tableau, Looker, and Power BI appearing across top roles. Organizations rely on clear dashboards and data stories to guide decisions, so analysts must translate complex findings into visuals stakeholders can understand. Good communication remains as important as technical skill.

5. Modern Data Stack Technologies Are Increasingly Common

Tools like GraphQL, Git, Databricks, and PySpark reflect the rise of the modern data stack. High-paying companies expect analysts to collaborate in engineering-heavy environments, manage versioned analytics code, and work with big data efficiently. These tools help analysts operate at scale.

6. Traditional Business Tools Still Matter

Excel and PowerPoint still appear, proving that traditional business tools remain essential. Executives and stakeholders still depend on models and presentations for decision-making. The best analysts combine strong technical abilities with clear business communication.
*/
