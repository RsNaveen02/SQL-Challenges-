--DAY-8	--	1. Convert all patient names to uppercase.
		  -- SELECT UPPER(name) as uppercase_name FROM patients;
		  
	--	2. Find the length of each staff member's name.
			--SELECT LENGTH(staff_name) as characters FROM staff
			
	--	3. Concatenate staff_id and staff_name with a hyphen separator.
			--SELECT CONCAT( staff_id,'-',staff_name) as staff_name  FROM staff_schedule

		--Question: Create a patient summary that shows patient_id, 
		--full name in uppercase, service in lowercase, age category 
		--(if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), 
		--and name length. Only show patients whose name length is greater than 10 characters.

	SELECT patient_id,UPPER(name) as Full_Name,LOWER(service) as service,
	CASE 
		WHEN (Age>= 65) Then 'senior'
		when (Age>=18)  Then 'Adult'
		else 'Minor'
	END as age_category,
	LENGTH(name) as characters
		FROM patients
	where LENGTH(name)>10;
	