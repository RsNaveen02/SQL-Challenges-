--DAY 19
	--Q1. Rank patients by satisfaction score within each service.
			SELECT name,service, satisfaction,
			rank() OVER(
			PARTITION BY service
			ORDER BY satisfaction DESC )as rank
			FROM patients
	--Q2. Assign row numbers to staff ordered by their name.
	     	SELECT *,
			 ROW_NUMBER() OVER (ORDER BY staff_name) FROM staff
	
	--Q3. Rank services by total patients admitted.
			SELECT SUM(patients_admitted) as TOTAL_PATIENTS_ADMITTED, service,
			RANK() OVER(
			ORDER BY SUM(patients_admitted) DESC
			) as RANK
			FROM services_weekly
			GROUP BY service

	--Main Question
	--Question: For each service, rank the weeks by patient satisfaction score (highest first). 
	--Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service
			SELECT * FROM(
			SELECT service, week,patient_satisfaction,patients_admitted,
			rank() OVER(
			PARTITION BY service --Ranking resets for each service.
			ORDER BY patient_satisfaction DESC )as rank
			FROM services_weekly
			) as g
			WHERE g.rank<=3
			ORDER BY rank
			