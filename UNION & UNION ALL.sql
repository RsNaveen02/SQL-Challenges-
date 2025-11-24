--Day18
	
	--Q1. Combine patient names and staff names into a single list.
			SELECT name FROM patients Union Select staff_name  FROM staff
		
    --Q2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
			SELECT satisfaction,'High' AS category FROM patients WHERE satisfaction > 90
	        UNION
			SELECT satisfaction,'Low' AS category FROM patients WHERE satisfaction < 50;

    --Q3. List all unique names from both patients and staff tables.
	        SELECT name,'PATIENT' AS category FROM patients 
		    Union 
		    SELECT staff_name,'STAFF' AS category FROM staff
			
	--main QUS Create a comprehensive personnal and patient list showing: 
	--identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), 
	--and associated service. Include only those in 'surgery' or 'emergency' services. 
	--Order by type, then service, then name.
			SELECT patient_id as Identifer,service, name as FULL_NAME,'PATIENT' AS type FROM patients WHERE service in('surgery' , 'emergency')
		    Union 
		    SELECT staff_id as Identifer,service,staff_name AS FULL_NAME,'STAFF' AS type FROM staff WHERE service in('surgery' , 'emergency')
			ORDER BY service,FULL_NAME


	