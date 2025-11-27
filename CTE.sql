--1. Create a CTE to calculate service statistics, then query from it.
	WITH service_stats AS (SELECT service, ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction,SUM(patients_admitted) AS total_admissions,
    COUNT(*) AS weeks_count,available_beds
    FROM services_weekly
    GROUP BY service,available_beds)SELECT * FROM service_stats;
--2. Use multiple CTEs to break down a complex query into logical steps.
	WITH staff_hours AS (SELECT staff_id,service,present FROM staff_schedule),
         staff_utilization AS ( SELECT staff_id, service,(present * 100.0 ) AS utilization_rate FROM staff_hours)
	SELECT p.patient_id, p.name AS patient_name,  p.service,s.utilization_rate FROM patients p
    JOIN staff_utilization s
    ON p.service = s.service;

--3. Build a CTE for staff utilization and join it with patient data.
		WITH staff_utilization AS (SELECT staff_id,
        staff_name,service,present,role,(present * 100.0 ) AS utilization_rate FROM staff_schedule)
		SELECT p.patient_id,p.name AS patient_name,p.service,s.staff_name,s.utilization_rate FROM staff_utilization s
        JOIN patients p ON s.service = p.service;


--**Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 
--1) Service-level metrics (total admissions, refusals, avg satisfaction), 2) 
--Staff metrics per service (total staff, avg weeks present), --
--3) Patient demographics per service (avg age, count). 
--Then combine all three CTEs to create a final report showing service name, 
--all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction).
-- Order by performance score descending.
WITH 
-- 1️ Service-level metrics
service_level AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),

-- 2️ Staff metrics per service
staff_metrics AS (
    SELECT
        service,
        COUNT(staff_id) AS total_staff,
        ROUND(AVG(week),2) AS avg_weeks_present
    FROM staff_schedule
    GROUP BY service
),

-- 3️ Patient demographics per service
patient_demo AS (
    SELECT
        service,
        ROUND(AVG(age), 1) AS avg_age,
        COUNT(patient_id) AS patient_count
    FROM patients
    GROUP BY service
),

-- 4️ Overall performance score
-- Weighted: 70% admission rate + 30% satisfaction
performance AS (
    SELECT
        s.service,
        total_admissions,
        total_refusals,
        avg_satisfaction,
        total_staff,
        avg_weeks_present,
        avg_age,
        patient_count,
        
        -- compute admission rate (admissions / (admissions + refusals))
        (total_admissions * 1.0 / NULLIF((total_admissions + total_refusals), 0)) AS admission_rate,

        -- performance score (weighted)
        (0.7 * (total_admissions * 1.0 / NULLIF((total_admissions + total_refusals), 0))) +
        (0.3 * avg_satisfaction / 100) AS performance_score
    FROM service_level s
    JOIN staff_metrics sm USING (service)
    JOIN patient_demo pd USING (service)
)

-- 5️ Final dashboard output
SELECT 
    service,
    total_admissions,
    total_refusals,
    avg_satisfaction,
    total_staff,
    avg_weeks_present,
    avg_age,
    patient_count,
    ROUND(admission_rate, 3) AS admission_rate,
    ROUND(performance_score, 3) AS performance_score
FROM performance
ORDER BY performance_score DESC;
