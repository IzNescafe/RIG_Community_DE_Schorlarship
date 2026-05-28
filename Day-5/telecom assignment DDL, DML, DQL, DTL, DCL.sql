create database telecom_db;

use telecom_db;

CREATE TABLE subscribers (
 subscriber_id INT AUTO_INCREMENT PRIMARY KEY,
 subscriber_name VARCHAR(100) NOT NULL,
 phone_number VARCHAR(20) UNIQUE,
 city VARCHAR(50),
 registration_date DATE
);

CREATE TABLE plans (
 plan_id INT AUTO_INCREMENT PRIMARY KEY,
 plan_name VARCHAR(100),
 monthly_fee DECIMAL(10,2),
 data_limit INT
);

CREATE TABLE usage_records (
 usage_id INT AUTO_INCREMENT PRIMARY KEY,
 subscriber_id INT,
 data_used DECIMAL(10,2),
 call_minutes INT,
 usage_date DATE,
 FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id)
);

ALTER TABLE subscribers ADD email VARCHAR(100);

ALTER TABLE subscribers
MODIFY city VARCHAR(100);

ALTER TABLE subscribers
DROP COLUMN email;

INSERT INTO subscribers (subscriber_name, phone_number, city, registration_date)
VALUES
('Aung Aung', '0912345678', 'Yangon', '2025-01-01'),
('Su Su', '0923456789', 'Mandalay', '2025-02-01'),
('Kyaw Kyaw', '0934567890', 'Yangon', '2025-03-01');

INSERT INTO plans (plan_name, monthly_fee, data_limit)
VALUES
('Basic', 10, 5),
('Standard', 20, 10),
('Premium', 30, 20);

INSERT INTO usage_records (subscriber_id, data_used, call_minutes, usage_date)
VALUES
(1, 2.5, 30, '2025-04-01'),
(1, 1.0, 10, '2025-04-02'),
(2, 5.0, 60, '2025-04-01'),
(3, 8.0, 90, '2025-04-03');

UPDATE usage_records
SET data_used = data_used + 1
WHERE subscriber_id = 1;

DELETE FROM subscribers
WHERE subscriber_id = 3;

SELECT * FROM subscribers;

SELECT * FROM subscribers
WHERE city = 'Yangon';

SELECT subscriber_id, SUM(data_used) AS total_data
FROM usage_records
GROUP BY subscriber_id;

SELECT subscriber_id, SUM(data_used) AS total_data
FROM usage_records
GROUP BY subscriber_id
HAVING SUM(data_used) > 5;

SELECT * FROM subscribers
ORDER BY registration_date DESC;

SELECT s.subscriber_name, u.data_used, u.call_minutes
FROM subscribers s
JOIN usage_records u
ON s.subscriber_id = u.subscriber_id;

START TRANSACTION;
UPDATE usage_records
SET data_used = data_used + 10
WHERE subscriber_id = 2;
ROLLBACK;

START TRANSACTION;
UPDATE usage_records
SET data_used = data_used + 2
WHERE subscriber_id = 2;
COMMIT;

START TRANSACTION;
UPDATE usage_records SET data_used = data_used + 1 WHERE subscriber_id=1;
SAVEPOINT sp1;
UPDATE usage_records SET data_used = data_used + 5 WHERE subscriber_id=1;
ROLLBACK TO sp1;
COMMIT;

CREATE USER 'telecom_user'@'localhost' IDENTIFIED BY 'password123';

GRANT SELECT ON telecom_db.* TO 'telecom_user'@'localhost';

GRANT INSERT, UPDATE ON telecom_db.usage_records
TO 'telecom_user'@'localhost';

REVOKE UPDATE ON telecom_db.usage_records
FROM 'telecom_user'@'localhost';

SHOW GRANTS FOR 'telecom_user'@'localhost';

DROP USER 'telecom_user'@'localhost';