CREATE DATABASE ecommerce_view_demo;
USE ecommerce_view_demo;

CREATE TABLE customers (
 customer_id INT PRIMARY KEY AUTO_INCREMENT,
 customer_name VARCHAR(100),
 email VARCHAR(100),
 city VARCHAR(100)
);

CREATE TABLE products (
 product_id INT PRIMARY KEY AUTO_INCREMENT,
 product_name VARCHAR(100),
 category VARCHAR(50),
 price DECIMAL(10,2)
);
CREATE TABLE orders (
 order_id INT PRIMARY KEY AUTO_INCREMENT,
 customer_id INT,
 order_date DATE,
 status VARCHAR(50),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
 order_item_id INT PRIMARY KEY AUTO_INCREMENT,
 order_id INT,
 product_id INT,
 quantity INT,
 FOREIGN KEY (order_id) REFERENCES orders(order_id),
 FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name, email, city) VALUES
('Aung Aung', 'aung@gmail.com', 'Yangon'),
('Su Su', 'susu@gmail.com', 'Mandalay'),
('Kyaw Kyaw', 'kyaw@gmail.com', 'Yangon');
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1500000),
('Phone', 'Electronics', 800000),
('Shoes', 'Fashion', 120000);
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-01-10', 'Completed'),
(2, '2024-01-11', 'Pending'),
(1, '2024-01-12', 'Completed');
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 2, 1);

CREATE VIEW customer_basic_info_view AS
SELECT
    customer_id,
    customer_name,
    city
FROM customers;

SELECT * FROM customer_basic_info_view;

CREATE VIEW completed_orders_view AS
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status = 'Completed';

SELECT * FROM completed_orders_view;

CREATE VIEW order_details_view AS
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity,
    p.price * oi.quantity AS line_total
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;

SELECT * FROM order_details_view;


CREATE VIEW order_total_sales_view AS
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_sales
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    o.order_id,
    o.order_date,
    o.status,
    c.customer_name;

SELECT * FROM order_total_sales_view;

CREATE VIEW high_value_orders_view AS
SELECT
    order_id,
    order_date,
    status,
    customer_name,
    total_sales
FROM order_total_sales_view
WHERE total_sales > 1000000;

SELECT * FROM high_value_orders_view;

CREATE VIEW completed_orders_check_view AS
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status = 'Completed'
WITH CHECK OPTION;

SELECT * FROM completed_orders_check_view;

UPDATE customer_basic_info_view
SET city = 'Naypyitaw'
WHERE customer_id = 3;

SELECT * FROM customer_basic_info_view;

DELIMITER //
CREATE PROCEDURE try_invalid_completed_order_update()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'Invalid update failed as expected' AS result;

    UPDATE completed_orders_check_view
    SET status = 'Pending'
    WHERE order_id = 1;
END//
DELIMITER ;

CALL try_invalid_completed_order_update();

SELECT * FROM completed_orders_check_view;

CREATE VIEW customer_purchase_summary_view AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) AS completed_orders,
    COALESCE(SUM(CASE WHEN o.status = 'Completed' THEN p.price * oi.quantity ELSE 0 END), 0) AS total_purchase_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city;

SELECT * FROM customer_purchase_summary_view;

CREATE ALGORITHM = TEMPTABLE VIEW category_sales_temptable_view AS
SELECT
    p.category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity,
    SUM(p.price * oi.quantity) AS total_sales
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
GROUP BY
    p.category;

SELECT * FROM category_sales_temptable_view;

CREATE VIEW product_security_view AS
SELECT
    product_id,
    product_name,
    category
FROM products;

SELECT * FROM product_security_view;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SHOW CREATE VIEW customer_purchase_summary_view;

DROP VIEW product_security_view;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

CREATE VIEW pending_orders_view AS
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status = 'Pending';

SELECT * FROM pending_orders_view;

CREATE VIEW top_3_expensive_products_view AS
SELECT
    product_id,
    product_name,
    category,
    price
FROM products
ORDER BY price DESC
LIMIT 3;

SELECT * FROM top_3_expensive_products_view;

CREATE VIEW customer_orders_by_city_view AS
SELECT
    c.city,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.city;

SELECT * FROM customer_orders_by_city_view;

CREATE VIEW monthly_sales_report_view AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * oi.quantity) AS total_sales
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY
    DATE_FORMAT(o.order_date, '%Y-%m');

SELECT * FROM monthly_sales_report_view;

CREATE VIEW products_not_ordered_view AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT * FROM products_not_ordered_view;