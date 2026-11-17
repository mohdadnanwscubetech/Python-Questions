/* =========================================================
   E-COMMERCE SQL PRACTICE DATABASE
   MySQL
   ========================================================= */


/* ---------------------------------------------------------
   STEP 1: DATABASE
   --------------------------------------------------------- */

DROP DATABASE IF EXISTS ecommerce_db;

CREATE DATABASE ecommerce_db;

USE ecommerce_db;


/* ---------------------------------------------------------
   STEP 2: CUSTOMERS TABLE
   --------------------------------------------------------- */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE,
    age INT CHECK (age >= 18),
    status VARCHAR(20) DEFAULT 'Active'
);


/* ---------------------------------------------------------
   STEP 3: DEPARTMENTS TABLE
   --------------------------------------------------------- */

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);


/* ---------------------------------------------------------
   STEP 4: EMPLOYEES TABLE
   --------------------------------------------------------- */

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);


/* ---------------------------------------------------------
   STEP 5: PRODUCTS TABLE
   --------------------------------------------------------- */

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT DEFAULT 0,
    supplier VARCHAR(100)
);


/* ---------------------------------------------------------
   STEP 6: ORDERS TABLE
   --------------------------------------------------------- */

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);


/* ---------------------------------------------------------
   STEP 7: ORDER ITEMS TABLE
   --------------------------------------------------------- */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    unit_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


/* ---------------------------------------------------------
   STEP 8: PAYMENTS TABLE
   --------------------------------------------------------- */

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


/* =========================================================
   INSERT DATA
   ========================================================= */


/* ---------------------------------------------------------
   CUSTOMERS
   --------------------------------------------------------- */

INSERT INTO customers
(customer_id, customer_name, email, phone, city, state, signup_date, age, status)
VALUES

(101, 'Rahul Sharma', 'rahul@gmail.com', '9876543210',
 'Delhi', 'Delhi', '2025-01-15', 25, 'Active'),

(102, 'Priya Singh', 'priya@gmail.com', '9876543211',
 'Jaipur', 'Rajasthan', '2025-02-10', 30, 'Active'),

(103, 'Aman Khan', 'aman@gmail.com', '9876543212',
 'Mumbai', 'Maharashtra', '2025-03-05', 22, 'Active'),

(104, 'Neha Verma', 'neha@gmail.com', '9876543213',
 'Pune', 'Maharashtra', '2025-04-20', 28, 'Active'),

(105, 'Rohit Gupta', 'rohit@gmail.com', '9876543214',
 'Delhi', 'Delhi', '2025-05-12', 35, 'Active'),

(106, 'Simran Kaur', 'simran@gmail.com', '9876543215',
 'Jaipur', 'Rajasthan', '2025-06-18', 26, 'Active'),

(107, 'Karan Mehta', 'karan@gmail.com', '9876543216',
 'Mumbai', 'Maharashtra', '2025-07-22', 40, 'Active'),

(108, 'Anjali Sharma', 'anjali@gmail.com', '9876543217',
 'Delhi', 'Delhi', '2025-08-11', 24, 'Active'),

(109, 'Vikas Yadav', 'vikas@gmail.com', '9876543218',
 'Lucknow', 'Uttar Pradesh', '2025-09-15', 32, 'Inactive'),

(110, 'Pooja Patel', 'pooja@gmail.com', '9876543219',
 'Ahmedabad', 'Gujarat', '2025-10-01', 29, 'Active'),

(111, 'Arjun Malhotra', 'arjun@gmail.com', '9876543220',
 'Chandigarh', 'Punjab', '2025-11-10', 27, 'Active'),

(112, 'Sneha Joshi', 'sneha@gmail.com', '9876543221',
 'Indore', 'Madhya Pradesh', '2025-12-05', 31, 'Active');


/* ---------------------------------------------------------
   DEPARTMENTS
   --------------------------------------------------------- */

