CREATE DATABASE telecom_user_mgmt;
USE telecom_user_mgmt;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(100),
    module_name VARCHAR(100)
);

CREATE TABLE user_roles (
    user_role_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    role_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE role_permissions (
    role_permission_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT,
    permission_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action_tracking VARCHAR(255),
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username, email, department) VALUES
('Nes', 'alice@telecom.com', 'IT'),
('Ei', 'bob@telecom.com', 'Billing'),
('Tommey', 'charlie@telecom.com', 'Customer Support'),
('Chit', 'david@telecom.com', 'Network Operations'),
('Pa', 'eve@telecom.com', 'Management');

INSERT INTO roles (role_name, description) VALUES
('Admin', 'Full system access'),
('Billing Officer', 'Handles billing records'),
('Support Agent', 'Customer support access'),
('Network Engineer', 'Network management'),
('Viewer', 'Read-only access');

INSERT INTO permissions (permission_name, module_name) VALUES
('Create User', 'User Management'),
('Update Billing', 'Billing'),
('View Network', 'Network'),
('Generate Reports', 'Reports'),
('Delete User', 'User Management');

INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO role_permissions (role_id, permission_id) VALUES
(1, 1),
(1, 5),
(2, 2),
(3, 4),
(4, 3),
(5, 4);

UPDATE users
SET status = 'INACTIVE'
WHERE user_id = 3;

DELETE FROM permissions
WHERE permission_id = 5;

SELECT * FROM users;

SELECT *
FROM users
WHERE status = 'ACTIVE';

SELECT u.username, u.department, r.role_name
FROM users u
JOIN user_roles ur ON u.user_id = ur.user_id
JOIN roles r ON ur.role_id = r.role_id;

SELECT department, COUNT(*) AS total_users
FROM users
GROUP BY department;

SELECT *
FROM users
WHERE department = 'Billing';

SELECT r.role_name, p.permission_name, p.module_name
FROM roles r
JOIN role_permissions rp ON r.role_id = rp.role_id
JOIN permissions p ON rp.permission_id = p.permission_id;

SELECT *
FROM users
ORDER BY username ASC;

SELECT COUNT(*) AS total_users
FROM users;

START TRANSACTION;
INSERT INTO audit_logs (user_id, action_tracking)
VALUES (1, 'User logged in');
COMMIT;

START TRANSACTION;
UPDATE users
SET status = 'ACTIVE'
WHERE user_id = 3;
ROLLBACK;
SELECT user_id, username, status
FROM users
WHERE user_id = 3;

START TRANSACTION;
UPDATE users SET department = 'Operations' WHERE user_id = 4;
SAVEPOINT sp1;
UPDATE users SET department = 'Executive' WHERE user_id = 5;
ROLLBACK TO sp1;
COMMIT;

START TRANSACTION;
INSERT INTO audit_logs (user_id, action_tracking)
VALUES (2, 'Billing updated');
ROLLBACK;

START TRANSACTION;
INSERT INTO audit_logs (user_id, action_tracking)
VALUES (2, 'Billing updated');
COMMIT;

CREATE USER 'billing_user'@'localhost' IDENTIFIED BY 'Billing123!';

GRANT SELECT, UPDATE ON telecom_user_mgmt.users TO 'billing_user'@'localhost';

GRANT INSERT ON telecom_user_mgmt.audit_logs TO 'billing_user'@'localhost';

SHOW GRANTS FOR 'billing_user'@'localhost';

REVOKE UPDATE ON telecom_user_mgmt.users FROM 'billing_user'@'localhost';

CREATE USER 'viewer_user'@'localhost' IDENTIFIED BY 'Viewer123!';
GRANT SELECT ON telecom_user_mgmt.* TO 'viewer_user'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON telecom_user_mgmt.users TO 'billing_user'@'localhost';

GRANT SELECT, UPDATE ON telecom_user_mgmt.users TO 'billing_user'@'localhost';

GRANT SELECT ON telecom_user_mgmt.* TO 'viewer_user'@'localhost';

SELECT u.username, r.role_name, p.permission_name, p.module_name
FROM users u
JOIN user_roles ur ON u.user_id = ur.user_id
JOIN roles r ON ur.role_id = r.role_id
JOIN role_permissions rp ON r.role_id = rp.role_id
JOIN permissions p ON rp.permission_id = p.permission_id;