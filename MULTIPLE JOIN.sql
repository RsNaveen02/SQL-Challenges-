--DAY15--1. Join patients, staff, and staff_schedule to show patient service and staff availability.
		SELECT p.name as patients_name,s.staff_name as staff_name,ss.present,ss.role,ss.service FROM patients p
		LEFT JOIN staff s
		on p.service =s.service
		LEFT JOIN staff_schedule ss
		ON s.staff_id  = ss.staff_id;

--	2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
		SELECT Sw.service FROM services_weekly Sw
		LEFT JOIN staff s
		ON Sw.service = s.service
		LEFT JOIN staff_schedule ss
		on ss.staff_id =s.staff_id 

--	3. Create a multi-table report showing patient admissions with staff information.
		SELECT Sw.service,Sw.patients_admitted,s.staff_name as staff_name 
		FROM services_weekly Sw
		LEFT JOIN staff s
		ON Sw.service = s.service
		LEFT JOIN staff_schedule ss
		on ss.staff_id =s.staff_id 
		GROUP BY Sw.service, Sw.patients_admitted,s.staff_name 
		
		
	--### Daily Challenge: 
	--**Question:** Create a comprehensive service analysis report for week 20 showing: service name, 
	--total patients admitted that week, total patients refused, average patient satisfaction, 
	--count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
	SELECT sw.service as service_name,
	sum(sw.patients_admitted) as total_patients_admitted,
	sum(sw.patients_refused) as total_patients_refused, 
	ROUND(AVG(sw.patient_satisfaction),2) as avg_patient_satisfaction,
	COUNT(DISTINCT s.staff_id) as total_staff_assigned,
	COUNT( DISTINCT CASE WHEN ss.present =1 then ss.staff_id END ) as total_staff_presented
	FROM services_weekly sw
	LEFT JOIN  staff s
	on sw.service = s.service 
	LEFT JOIN  staff_schedule ss
	ON ss.staff_id = s.staff_id	
	AND ss.week =20
	WHERE sw.week=20
	GROUP BY sw.service
	ORDER BY total_patients_admitted DESC;

	