INSERT INTO departments
(department_id, department_name)
VALUES

(1, 'Sales'),
(2, 'IT'),
(3, 'HR'),
(4, 'Finance'),
(5, 'Marketing');


/* ---------------------------------------------------------
   EMPLOYEES
   --------------------------------------------------------- */

INSERT INTO employees
(employee_id, employee_name, department_id, manager_id, salary, hire_date)
VALUES

(1, 'Amit Sharma', 1, NULL, 90000, '2020-01-10'),
(2, 'Rahul Verma', 1, 1, 60000, '2021-03-15'),
(3, 'Priya Kapoor', 2, NULL, 95000, '2019-06-20'),
(4, 'Neha Singh', 2, 3, 70000, '2022-01-12'),
(5, 'Ravi Kumar', 3, NULL, 65000, '2021-07-18'),
(6, 'Anjali Mehta', 3, 5, 48000, '2023-02-10'),
(7, 'Karan Gupta', 4, NULL, 85000, '2020-09-05'),
(8, 'Pooja Sharma', 4, 7, 55000, '2022-08-15'),
(9, 'Vikas Jain', 5, NULL, 75000, '2021-11-01'),
(10, 'Simran Kaur', 5, 9, 50000, '2023-04-20');


/* ---------------------------------------------------------
   PRODUCTS
   --------------------------------------------------------- */

INSERT INTO products
(product_id, product_name, category, price, stock, supplier)
VALUES

(1, 'Laptop', 'Electronics', 55000, 20, 'Dell'),
(2, 'Mouse', 'Electronics', 800, 100, 'Logitech'),
(3, 'Keyboard', 'Electronics', 1500, 80, 'HP'),
(4, 'Headphones', 'Electronics', 2500, 60, 'Sony'),
(5, 'Monitor', 'Electronics', 15000, 30, 'Samsung'),

(6, 'Office Chair', 'Furniture', 7000, 40, 'Godrej'),
(7, 'Office Desk', 'Furniture', 12000, 25, 'Ikea'),
(8, 'Bookshelf', 'Furniture', 6000, 15, 'Woodland'),

(9, 'Notebook', 'Stationery', 100, 200, 'Classmate'),
(10, 'Pen Pack', 'Stationery', 150, 300, 'Cello'),
(11, 'Marker Set', 'Stationery', 250, 150, 'Camlin'),

(12, 'Backpack', 'Accessories', 1800, 70, 'American Tourister'),
(13, 'USB Cable', 'Accessories', 500, 120, 'Boat'),
(14, 'Power Bank', 'Accessories', 2200, 50, 'Mi');


/* ---------------------------------------------------------
   ORDERS
   --------------------------------------------------------- */

INSERT INTO orders
(order_id, customer_id, employee_id, order_date, status)
VALUES

(1001, 101, 2, '2026-01-05', 'Delivered'),
(1002, 102, 2, '2026-01-10', 'Delivered'),
(1003, 103, 4, '2026-01-15', 'Pending'),
(1004, 101, 1, '2026-02-05', 'Delivered'),
(1005, 104, 2, '2026-02-12', 'Cancelled'),
(1006, 105, 1, '2026-02-20', 'Delivered'),
(1007, 106, 2, '2026-03-03', 'Delivered'),
(1008, 107, 4, '2026-03-15', 'Pending'),
(1009, 108, 1, '2026-03-25', 'Delivered'),
(1010, 109, 2, '2026-04-02', 'Cancelled'),
(1011, 110, 4, '2026-04-10', 'Delivered'),
(1012, 101, 1, '2026-04-18', 'Delivered'),
(1013, 111, 2, '2026-05-05', 'Delivered'),
(1014, 112, 4, '2026-05-20', 'Pending'),
(1015, 105, 1, '2026-06-01', 'Delivered'),
(1016, 102, 2, '2026-06-15', 'Delivered'),
(1017, 103, 4, '2026-07-05', 'Delivered'),
(1018, 107, 1, '2026-07-20', 'Delivered'),
(1019, 108, 2, '2026-08-10', 'Pending'),
(1020, 110, 4, '2026-08-25', 'Delivered');


