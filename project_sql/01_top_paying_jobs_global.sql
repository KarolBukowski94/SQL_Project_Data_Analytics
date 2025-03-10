--Global--
SELECT
	name AS company_name,
	job_id,
	job_title,
	salary_year_avg,
	job_schedule_type,
	job_posted_date::DATE
FROM
	job_postings_fact
LEFT JOIN 
	company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
	job_title_short = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
ORDER BY
	salary_year_avg DESC 
LIMIT 10;