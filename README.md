 # Introduction

Welcome to my project, where I demonstrate my expertise in **SQL** as a powerful tool for data analysis! 

A special thanks to [Luke Barousse](https://github.com/lukebarousse) and [Kelly Adams](https://github.com/kellyjadams) for developing the [SQL Data Analytics Course](https://www.youtube.com/watch?v=7mz73uXD9DA&t=14011s), which provides aspiring data analysts with a structured and accessible way to master **SQL**.

This project is based on a dataset sourced from the course materials, featuring real-world job posting data from 2023. The dataset offers valuable insights into job titles, salaries, locations, essential skills, and other key employment factors.

# Background
This project is designed to help aspiring data analysts (like myself) better understand the job market by analyzing the global and Polish data analyst job landscape.

### 🔍 Key Areas of Analysis:
1. Top-Paying Jobs 💰
2. Skills for Top-Paying Jobs 🔧
3. Most In-Demand Skills 🔥
4. Highest-Paying Skills 💰🔧
5. Optimal Skills to Learn 📚💡
6. Degree requirements 🎓
7. Peak Hiring Months 📅📈

# Tools Used
To conduct this analysis, I leveraged several essential tools:

- **SQL –** The core of my analysis, enabling me to extract meaningful insights from the database.
- **PostgreSQL –** The database management system used to handle job posting data.
- **Visual Studio Code –** Utilized for managing the database and efficiently executing SQL queries.
- **Git & GitHub –** Essential for version control, sharing SQL scripts, and tracking project progress.
- **Power BI –** Used for data visualization, transforming SQL-extracted data into insightful charts.
- **ChatGPT (Plus Subscription) –** Assisted in deriving data-driven insights and crafting clear, concise summaries.

🔍 [**SQL queries**](/project_sql/)  
📊 [**Power BI charts**](/assets/)

# The Analysis
Each query in this project was designed to explore key aspects of the data analyst job market in 2023, both globally and in Poland. Here’s how I approached each question:

### 1. Top-Paying Jobs 💰
These queries pinpoint the highest-paying data analyst roles, highlighting the most lucrative opportunities in the field.

```sql
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
```
```sql
--Poland--
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
	AND job_country = 'Poland'
ORDER BY
	salary_year_avg DESC 
LIMIT 10;
```
**Key Takeways**

**Global Market**:
- **Salary Range**: Data Analyst salaries range from $285K and $400K, with Mantys offering an exceptional $650K.
- **Job Titles**: Positions vary widely, from standard Data Analyst roles to specialized and leadership positions such as Director of Safety Data Analysis and Head of Data Analytics.
- **Key Companies**: The market is dominated by leading tech and AI firms (Meta, Anthropic, OpenAI, Torc Robotics) alongside major finance and security companies (Citigroup, Illuminate Mission Solutions). Leadership roles command higher salaries, and startups like Mantys offer premium compensation to attract top talent.

**Polish Market**:
- **Salary Range**: Salaries are more modest, with Data Architect roles averaging $165K — roughly 50% higher than the more common Data Analyst roles, which typically pay around $111K.
- **Job Titles**: The market offers a mix of general and specialized roles, including Data Architect, Marketing Data Analyst, and Data Analyst – Risk.
- **Key Companies**: Companies such as Alter Solutions, Allegro, Bosch Group, and SumUp frequently post job openings, indicating steady demand across multiple industries.

**Comparison**:
- **Compensation**: Global salaries are significantly higher, with a broader range and more leadership opportunities, whereas the Polish market maintains a more stable and modest pay scale.
- **Role Specialization**: Globally, there is a stronger focus on high-level leadership and tech/AI innovation, while the Polish market emphasizes specialization within traditional sectors, balancing between strategic roles (Data Architect) and general data analytics positions.

![Top Paying Jobs](assets/1_top_paying_jobs.PNG)
*Bar charts generated in Power BI from my SQL query results showcase the salary distribution of the top 10 highest-paying data analyst roles in 2023, both globally and in Poland, along with their corresponding salaries.*

### 2. Skills for Top-Paying Jobs 🔧
To identify the most in-demand skills for the highest-paying jobs, I merged job postings with skills data and expanded the top-paying jobs list to 20, allowing for a deeper market analysis. This analysis highlights the key competencies that employers prioritize for top-paying roles.
```sql
--Global--
WITH top_paying_jobs AS
(
    SELECT
        name AS company_name,
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
    ORDER BY
        salary_year_avg DESC
    LIMIT
        20
)
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
```
```sql
--Poland--
WITH top_paying_jobs AS
(
    SELECT
        name AS company_name,
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_country = 'Poland'
    ORDER BY
        salary_year_avg DESC
    LIMIT
        20
)
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
```
**Key Takeways**

- **SQL**, **Python**, and **Tableau** are the top skills in both the global and Polish data analytics markets.
- The Polish market places a stronger emphasis on big data and cloud technologies (**GCP**, **Spark**, **Airflow**), whereas globally, traditional analytics tools (**R**, **SAS**, **Power BI**) remain essential for high-paying roles.
- **Excel** continues to be valuable in both markets, underscoring the enduring importance of spreadsheet skills despite the growing adoption of advanced analytics tools.

![Top Paying Jobs Skills](assets/2_top_paying_jobs_skills.png)

*Bar charts generated in Power BI from my SQL query results illustrate the frequency of skills required for the top 20 highest-paying data analyst jobs in 2023, both globally and in Poland.*

### 3. Most In-Demand Skills 🔥
This query identified the most commonly requested skills in job postings, highlighting key areas of high demand.
```sql
--Global--
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
```sql
--Poland--
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Poland'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
**Key Takeways**

- **SQL** and **Excel** remain fundamental, underscoring the importance of strong foundational skills in data processing and spreadsheet management.
- Programming and Visualization Tools such as **Python**, **Tableau**, and **Power BI** are essential, highlighting the growing demand for technical skills in data storytelling and decision-making.

![Top Demanded Skills](assets/3_top_demanded_skills.png)
*Column charts generated in Power BI from my SQL query results showcase the 5 most in-demand skills in data analyst job postings in 2023, both globally and in Poland*

### 4. Highest-Paying Skills 💰🔧
Analyzing the average salaries associated with various skills revealed which ones command the highest pay.
```sql
--Global--
SELECT
    skills AS skill,
    ROUND (AVG (salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skill
ORDER BY
    avg_salary DESC
LIMIT 10;
```
```sql
--Poland--
SELECT
    skills AS skill,
    ROUND (AVG (salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country = 'Poland'
GROUP BY
    skill
ORDER BY
    avg_salary DESC
LIMIT 10;
```
**Key Takeways**

- **Niche Technologies Dominate Globally**: The highest salaries are associated with specialized and emerging skills such as **SVN** ($400K), **Solidity** ($179K), and **Couchbase** ($161K), reflecting strong demand for cutting-edge technologies in the global market.
- **Cloud & Database Expertise in Poland**: In Poland, **MongoDB**, **Linux**, and **AWS** are the top-paying skills, each offering $165K, highlighting the growing importance of cloud computing and database management in the local job market.
- **Big Data vs. Emerging Tech**: While the global market highly rewards niche and emerging technologies, Poland places a stronger emphasis on cloud infrastructure and big data skills such as **Hadoop** ($134K) and **NoSQL** ($132K) for high salaries.
- **Salary Trends**: While global salaries for specialized technologies can reach exceptional levels, Poland’s highest-paying skills remain within the $165K range, reflecting a more balanced distribution across in-demand technologies.

![Top Paying Skills](assets/4_top_paying_skills.png)
*Bar charts generated in Power BI from my SQL query results present the average salaries for the top 10 highest-paying skills in data analyst job postings in 2023, both globally and in Poland*

### 5. Optimal Skills to Learn 📚💡

By combining demand and salary insights, this query aimed to identify skills that are both highly sought after 🔥 and well-paid 💰, providing a strategic focus for skill development.

```sql
--Global--
WITH
    skills_demand AS (
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.job_id) AS demand_count
        FROM 
            job_postings_fact
            INNER JOIN 
                skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN
                skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst' 
            AND job_postings_fact.salary_year_avg IS NOT NULL 
        GROUP BY
            skills_dim.skill_id
),
    average_salary AS (
        SELECT
            skills_job_dim.skill_id,
            AVG (job_postings_fact.salary_year_avg) AS avg_salary
        FROM 
            job_postings_fact
        INNER JOIN 
            skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst' 
            AND job_postings_fact.salary_year_avg IS NOT NULL 
        GROUP BY
            skills_job_dim.skill_id
)
SELECT
    DISTINCT(skills_demand.skills),
    skills_demand.demand_count,
    ROUND(average_salary.avg_salary, 0) AS avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 250
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15;
```
```sql
--Poland--
WITH
    skills_demand AS (
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.job_id) AS demand_count
        FROM 
            job_postings_fact
            INNER JOIN 
                skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN
                skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst' AND
            job_postings_fact.salary_year_avg IS NOT NULL AND
            job_postings_fact.job_country = 'Poland'
        GROUP BY
            skills_dim.skill_id
),
    average_salary AS (
        SELECT
            skills_job_dim.skill_id,
            AVG (job_postings_fact.salary_year_avg) AS avg_salary
        FROM 
            job_postings_fact
        INNER JOIN 
            skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst' AND
            job_postings_fact.salary_year_avg IS NOT NULL AND
            job_postings_fact.job_country = 'Poland'
        GROUP BY
            skills_job_dim.skill_id
)
SELECT
    skills_demand.skills,
    skills_demand.demand_count,
    ROUND(average_salary.avg_salary, 0) AS avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 4
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15;
```
**Key Takeways**

- **SQL** & **Python** dominate in demand but do not command the highest salaries.
- **AWS** and **Azure** lead globally, while in Poland, **Airflow**, **Windows**, **GCP**, and **Spark** reflect a growing demand for cloud-based infrastructure, workflow automation, and big data processing.
- **Tableau** and **Looker** remain highly valuable BI tools, while **Power BI** is widely used but tends to offer slightly lower salaries.
- **R** remains significant globally but has lower demand in Poland, indicating a regional shift toward Python-based analytics.
- **Excel** continues to be widely used but offers lower salaries, reinforcing its role as a fundamental skill rather than a high-paying specialty.

![Optimal Skills](assets/5_optimal_skills.png)

*Tables generated in Power BI from my SQL query results showcases the most optimal skills to learn for data analysts, sorted by salary, both globally and in Poland.*

### 6. Degree requirements 🎓

This analysis helps aspiring data analysts navigate the job market by identifying the proportion of job postings that do not require a degree 🎓. It offers valuable insights for job seekers, helping them decide whether to invest in formal education or focus on self-learning to develop practical skills 🧠.
```sql
--Global--
SELECT 
    ROUND(COUNT(CASE WHEN job_no_degree_mention = FALSE THEN 1 END) * 100.0 / COUNT(*), 0) AS degree,
    ROUND(COUNT(CASE WHEN job_no_degree_mention = TRUE THEN 1 END) * 100.0 / COUNT(*), 0) AS no_degree
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst';
```
```sql
--Poland--
SELECT 
    ROUND(COUNT(CASE WHEN job_no_degree_mention = FALSE THEN 1 END) * 100.0 / COUNT(*), 0) AS degree,
    ROUND(COUNT(CASE WHEN job_no_degree_mention = TRUE THEN 1 END) * 100.0 / COUNT(*), 0) AS no_degree
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND job_country = 'Poland';
```
**Key Takeways**

- **Global Market:** While **39%** of data analyst roles globally do not explicitly require a degree, this does not mean employers disregard formal education. A degree is still mentioned in **61%** of job postings, indicating that it remains a key qualification for many roles.
- **Polish Market:** In Poland, **56%** of job postings do not list a degree as a requirement, suggesting a stronger emphasis on skills-based hiring. However, **44%** of positions still specify a degree, meaning formal education can still be a competitive advantage.
- **Conclusions:** Opportunities exist for candidates without degrees, especially in Poland, where practical experience and certifications may hold more weight. However, a degree can still enhance job prospects, particularly in companies that prioritize formal education. Even when not explicitly required, employers may still prefer candidates with an academic background.


![Degree](assets/6_degree.png)
*Pie charts created in Power BI from my SQL query results illustrates the percentage of data analyst job postings from 2023 that require versus do not require a degree, both globally and in Poland*

### 7. Peak Hiring Months 📅📈

This analysis identifies peak periods 📅 for data analyst job postings, helping job seekers strategically time their applications for the best opportunities.

```sql
--Global--
SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_id) AS number_of_postings_global
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY
    month;
```
```sql
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
```
**Key Takeways**

- **January** sees the highest number of job postings as companies ramp up hiring at the start of the new year.
- Hiring slows mid-year (May globally, June in Poland), followed by a secondary increase in **August** as recruitment picks up after the summer slowdown.
- Hiring activity gradually declines toward the end of the year (September–December), reflecting a typical slowdown due to holidays and year-end budget cycles.
- **Conclusion:** Job seekers are most likely to find opportunities at the beginning of the year, with a smaller hiring surge in late summer.

![Job Postings](assets/7_monthly_job_postings.png)
*Line charts generated in Power BI from my SQL query results reveal the monthly job postings for data analysts in 2023, both globally and in Poland*

# What I Learned

- **🧩 Advanced Query Building:** Honed my ability to craft complex SQL queries, utilizing subqueries, seamlessly joining tables with JOIN, and leveraging WITH clauses for efficient temporary table management.
- **📊 Data Aggregation:** Gained familiarity with GROUP BY, using aggregate functions like COUNT() and AVG() to extract meaningful insights from large datasets.
- **💡 Analytical Problem-Solving:** Sharpened my ability to translate real-world questions into insightful SQL queries, transforming raw data into actionable intelligence.
- **📈 Power BI Visualization:** Enhanced my data storytelling skills by creating compelling visualizations in Power BI, turning numbers into clear, impactful charts.

# Conclusions

### Insights
From the analysis, several key insights about data analyst jobs emerged:

**Top-Paying Jobs 💰**

- **Global**: Salaries typically range from $285K to $400K, with exceptions like startups (e.g., Mantys – $600K). High salaries are driven by expertise in leadership, tech/AI innovation, finance, and security.
- **Poland**: Salaries mostly hover around $111K, with Data Architect roles reaching $165K. The market emphasizes specialization within traditional sectors rather than emerging tech.

**Skills for Top-Paying Jobs 🔧**

- **SQL**, **Python**, and **Tableau** are the most crucial skills for securing the highest-paid roles in both the global and Polish data analytics markets.

**Most In-Demand Skills 🔥**

- The Top 5 most essential skills across the data analytics job market, both globally and in Poland, are **SQL**, **Excel**, **Python**, **Tableau**, and **Power BI**.

**Top-paying skills 💰🔧**

- **Global**: Niche technologies such as **SVN**, **Solidity**, and **Couchbase** command the highest salaries.
- **Poland**: Cloud & Database skills like **MongoDB** and **AWS** lead the top-paying skill set.

**Most Optimal Skills to Learn 📚💡**

- **SQL**, **Python**, **Excel**, **Tableau**, and **Power BI** may not command the highest salaries, but their strong demand makes them fundamental for most data analysts.
- **R** can be a valuable addition to a core skill set, offering competitive salaries and high demand in the global market.
- High-paying and in-demand skills related to cloud-based infrastructure, workflow automation, and big data processing (e.g., **AWS**, **Azure**, **Airflow**, **Windows**, **GCP**, and **Spark**) present strong learning opportunities for career growth.

**Degree requirements 🎓**

- **Global:** 39% of job postings do not explicitly mention a degree requirement, but one may still be expected.
- **Poland:** 56% of job postings do not specify a degree requirement, though it may still be necessary.

**Peak Hiring Months 📅📈**

- **Global & Poland:** The highest number of job postings occur in **January** and **August**, with a slowdown in the middle and end of the year.

### Closing Thoughts

This project significantly enhanced my SQL, Power BI, and AI skills while providing valuable insights into the data analyst job market, both globally and in Poland. The findings serve as a practical guide for prioritizing skill development and optimizing job search strategies.

For aspiring data analysts, focusing on high-demand and high-paying skills can provide a competitive edge in the industry. This exploration highlights the importance of continuous learning, adaptability, and staying updated on emerging trends, tools, and technologies in data analytics.