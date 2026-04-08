SELECT * FROM users;
SELECT user_id, room_no
FROM bookings
WHERE (user_id, booking_date) IN (
    SELECT user_id, MAX(booking_date)
    FROM bookings
    GROUP BY user_id
);

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', b.booking_date) = '11'
  AND strftime('%Y', b.booking_date) = '2021'
GROUP BY b.booking_id;

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '10'
  AND strftime('%Y', bc.bill_date) = '2021'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;


SELECT month, item_id, total_quantity
FROM (
    SELECT 
        strftime('%m', bill_date) AS month,
        item_id,
        SUM(item_quantity) AS total_quantity,
        RANK() OVER (PARTITION BY strftime('%m', bill_date) ORDER BY SUM(item_quantity) DESC) AS rnk_desc,
        RANK() OVER (PARTITION BY strftime('%m', bill_date) ORDER BY SUM(item_quantity) ASC) AS rnk_asc
    FROM booking_commercials
    WHERE strftime('%Y', bill_date) = '2021'
    GROUP BY month, item_id
)
WHERE rnk_desc = 1 OR rnk_asc = 1;

SELECT month, bill_id, total_amount
FROM (
    SELECT 
        strftime('%m', bc.bill_date) AS month,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS total_amount,
        RANK() OVER (
            PARTITION BY strftime('%m', bc.bill_date)
            ORDER BY SUM(bc.item_quantity * i.item_rate) DESC
        ) AS rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY month, bc.bill_id
)
WHERE rnk = 2;