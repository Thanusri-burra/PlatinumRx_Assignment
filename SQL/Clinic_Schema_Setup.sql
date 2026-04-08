
DROP TABLE IF EXISTS clinics;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;

CREATE TABLE clinics (
    cid TEXT PRIMARY KEY,
    clinic_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);

CREATE TABLE customer (
    uid TEXT PRIMARY KEY,
    name TEXT,
    mobile TEXT
);

CREATE TABLE clinic_sales (
    oid TEXT PRIMARY KEY,
    uid TEXT,
    cid TEXT,
    amount REAL,
    datetime TIMESTAMP,
    sales_channel TEXT
);

CREATE TABLE expenses (
    eid TEXT PRIMARY KEY,
    cid TEXT,
    description TEXT,
    amount REAL,
    datetime TIMESTAMP
);

INSERT INTO clinics VALUES
('c1', 'XYZ Clinic', 'Hyderabad', 'Telangana', 'India'),
('c2', 'ABC Clinic', 'Vijayawada', 'Andhra Pradesh', 'India');

INSERT INTO customer VALUES
('u1', 'John', '9876543210'),
('u2', 'Alice', '9123456780');

INSERT INTO clinic_sales VALUES
('o1', 'u1', 'c1', 2000, '2021-09-23 12:00:00', 'online'),
('o2', 'u2', 'c2', 3000, '2021-09-25 14:00:00', 'offline');

INSERT INTO expenses VALUES
('e1', 'c1', 'Medicines', 500, '2021-09-23 10:00:00'),
('e2', 'c2', 'Equipment', 1000, '2021-09-25 11:00:00');