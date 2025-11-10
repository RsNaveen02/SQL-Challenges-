	--1. Count the number of patients by each service.
			-- SELECT Count(DISTINCT patients_admitted) from  services_weekly
	--2. Calculate the average age of patients grouped by service.
			--SELECT ROUND(AVG(age ),2) as average_age,service From patients Group by service
	--3. Find the total number of staff members per role.
	 		--SELECT COUNT(DISTINCT staff_name) as Total_staff, role From staff GROUP BY role

	--Question: For each hospital service, calculate the total number of patients admitted,
	--total patients refused, and the admission rate (percentage of requests that were admitted). 
	--Order by admission rate descending.
	SELECT service, Sum(patients_admitted) as no_patients_admitted,
	sum(patients_refused) as total_no_patients_refused,
	sum(patients_request) as no_of_applicants,
	ROUND(SUM(patients_admitted) * 100.0 / NULLIF(SUM(patients_request), 0),2) AS admission_rate
	From services_weekly
	GROUP BY service
	ORDER BY Admission_rate DESC;
	 