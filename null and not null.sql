--Day12
		--	1. Find all weeks in services_weekly where no special event occurred.
				--SELECT week,month,event FROM services_weekly where event is null or lower(event) ='none' 

		--	2. Count how many records have null or empty event values.
				--SELECT COUNT(event) as event_value from services_weekly
				--where event is null or event ='';
				
	--	3. List all services that had at least one week with a special event.
				--SELECT week,service FROM services_weekly where event is not null or lower(event) ='none';

--Main Question
		--Analyze the event impact by comparing weeks with events vs weeks without events
		--. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. 
		--Order by average patient satisfaction descending.

		SELECT 
		CASE
			WHEN event is not null and event <>'' AND lower(event)<>'none'
			THEN 'WITH EVENT '
			ELSE 'NO EVENT'
		END AS EVENT_STATUS,
		COUNT(week) as total_weeks , 
		ROUND(AVG(patient_satisfaction),2) as AVG_Satisfaction,
		ROUND(AVG(staff_morale),2) as Staff_morale
		FROM services_weekly
		GROUP BY EVENT_STATUS
		ORDER BY AVG_Satisfaction DESC;