							--DAY 11
							
				--1. List all unique services in the patients table.
						--SELECT DISTINCT UPPER(service) as SERVICE FROM patients
						
				--2. Find all unique staff roles in the hospital.
						--SELECT DISTINCT UPPER(role) as ROLE from staff
						
				--3. Get distinct months from the services_weekly table.
						--SELECT DISTINCT(month) FROM services_weekly
				
			--Question: Find all unique combinations of service and event type from the services_weekly table
			--where events are not null or none, 
			--along with the count of occurrences for each combination. Order by count descending.
				SELECT DISTINCT UPPER(service) as service, event,
				Count(event) as event_type
				FROM services_weekly
				WHERE event is not null
					AND lower(event) <> 'none'
				GROUP BY service, event
				ORDER BY event_type DESC
				
				
						