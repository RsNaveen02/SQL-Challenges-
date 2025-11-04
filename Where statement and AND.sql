--Day 1-- Q1) Select patient_id, name,  age
--from patients;
-- Q2) SELECT *
-- FROM services_weekly LIMIT 10 ;

--Day 2
--Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.		
		
		--Select patient_id, name,  age, satisfaction
		--from patients
		--WHERE (satisfaction < 50) AND service = 'Surgery';

		-- Select *
		-- From patients
		-- where age > 60;

		--Select *
		--from staff
		--where service = 'Emergency'; 
--List all weeks where more than 100 patients requested admission in any service.
		-- Select week, patients_admitted 
		--from services_weekly
		--where patients_request >100;

--Main problem
-- find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
	SELECT patient_id, name, age, satisfaction as satisfaction_score
	from patients
	where satisfaction < 70;
	