/* ---------------------------------------------------------
   ORDER ITEMS
   --------------------------------------------------------- */

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES

(1, 1001, 1, 1, 55000),
(2, 1001, 2, 2, 800),

(3, 1002, 6, 1, 7000),
(4, 1002, 9, 5, 100),

(5, 1003, 4, 2, 2500),

(6, 1004, 7, 1, 12000),
(7, 1004, 3, 2, 1500),

(8, 1005, 5, 1, 15000),

(9, 1006, 1, 1, 55000),
(10, 1006, 4, 1, 2500),

(11, 1007, 12, 2, 1800),
(12, 1007, 13, 2, 500),

(13, 1008, 5, 2, 15000),

(14, 1009, 6, 2, 7000),
(15, 1009, 10, 5, 150),

(16, 1010, 7, 1, 12000),

(17, 1011, 1, 1, 55000),

(18, 1012, 5, 1, 15000),
(19, 1012, 14, 1, 2200),

(20, 1013, 4, 2, 2500),
(21, 1013, 11, 2, 250),

(22, 1014, 8, 1, 6000),

(23, 1015, 1, 1, 55000),
(24, 1015, 2, 1, 800),

(25, 1016, 7, 1, 12000),
(26, 1016, 9, 10, 100),

(27, 1017, 3, 3, 1500),
(28, 1017, 13, 2, 500),

(29, 1018, 5, 1, 15000),
(30, 1018, 6, 1, 7000),

(31, 1019, 12, 1, 1800),
(32, 1019, 14, 1, 2200),

(33, 1020, 1, 1, 55000),
(34, 1020, 4, 2, 2500);


/* ---------------------------------------------------------
   PAYMENTS
   --------------------------------------------------------- */

INSERT INTO payments
(payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES

(1, 1001, '2026-01-05', 56600, 'Credit Card', 'Paid'),
(2, 1002, '2026-01-10', 7500, 'UPI', 'Paid'),
(3, 1003, '2026-01-15', 5000, 'Debit Card', 'Pending'),
(4, 1004, '2026-02-05', 15000, 'UPI', 'Paid'),
(5, 1005, '2026-02-12', 15000, 'Credit Card', 'Refunded'),
(6, 1006, '2026-02-20', 57500, 'Net Banking', 'Paid'),
(7, 1007, '2026-03-03', 4600, 'UPI', 'Paid'),
(8, 1008, '2026-03-15', 30000, 'Credit Card', 'Pending'),
(9, 1009, '2026-03-25', 14750, 'UPI', 'Paid'),
(10, 1010, '2026-04-02', 12000, 'Debit Card', 'Refunded'),
(11, 1011, '2026-04-10', 55000, 'Credit Card', 'Paid'),
(12, 1012, '2026-04-18', 17200, 'UPI', 'Paid'),
(13, 1013, '2026-05-05', 5500, 'UPI', 'Paid'),
(14, 1014, '2026-05-20', 6000, 'Cash', 'Pending'),
(15, 1015, '2026-06-01', 55800, 'Credit Card', 'Paid'),
(16, 1016, '2026-06-15', 13000, 'UPI', 'Paid'),
(17, 1017, '2026-07-05', 5500, 'Debit Card', 'Paid'),
(18, 1018, '2026-07-20', 22000, 'Credit Card', 'Paid'),
(19, 1019, '2026-08-10', 4000, 'UPI', 'Pending'),
(20, 1020, '2026-08-25', 60000, 'Net Banking', 'Paid');


/* =========================================================
   FINAL CHECK
   ========================================================= */

SHOW TABLES;

SELECT * FROM customers;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payments;