	--	1. Join patients and staff based on their common service field (show patient and staff who work in same service).
		--SELECT p.name as Patient_name, s.staff_Name as Staff_Name, P.service
		--FROM Patients p
		--JOIN Staff s
		--ON P.service = s.service;
		
	--	2. Join services_weekly with staff to show weekly service data with staff information.
		--SELECT s1.week as week_service,s2.role,s2.staff_name
		--FROM services_weekly s1
		--JOIN staff s2
		--ON s1.service=s2.service;
		
	--	3. Create a report showing patient information along with staff assigned to their service.
		--SELECT p.name as Patient_name, p.patient_id,p.age,s.staff_Name as Staff_Name, P.service
	    --FROM Patients p
		--JOIN Staff s
		--ON P.service = s.service;

		--Question: Create a comprehensive report showing patient_id, patient name, age, service, 
		--and the total number of staff members available in their service.
		--Only include patients from services that have more than 5 staff members. 
		--Order by number of staff descending, then by patient name.

	SELECT p.patient_id,p.name as Patient_name,p.age,p.service,COUNT(s.staff_name) as total_staff
	FROM patients p
	JOIN staff s
	ON p.service =s.service
	GROUP BY p.patient_id,p.name,p.age,p.service
	HAVING COUNT(s.staff_name)>5
	Order BY total_staff DESC,p.name ASC