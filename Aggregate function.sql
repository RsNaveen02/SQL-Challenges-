
-- 1. Total number of patients
SELECT COUNT(*) AS Total_No_of_Patients 
FROM patients;

-- 2. Average satisfaction score
SELECT AVG(satisfaction) AS Avg_Score 
FROM patients;

-- 3. Youngest and eldest patient ages
SELECT MIN(age) AS Youngest, MAX(age) AS Elder 
FROM patients;

-- 4. Weekly service summary
SELECT 
    COUNT(DISTINCT patients_admitted) AS Admitted,
    COUNT(DISTINCT patients_refused) AS Refused,
    ROUND(AVG(DISTINCT patient_satisfaction), 2) AS Average_satisfaction
FROM 
    services_weekly;
