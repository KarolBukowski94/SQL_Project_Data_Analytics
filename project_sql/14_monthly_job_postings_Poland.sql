--Poland--
SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_id) AS number_of_postings_Poland
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND job_country = 'Poland'
GROUP BY 
    month
ORDER BY
    month;