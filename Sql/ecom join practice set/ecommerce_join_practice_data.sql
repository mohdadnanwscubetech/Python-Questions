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



/* =========================================================
   EXTRA PRACTICE DATA
   Added for JOIN, LEFT/RIGHT ANTI JOIN and OUTER JOIN practice.
   Includes unmatched rows and NULL values.
   No solutions/queries are included.
   ========================================================= */

/* ---------------------------------------------------------
   EXTRA CUSTOMERS
   Some customers intentionally have no orders.
   Some optional columns intentionally contain NULL.
   --------------------------------------------------------- */

INSERT INTO customers
(customer_id, customer_name, email, phone, city, state, signup_date, age, status)
VALUES
(113, 'Ishita Rao', 'ishita.rao@gmail.com', '9876543222', 'Udaipur', 'Rajasthan', '2026-01-08', 23, 'Active'),
(114, 'Dev Patel', 'dev.patel@gmail.com', NULL, 'Surat', 'Gujarat', '2026-01-19', 34, 'Active'),
(115, 'Meera Nair', NULL, '9876543224', 'Kochi', 'Kerala', '2026-02-02', 29, 'Inactive'),
(116, 'Sahil Arora', 'sahil.arora@gmail.com', '9876543225', 'Amritsar', 'Punjab', '2026-02-17', 26, 'Active'),
(117, 'Kavya Iyer', 'kavya.iyer@gmail.com', NULL, 'Chennai', 'Tamil Nadu', '2026-03-09', 31, 'Active'),
(118, 'Yash Thakur', 'yash.thakur@gmail.com', '9876543227', 'Bhopal', 'Madhya Pradesh', '2026-03-21', 24, 'Inactive'),
(119, 'Riya Das', 'riya.das@gmail.com', '9876543228', 'Kolkata', 'West Bengal', '2026-04-04', 27, 'Active'),
(120, 'Manav Joshi', NULL, NULL, 'Jodhpur', 'Rajasthan', '2026-04-16', 36, 'Active'),
(121, 'Tanya Kapoor', 'tanya.kapoor@gmail.com', '9876543230', 'Noida', 'Uttar Pradesh', '2026-05-01', 22, 'Active'),
(122, 'Kabir Sethi', 'kabir.sethi@gmail.com', '9876543231', 'Gurugram', 'Haryana', '2026-05-14', 33, 'Inactive');

/* ---------------------------------------------------------
   EXTRA DEPARTMENTS
   These departments intentionally have no employees.
   --------------------------------------------------------- */

INSERT INTO departments (department_id, department_name)
VALUES
(6, 'Customer Support'),
(7, 'Research and Development'),
(8, 'Quality Assurance'),
(9, 'Logistics');

/* ---------------------------------------------------------
   EXTRA EMPLOYEES
   Some employees have NULL department_id and/or manager_id.
   These NULL foreign keys are intentional and valid.
   --------------------------------------------------------- */

INSERT INTO employees
(employee_id, employee_name, department_id, manager_id, salary, hire_date)
VALUES
(11, 'Arvind Rao', 1, 1, 62000, '2024-01-15'),
(12, 'Nisha Bansal', 2, 3, 72000, '2024-02-12'),
(13, 'Deepak Soni', 6, NULL, 42000, '2024-03-18'),
(14, 'Farah Sheikh', 6, 13, 39000, '2024-04-22'),
(15, 'Rajat Mishra', NULL, NULL, 45000, '2024-05-10'),
(16, 'Pallavi Desai', 7, NULL, 81000, '2024-06-05'),
(17, 'Mohit Batra', 8, NULL, 57000, '2024-07-19'),
(18, 'Snehal Patil', NULL, 17, 51000, '2024-08-11'),
(19, 'Akash Choudhary', 9, NULL, 46000, '2024-09-02'),
(20, 'Zoya Khan', 7, 16, 68000, '2024-10-14');

/* ---------------------------------------------------------
   EXTRA PRODUCTS
   Some products intentionally do not appear in order_items.
   --------------------------------------------------------- */

