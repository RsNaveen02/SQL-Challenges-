--	1. Find services that have admitted more than 500 patients in total.
		--SELECT service , sum( patients_admitted) as admitted from services_weekly
		--GROUP BY service
		--HAVING sum(  patients_admitted)> 500;
		
--	2. Show services where average patient satisfaction is below 75.
		--SELECT  service,name, ROUND (AVG(satisfaction),2) AS patient_satisfaction
		--FROM patients
		--GROUP BY service, name
		--HAVING AVG(satisfaction) < 75;

--	3. List weeks where ToTal staff presence across all services was less than 50.
		--SELECT week, SUM(DISTINCT present) as total_staff
		--FROM staff_schedule
		--group by week 
		--having  SUM(DISTINCT present) < 50;

--Question: Identify services that refused more than 100 patients in total 
--and had an average patient satisfaction below 80.
--Show service name, total refused, and average satisfaction.
         SELECT service, SUM(patients_refused) as total_patients_refused,
		 ROUND(AVG(patient_satisfaction),2) as average_satisfaction
		 FROM services_weekly
		 group by service
		 having  SUM(patients_refused)  >100 AND AVG(patient_satisfaction) <80
		 ORDER BY total_patients_refused DESC;
		  
		  