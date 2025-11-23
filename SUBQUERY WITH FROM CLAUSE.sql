	--DAY 17
	--Q1. Show each patient with their service's average satisfaction as an additional column.
			SELECT p.name,p.age,p.satisfaction,Ag.avg_staisfaction
			FROM patients p
			JOIN ( SELECT service,ROUND(AVG(satisfaction),2) as avg_staisfaction FROM patients GROUP BY service) as Ag
			ON p.service = Ag.service
			ORDER BY p.name
	--Q2. Create a derived table of service statistics and query from it.
			( 
			SELECT service,ROUND(AVG(satisfaction),2) as avg_staisfaction FROM patients GROUP BY service 
			) AS service_statistics
			
	--Q3. Display staff with their service's total patient count as a calculated field.
			SELECT s.staff_id, s.service,COUNT(P.patient_id) as total_patient,s.staff_name
			FROM (SELECT service,staff_id,staff_name FROM staff  ) as s
			left JOIN patients p
			ON p.service = s.service
		    GROUP BY s.staff_name,s.staff_id,s.service;

	--Q4  Create a report showing each service with: service name,
	--total patients admitted, the difference between their total admissions and the average admissions across all services,
	--and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT
    sw.service,
    -- total patients admitted for this service
    (SELECT SUM(patients_admitted)
     FROM services_weekly
     WHERE service = sw.service) AS total_patients_admitted,
    
    -- overall average admissions across ALL services
    (SELECT ROUND(AVG(service_total),2)
     FROM (
            SELECT service, SUM(patients_admitted) AS service_total
            FROM services_weekly
            GROUP BY service
          ) AS t
    ) AS average_admissions,
    
    -- difference = service total - avg total
    ((SELECT SUM(patients_admitted)FROM services_weekly WHERE service = sw.service) -
     (SELECT ROUND(AVG(service_total),2) FROM ( SELECT service, SUM(patients_admitted) AS service_total
            FROM services_weekly
            GROUP BY service
          ) AS t
     )
    ) AS difference,

    -- rank classification
    CASE
        WHEN (SELECT SUM(patients_admitted) FROM services_weekly WHERE service = sw.service)
             >
             (SELECT AVG(service_total) FROM ( SELECT service, SUM(patients_admitted) AS service_total
              FROM services_weekly
              GROUP BY service
              ) AS t
             )
        THEN 'Above Average'

        WHEN (SELECT SUM(patients_admitted)
              FROM services_weekly
              WHERE service = sw.service)
             =
             (SELECT AVG(service_total)
              FROM (
                    SELECT service, SUM(patients_admitted) AS service_total
                    FROM services_weekly
                    GROUP BY service
                   ) AS t
             )
        THEN 'Average'

        ELSE 'Below Average'
    END AS rank_indicator

FROM services_weekly sw
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;

 
 