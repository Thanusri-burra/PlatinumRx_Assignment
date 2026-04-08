CREATE TABLE users (
    user_id TEXT PRIMARY KEY,
    name TEXT,
    phone_number TEXT,
    mail_id TEXT,
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id TEXT PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no TEXT,
    user_id TEXT
);

CREATE TABLE booking_commercials (
    id TEXT PRIMARY KEY,
    booking_id TEXT,
    bill_id TEXT,
    bill_date TIMESTAMP,
    item_id TEXT,
    item_quantity REAL
);

CREATE TABLE items (
    item_id TEXT PRIMARY KEY,
    item_name TEXT,
    item_rate REAL
);


INSERT INTO users VALUES
('u1', 'John', '9876543210', 'john@gmail.com', 'Hyderabad'),
('u2', 'Alice', '9123456780', 'alice@gmail.com', 'Vijayawada');

INSERT INTO bookings VALUES
('b1', '2021-11-10 10:00:00', '101', 'u1'),
('b2', '2021-10-15 12:00:00', '102', 'u2');

INSERT INTO items VALUES
('i1', 'Paratha', 20),
('i2', 'Veg Curry', 80);

INSERT INTO booking_commercials VALUES
('c1', 'b1', 'bill1', '2021-11-10 12:00:00', 'i1', 3),
('c2', 'b2', 'bill2', '2021-10-15 13:00:00', 'i2', 5);

