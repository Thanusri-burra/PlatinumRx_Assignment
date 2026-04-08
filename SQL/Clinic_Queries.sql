SELECT * FROM clinic_sales;


SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


SELECT 
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE strftime('%Y', cs.datetime) = '2021'
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


SELECT 
    revenue.month,
    revenue.total_revenue,
    expense.total_expense,
    (revenue.total_revenue - IFNULL(expense.total_expense, 0)) AS profit,
    CASE 
        WHEN (revenue.total_revenue - IFNULL(expense.total_expense, 0)) > 0 
        THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM (
    SELECT 
        strftime('%m', datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
) revenue
LEFT JOIN (
    SELECT 
        strftime('%m', datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
) expense
ON revenue.month = expense.month;


SELECT city, cid, profit
FROM (
    SELECT 
        cl.city,
        cs.cid,
        SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit,
        RANK() OVER (
            PARTITION BY cl.city 
            ORDER BY (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) DESC
        ) AS rnk
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    LEFT JOIN expenses e ON cs.cid = e.cid 
        AND strftime('%m', cs.datetime) = strftime('%m', e.datetime)
    WHERE strftime('%Y', cs.datetime) = '2021'
      AND strftime('%m', cs.datetime) = '09'   -- given month
    GROUP BY cl.city, cs.cid
)
WHERE rnk = 1;




SELECT state, cid, profit
FROM (
    SELECT 
        cl.state,
        cs.cid,
        SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit,
        RANK() OVER (
            PARTITION BY cl.state 
            ORDER BY (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) ASC
        ) AS rnk
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    LEFT JOIN expenses e ON cs.cid = e.cid 
        AND strftime('%m', cs.datetime) = strftime('%m', e.datetime)
    WHERE strftime('%Y', cs.datetime) = '2021'
      AND strftime('%m', cs.datetime) = '09'   -- given month
    GROUP BY cl.state, cs.cid
)
WHERE rnk = 2;