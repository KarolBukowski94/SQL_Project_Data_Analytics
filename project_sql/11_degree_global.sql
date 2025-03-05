--Global--
SELECT 
    ROUND(COUNT(CASE WHEN job_no_degree_mention = FALSE THEN 1 END) * 100.0 / COUNT(*), 0) AS degree,
    ROUND(COUNT(CASE WHEN job_no_degree_mention = TRUE THEN 1 END) * 100.0 / COUNT(*), 0) AS no_degree
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst';