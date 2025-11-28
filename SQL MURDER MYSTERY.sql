--Q1) Who entered the **CEO’s Office** close to the time of the murder?
--Identify where and when the crime happenedWHERE, filtering
SELECT 
    k.employee_id,
    e.name,
    k.room,
    k.entry_time,
    k.exit_time
FROM keycard_logs k
JOIN employees e 
    ON k.employee_id = e.employee_id
WHERE k.room = 'CEO Office'
  AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05';

--Q2) Who **claimed** to be somewhere else but was not?
--Analyze who accessed critical areas at the time JOIN, BETWEEN

	SELECT a.employee_id,e.name,a.claimed_location,a.claim_time,k.room AS actual_room,k.entry_time,k.exit_time FROM alibis a
	JOIN employees e ON a.employee_id = e.employee_id LEFT JOIN keycard_logs k  ON a.employee_id = k.employee_id
    AND a.claim_time BETWEEN k.entry_time AND k.exit_time
    WHERE k.room IS NULL;

--Q3) Who made or received calls around **20:50–21:00**?
--Cross-check alibis with actual logs JOIN, subqueries
	SELECT e.name,a.claimed_location,a.claim_time,c.call_id,c.call_time
	FROM alibis a JOIN employees e ON a.employee_id = e.employee_id
	JOIN calls c ON a.employee_id IN (c.caller_id, c.receiver_id)
	AND c.call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00';

--Q4) What evidence was found at the **crime scene**?
--Investigate suspicious calls made around the time	JOIN, filtering
SELECT 
    c.call_id,
    c.call_time,
    e1.name AS caller_name,
    e2.name AS receiver_name
FROM calls c -- joins first table
JOIN employees e1 ON c.caller_id = e1.employee_id -- match with caller_id in calls table 
JOIN employees e2 ON c.receiver_id = e2.employee_id-- matching second time employee_id with receiver  bOTH employees same table but diff matching(Created two tables)
WHERE c.call_time BETWEEN '2025-10-15 20:30' AND '2025-10-15 21:00'; 

--Q5Which suspect’s movements, alibi, and call activity **don’t add up**?
SELECT 
    e.employee_id,
    e.name,
    k.room AS actual_room,
    k.entry_time,
    k.exit_time,
    a.claimed_location,
    a.claim_time,
    ev.description AS evidence_found
FROM employees e
JOIN keycard_logs k ON e.employee_id = k.employee_id
LEFT JOIN alibis a ON e.employee_id = a.employee_id
LEFT JOIN evidence ev ON k.room = ev.room
WHERE k.room = 'CEO Office';   -- crime scene
(
    SELECT employee_id
    FROM keycard_logs
    WHERE room = 'CEO Office'
      AND entry_time <= '2025-10-15 21:00'
      AND exit_time >= '2025-10-15 20:50'
)
INTERSECT -- matching like intersection 
(
    SELECT caller_id AS employee_id
    FROM calls
    WHERE call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00'
    UNION
    SELECT receiver_id
    FROM calls
    WHERE call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00'
)
INTERSECT
(
    SELECT a.employee_id
    FROM alibis a
    JOIN keycard_logs k
      ON a.employee_id = k.employee_id
     AND a.claim_time BETWEEN k.entry_time AND k.exit_time
    WHERE a.claimed_location <> k.room
);
