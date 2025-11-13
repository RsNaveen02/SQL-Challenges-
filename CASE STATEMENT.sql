--DAY10
		--1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
			-- SELECT name, service,
			--CASE WHEN satisfaction >=90 THEN 'High'
			--WHEN satisfaction>=60 THEN'Medium'
			--ELSE 'Low' 
			--END AS satisfaction_category FROM patients;
			
		--2. Label staff roles as 'Medical' or 'Support' based on role type.
		    --SELECT staff_name, CASE
			--WHEN role IN ('doctor', 'nurse', 'surgeon') THEN 'Medical' 
			--ELSE 'Support' END AS label_staff FROM staff;

		--3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
			--SELECT *,
			--CASE WHEN age between 0 and 18 Then 'youngest'
			--	 WHEN age between 19 and 40 Then 'middlest'
			--	 WHEN age between 41 and 65 Then 'Oldest'
			--	 ELSE 'RETIRE'
			--	 END AS age_category FROM patients;
			
		--Question: Create a service performance report showing service name, 
		--total patients admitted, and a performance category based on the following:
		--'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. 
		--Order by average satisfaction descending.
			SELECT UPPER(service)as service, SUM(patients_admitted) as Total_patient,
			CASE WHEN AVG(patient_satisfaction) >=85 THEN 'EXCELLENT'
				 WHEN AVG(patient_satisfaction) >=75 THEN 'GOOD'
				 WHEN AVG(patient_satisfaction) >=65 THEN 'FAIR'
				 ELSE 'NEEDS IMPROVEMENT'
				 END AS PERFORMANCE_CATEGORY
			FROM services_weekly
			GROUP BY service
			ORDER BY PERFORMANCE_CATEGORY DESC;
		
