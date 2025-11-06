						-- 	### Daily Challenge Day 4	
--1) Display the first 5 patients from the patients table.

	-- SELECT name FROM patients limit 5;

--2) Show patients 11-20 using OFFSET.

 	-- SELECT name FROM patients limit 10 OFFSET 10;
	 
--Get the 10 most recent patient admissions based on arrival_date.
	
--Select name, arrival_date from patients 
--ORDER BY arrival_date DESC
--limit 10;
							--Main Question	
--Question:** Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.

	--	SELECT patient_id, name, service, satisfaction
	--	FROM patients ORDER BY satisfaction DESC
	--	LIMIT 5 OFFSET 2;
