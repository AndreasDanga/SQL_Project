SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM flights_part fp 
LEFT JOIN airports_part ap 
		ON fp.origin = ap.faa; 
		
	
--- RIGHT JOIN
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM flights_part fp -- LEFT table
RIGHT JOIN airports_part ap -- RIGHT table
		ON fp.origin = ap.faa; 
		
--- another right join 
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM airports_part ap   -- LEFT table
RIGHT JOIN flights_part fp -- RIGHT TABLE 
		ON fp.origin = ap.faa; 
		
-- Inner Join 
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM airports_part ap   -- LEFT table
INNER JOIN flights_part fp -- RIGHT TABLE 
		ON fp.origin = ap.faa; 

	
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM  flights_part fp  -- LEFT table
INNER JOIN airports_part ap -- RIGHT TABLE 
		ON fp.origin = ap.faa; 
	
-- FULL JOIN 
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM  flights_part fp  -- LEFT table
FULL JOIN airports_part ap -- RIGHT TABLE 
		ON fp.origin = ap.faa; 
		
-- RIGHT OUTER JOIN returning only values in the right table
SELECT ap.faa,
		fp.origin,
		fp.flight_date,
		ap.name 
FROM airports_part ap   -- LEFT table
RIGHT JOIN flights_part fp -- RIGHT TABLE 
		ON fp.origin = ap.faa
WHERE ap IS NULL; 

SELECT ap.faa,  --3rd
		fp.origin,
		fp.flight_date,
		ap.name 
FROM flights_part fp -- LEFT TABLE   -- 1st
RIGHT JOIN airports_part ap   -- RIGHT TABLE  --1st  
		ON fp.origin = ap.faa
WHERE fp IS NULL; --2nd

--- CROSS JOIN 
-- cartasian product 

SELECT fp.origin,
		fp.flight_date,
		ap.faa,
		ap.name
FROM flights_part fp 
CROSS JOIN airports_part ap


-- SELF JOIN
--  we join the airports table to itself to match all airports that are located wit in the same city
SELECT a1.name AS airports1,
		a2.name AS airports2,
		a1.city
FROM airports a1, airports a2 
WHERE a1.city = a2.city 
	AND a1.faa<> a2.faa  --FILTER OUT SELF MATCH 
ORDER BY a1.name;

-- UNION 
SELECT faa,
		name, 
		city
FROM airports 
WHERE city = 'Hamburg'
UNION 
SELECT faa,
		name, 
		city
FROM airports_part  
WHERE faa = 'GRK'

-- UNION ALL???
SELECT  flight_date,
		dep_time,
		tail_number,
		origin
FROM flights 
WHERE flight_date = '2021-01-31'
UNION ALL
SELECT  flight_date,
		dep_time,
		tail_number,
		origin
FROM flights 
WHERE flight_date = '2021-01-31'


-- INTERSECT 
SELECT faa,
		name, 
		city
FROM airports 
WHERE city IN ('Hamburg', 'Berlin')
INTERSECT 
SELECT faa,
		name, 
		city
FROM airports
WHERE city = 'Hamburg'

-- EXCEPT 
SELECT faa,
		name, 
		city
FROM airports 
WHERE city IN ('Hamburg', 'Berlin')
EXCEPT 
SELECT faa,
		name, 
		city
FROM airports
WHERE city = 'Hamburg'


-- SUBqueries
-- both origin and destination have alt > 100 
-- and not located in uSA
-- return origin and destination 
SELECT  origin,
		dest
FROM flights f 
WHERE f.origin IN (SELECT faa 
							FROM airports 
							WHERE alt > 100
							AND country <> 'Mexico')	
AND f.dest IN (SELECT faa 
							FROM airports 
							WHERE alt > 100
							AND country <> 'Mexico')	
ORDER BY origin;
							

SELECT faa,
		country
FROM airports 
WHERE alt > 100
AND country <> 'United States'


-- ORDER OF EXECUTION
SELECT -- 5 
FROM  -- 1
JOIN  -- 1
WHERE -- 2 
GROUP BY -- 3
HAVING -- 4
ORDER BY -- 6
LIMIT -- 7 

-- CONDITIONAL EXPRESSIONS
SELECT flight_date,
		CASE WHEN dep_delay < 0 THEN 'Early'
			WHEN dep_delay = 0 THEN 'On Time'
			ELSE 'Delayed'
		END AS dep_punctuality,
		COUNT(*) AS total_flights
FROM flights 
WHERE flight_date = '2021-01-26'
GROUP BY 1,2
ORDER BY 3 DESC;

-- COALSESCE 
-- dep time has a lot of null values 
SELECT flight_date,
		origin,
		dest,
		dep_time,
		sched_dep_time,
		COALESCE(dep_time, sched_dep_time) AS dep_time_clean
FROM flights 
WHERE dep_time IS NULL;

-- CAST     ::TYPE
-- i want to transform data type of the flight_date into date 
SELECT DISTINCT  (CAST(flight_date AS DATE))
FROM flights
ORDER BY 1;