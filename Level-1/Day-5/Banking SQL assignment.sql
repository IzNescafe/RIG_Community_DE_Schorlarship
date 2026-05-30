DROP DATABASE IF EXISTS banking_lab;
CREATE DATABASE banking_lab;
USE banking_lab;
-- Customers
CREATE TABLE customers (
 customer_id INT PRIMARY KEY AUTO_INCREMENT,
 customer_name VARCHAR(100),
 city VARCHAR(50)
);
-- Accounts
CREATE TABLE accounts (
 account_id INT PRIMARY KEY AUTO_INCREMENT,
 customer_id INT,
 account_type VARCHAR(50), -- Savings / Current
 balance DECIMAL(12,2),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- Transactions
CREATE TABLE transactions (
 transaction_id INT PRIMARY KEY AUTO_INCREMENT,
 account_id INT,
 transaction_type VARCHAR(50), -- Deposit / Withdrawal
 amount DECIMAL(12,2),
 transaction_date DATE,
 FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Customers
INSERT INTO customers (customer_name, city) VALUES
('Aung Aung', 'Yangon'),
('Su Su', 'Mandalay'),
('Kyaw Kyaw', 'Yangon'),
('Mya Mya', 'Bago'),
('Ko Ko', 'Yangon');
-- Accounts
INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1, 'Savings', 5000),
(2, 'Current', 8000),
(3, 'Savings', 12000),
(4, 'Savings', 3000),
(5, 'Current', 15000);
-- Transactions
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1, 'Deposit', 2000, '2025-01-01'),
(1, 'Withdrawal', 500, '2025-01-02'),
(2, 'Deposit', 3000, '2025-01-03'),
(3, 'Deposit', 4000, '2025-01-04'),
(3, 'Withdrawal', 1000, '2025-01-05'),
(4, 'Deposit', 1500, '2025-01-06'),
(5, 'Deposit', 7000, '2025-01-07'),
(5, 'Withdrawal', 2000, '2025-01-08');

select * from customers;

select customer_name, city from customers;

select * from accounts where balance > 0;

select * from customers where city = "Yangon";

select * from accounts where balance > 10000;

select * from transactions where transaction_type = "Deposit";

select * from accounts order by balance asc;

select * from transactions order by transaction_date desc;

SELECT customer_id, SUM(balance) 
FROM accounts 
GROUP BY customer_id;

select account_id, sum(amount)
from transactions
group by account_id;

select account_id, count(account_id) as count
from transactions
group by account_id;

select account_type, SUM(balance) as total_balance
from accounts
group by account_type
having total_balance > 10000;

select transaction_type, sum(amount) as total
from transactions
group by transaction_type
having total > 5000;

select a.customer_id, count(t.transaction_id) as total_transactions, sum(t.amount) as total_amount
from accounts a
inner join transactions t on a.account_id = t.account_id
group by a.customer_id
having total_amount > 3000
order by total_amount desc;

select c.customer_name, a.account_type, a.balance
from customers c
inner join accounts a on c.customer_id = a.customer_id;

select 
    c.customer_id,
    c.customer_name, 
    SUM(t.amount) as total_deposits
from customers c
inner join accounts a on c.customer_id = a.customer_id
inner join transactions t on a.account_id = t.account_id
where t.transaction_type = 'Deposit'
group by c.customer_id, c.customer_name;

select 
    c.customer_id,
    c.customer_name, 
    COUNT(t.transaction_id) AS transaction_count
from customers c
inner join accounts a on c.customer_id = a.customer_id
inner join transactions t on a.account_id = t.account_id
group by c.customer_id, c.customer_name
having transaction_count > 1;

select 
    c.customer_id,
    c.customer_name, 
    SUM(t.amount) as total_withdrawals
from customers c
inner join accounts a on c.customer_id = a.customer_id
inner join transactions t on a.account_id = t.account_id
where t.transaction_type = 'Withdrawal'
group by c.customer_id, c.customer_name
HAVING total_withdrawals > 1000;