INSERT INTO products
(product_id, product_name, category, price, stock, supplier)
VALUES
(15, 'Wireless Earbuds', 'Electronics', 3200, 45, ' boAt'),
(16, 'Webcam', 'Electronics', 2800, 35, 'Logitech'),
(17, 'Gaming Controller', 'Electronics', 2100, 25, 'Sony'),
(18, 'Study Table Lamp', 'Furniture', 950, 60, 'Philips'),
(19, 'Ergonomic Footrest', 'Furniture', 1800, 22, 'Green Soul'),
(20, 'Sketch Book', 'Stationery', 180, 140, 'Classmate'),
(21, 'Sticky Notes', 'Stationery', 90, 250, '3M'),
(22, 'Laptop Sleeve', 'Accessories', 750, 80, 'DailyObjects'),
(23, 'Bluetooth Speaker', 'Electronics', 2600, 40, 'JBL'),
(24, 'Travel Mug', 'Accessories', 650, 100, 'Milton');

/* ---------------------------------------------------------
   EXTRA ORDERS
   All customer_id values refer to existing customers.
   employee_id is NULL for some orders intentionally.
   --------------------------------------------------------- */

INSERT INTO orders
(order_id, customer_id, employee_id, order_date, status)
VALUES
(1021, 101, 11, '2026-09-02', 'Delivered'),
(1022, 103, NULL, '2026-09-05', 'Pending'),
(1023, 105, 12, '2026-09-09', 'Delivered'),
(1024, 107, NULL, '2026-09-13', 'Processing'),
(1025, 109, 14, '2026-09-18', 'Cancelled'),
(1026, 111, 11, '2026-09-22', 'Delivered'),
(1027, 112, NULL, '2026-09-27', 'Pending'),
(1028, 102, 12, '2026-10-01', 'Delivered'),
(1029, 104, 14, '2026-10-06', 'Processing'),
(1030, 106, NULL, '2026-10-11', 'Pending'),
(1031, 108, 11, '2026-10-16', 'Delivered'),
(1032, 110, NULL, '2026-10-21', 'Cancelled');

/* ---------------------------------------------------------
   EXTRA ORDER ITEMS
   Product and order IDs are valid. Some orders intentionally
   have no order_items rows, creating unmatched orders.
   --------------------------------------------------------- */

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(35, 1021, 15, 1, 3200),
(36, 1021, 2, 2, 800),
(37, 1022, 16, 1, 2800),
(38, 1023, 18, 2, 950),
(39, 1023, 9, 10, 100),
(40, 1024, 19, 1, 1800),
(41, 1025, 20, 5, 180),
(42, 1026, 21, 3, 90),
(43, 1026, 13, 2, 500),
(44, 1028, 22, 1, 750),
(45, 1028, 3, 1, 1500),
(46, 1029, 23, 1, 2600),
(47, 1031, 24, 2, 650);

/* ---------------------------------------------------------
   EXTRA PAYMENTS
   Some orders intentionally have no payment row.
   payment_date, payment_method and payment_status include NULLs.
   --------------------------------------------------------- */

INSERT INTO payments
(payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES
(21, 1021, '2026-09-02', 4800, 'UPI', 'Paid'),
(22, 1022, NULL, 2800, 'Credit Card', 'Pending'),
(23, 1023, '2026-09-09', 2900, 'Net Banking', 'Paid'),
(24, 1025, '2026-09-18', 900, NULL, 'Refunded'),
(25, 1026, '2026-09-22', 1090, 'UPI', 'Paid'),
(26, 1028, NULL, 2250, NULL, 'Pending'),
(27, 1030, '2026-10-11', 0, 'Cash', 'Failed'),
(28, 1031, '2026-10-16', 1300, 'Debit Card', 'Paid');

/* ---------------------------------------------------------
   OPTIONAL NULL VALUES IN EXISTING ROWS
   These updates create more realistic NULL handling practice.
   --------------------------------------------------------- */

UPDATE products
SET supplier = NULL
WHERE product_id IN (16, 20);

UPDATE orders
SET employee_id = NULL
WHERE order_id IN (1003, 1014);

UPDATE payments
SET payment_method = NULL
WHERE payment_id IN (3, 14);

/* =========================================================
   END OF EXTRA PRACTICE DATA
   ========================================================= */
