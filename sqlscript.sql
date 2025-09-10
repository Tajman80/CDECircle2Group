-- Accounts with the highest orders

SELECT a.name AS account_name, r.name AS region_name, o.total_amt_usd 
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
ORDER BY o.total_amt_usd desc
limit 5;

-- Top sales reps and their regions
SELECT r.name AS region_name, 
s.name AS sales_reps_name, 
sum(o.total_amt_usd) AS total_amount_spent 
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
GROUP BY r.name, s.name
order by total_amount_spent desc
limit 5;

-- Amount generated per web_event channels
SELECT channel, count(*) AS web_event_count, sum(o.total_amt_usd) AS total_amt
FROM web_events w
JOIN orders o
ON w.account_id = o.account_id
group by 1
order by 2 DESC

-- Accounts with the highest order amount from web events
SELECT
a.name AS account_name,
count(w.id) AS number_of_web_events,
SUM(o.total_amt_usd) AS total_order_amount
FROM accounts a
JOIN web_events w ON a.id = w.account_id 
JOIN orders o ON a.id = o.account_id 
GROUP BY a.name
ORDER BY total_order_amount DESC
limit 5;

-- Customer Buying Behaviour
SELECT a.name AS account_name,
s.name AS sales_rep_name,
SUM(o.total_amt_usd) AS total_revenue,
COUNT(o.id) AS total_numbers_of_order
FROM accounts a 
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN orders o ON a.id = o.account_id
group by a.name,s.name
order by total_numbers_of_order desc
limit 5; 

-- Average order_qty and average revenue generated per region
SELECT r.name AS region_name,
ROUND(AVG(o.total), 2) AS average_order_qty,
ROUND(AVG(o.total_amt_usd), 2) AS average_order_amount
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
GROUP BY r.name
ORDER BY average_order_amount DESC;

-- Top spending accounts
SELECT a.name AS account_name,
SUM(o.total_amt_usd) AS total_amount_spent
FROM accounts a
JOIN orders o ON a.id = o.account_id
WHERE o.total_amt_usd > 500
GROUP BY a.name
ORDER BY total_amount_spent DESC
LIMIT 5;

-- Amount made by sales rep and the paper type
SELECT 
    s.name AS sales_rep_name,
    SUM(o.standard_qty) AS total_standard_quantity,
	SUM(o.gloss_qty) AS total_gloss_qty,
	SUM(o.poster_qty) AS total_poster_qty,
	SUM(o.total_amt_usd) AS total_amount
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
WHERE o.standard_qty > 100
GROUP BY s.name
ORDER BY total_amount DESC;
