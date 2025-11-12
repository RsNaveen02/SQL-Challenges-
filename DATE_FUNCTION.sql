				--DAY 9
--1. Extract the year from all patient arrival dates.
		--SELECT arrival_date FROM patients;
		
--2. Calculate the length of stay for each patient (departure_date - arrival_date).
		--SELECT patient_id,(departure_date - arrival_date) as  each_patient FROM patients;
		
--3. Find all patients who arrived in a specific month.
		--SELECT patient_id,name,EXTRACT(MONTH FROM arrival_date) as SPECIFIC_MONTH FROM patients

		-- Calculate the average length of stay (in days) for each service, 
		--showing only services where the average stay is more than 7 days. 
		--Also show the count of patients and order by average stay descending.

	SELECT service, COUNT(patient_id) AS total_patient,
    ROUND(AVG(departure_date - arrival_date),2) AS EACH_SERVICE
	FROM patients
	GROUP BY service
	HAVING AVG(departure_date - arrival_date) > 7
	ORDER BY EACH_SERVICE DESC;
