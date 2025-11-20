							   -- Foundation & Inspection--
							   
		--Q1-List all unique pizza categories (DISTINCT).
		     SELECT DISTINCT category FROM pizza_types;
			 
		--Q2-Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
				SELECT pizza_type_id, name,
					CASE
					WHEN ingredients IS NULL THEN 'MISSING DATA '
					ELSE ingredients 
					END AS ingredients
				FROM pizza_types
				LIMIT 5;
		
		--q3-Check for pizzas missing a price (IS NULL).
			SELECT * FROM pizzas
			WHERE price is NULL;

									--Filtering & Exploration--

	  --Q1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
			 SELECT * FROM orders WHERE date='2015-01-01'
					
	  --Q2. List pizzas with `price` descending.
			SELECT *FROM pizzas 
			ORDER BY price DESC
		
	  --Q3. Pizzas sold in sizes `'L'` or `'XL'`.
			SELECT * FROM pizzas
			WHERE size IN('L','XL')
			ORDER BY price DESC
			
	  --Q4. Pizzas priced between $15.00 and $17.00.
	  		SELECT * FROM pizzas
			WHERE price BETWEEN 15.00 AND 17.00;
			
	  --Q5. Pizzas with `"Chicken"` in the name.
	  		SELECT * FROM pizza_types
			  WHERE category = 'Chicken'


			 			-- Sales Performance--

	  --Q1. Total quantity of pizzas sold (`SUM`).
	   		SELECT SUM(quantity) AS total_quantity FROM order_details
			   
	  --Q2. Average pizza price (`AVG`).
	  		SELECT ROUND(AVG(price),2) as AVG_pizza,size FROM pizzas GROUP BY size
			  
	  --Q3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
			SELECT od.order_id as order_details, ROUND(SUM(od.quantity*p.price),2) as total_order 
			FROM order_details od
			JOIN pizzas p
			ON p.pizza_id=od.pizza_id
			GROUP BY order_details
	  
	  --Q4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
	        SELECT SUM(od.quantity) AS total_quantity,pi.category as pizza_category FROM order_details od
			JOIN pizzas p
			ON od.pizza_id=p.pizza_id
			JOIN pizza_types pi
			ON pi.pizza_type_id= p.pizza_type_id
			GROUP BY pi.category
			
	  --Q5. Categories with more than 5,000 pizzas sold (`HAVING`).
		  SELECT pi.category,SUM(od.quantity) AS total_quantity_sold
		  FROM order_details od
		  JOIN pizzas p ON od.pizza_id = p.pizza_id
	      JOIN pizza_types pi ON pi.pizza_type_id = p.pizza_type_id
	      GROUP BY pi.category
	      HAVING SUM(od.quantity) > 5000;
		  
      --Q6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
		 SELECT p.* FROM pizzas p
	     LEFT JOIN order_details od
	     ON p.pizza_id = od.pizza_id
	     WHERE od.pizza_id IS NULL;
	  --Q7. Price differences between different sizes of the same pizza (`SELF JOIN`).
		SELECT  p1.pizza_type_id, p1.size as size_1, p2.size as size_2,
		p1.price as price_1,p2.price as price_2, (p2.price - p1.price) as difference
		FROM pizzas p1
		JOIN pizzas p2
		ON p1.pizza_type_id=p2.pizza_type_id
		AND p1.size <> p2.size
		ORDER BY  p1.pizza_type_id,p1.size;
	  