	--	1. Show all staff members and their schedule information (including those with no schedule entries).
			SELECT S1.staff_name,S1.role,S1.service
			FROM staff_schedule S2
			LEFT JOIN staff S1
			ON S1.staff_id = S2.staff_id
			GROUP BY S1.staff_name,S1.role,S1.service;
	--	2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
			SELECT N8.service,N2.staff_name,N2.staff_id FROM services_weekly N8
			LEFT JOIN staff N2
			on N8.service = N2.service
			ORDER BY N8.service
	--	3. Display all patients and their service's weekly statistics (if available).
			SELECT p.name as patient_name, p.age as patient_age , sw.week, sw.month, sw.staff_morale,sw.event FROM patients p
			LEFT JOIN services_weekly sw
			on p.service = sw.service  
			ORDER BY p.name;

--MAIN Question: Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) 
--and the count of weeks they were present (from staff_schedule).
--Include staff members even if they have no schedule records. Order by weeks present descending.

		SELECT s1.staff_id,s1.staff_name,s1.role,s1.service,COUNT(s2.week) as TOTAL_week
		FROM  staff s1
		LEFT JOIN staff_schedule s2
		ON s1.staff_id = s2.staff_id
		GROUP BY  s1.staff_id,s1.staff_name,s1.role,s1.service
		ORDER BY TOTAL_week DESC;
			