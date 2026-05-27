# Day 4 Lecture: Key Features of SQL

> Theme: SQL is the language used to define, manage, protect, and control data in relational databases.

## Learning Goals

By the end of Day 4, students should be able to:

- Explain the main features of SQL.
- Identify the difference between DDL, DML, DCL, and TCL.
- Write basic SQL commands for creating tables, inserting data, granting access, and controlling transactions.
- Understand when each SQL command category is used in real database work.
- Explain ACID properties and serializability.
- Identify common multiuser concurrency problems such as lost updates, uncommitted data, and inconsistent retrievals.
- Understand why locks and commits are needed for correct transaction execution.

---

## 1. What Is SQL?

**SQL** stands for **Structured Query Language**.

It is used to communicate with relational database systems such as:

- MySQL
- PostgreSQL
- SQL Server
- Oracle Database
- SQLite

SQL helps us:

- Create database structures.
- Insert, read, update, and delete data.
- Control user permissions.
- Manage transactions safely.

---

## 2. Key Features of SQL

SQL commands are commonly grouped into four major categories:

| Feature | Full Name | Main Purpose |
| --- | --- | --- |
| **DDL** | Data Definition Language | Defines database structure. |
| **DML** | Data Manipulation Language | Works with data inside tables. |
| **DCL** | Data Control Language | Controls user access and permissions. |
| **TCL** | Transaction Control Language | Controls transaction behavior. |

Simple memory trick:

```text
DDL = structure
DML = data
DCL = permission
TCL = transaction
```

---

## 3. Data Definition Language

**Data Definition Language** is used to define and modify database objects.

Database objects include:

- Databases
- Tables
- Columns
- Views
- Indexes
- Constraints

### Common DDL Commands

| Command | Purpose |
| --- | --- |
| `CREATE` | Creates a new database object. |
| `ALTER` | Changes an existing database object. |
| `DROP` | Deletes a database object. |
| `TRUNCATE` | Removes all rows from a table quickly. |
| `RENAME` | Renames a database object. |

### Example: Create a Table

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT
);
```

### Example: Add a Column

```sql
ALTER TABLE students
ADD phone_number VARCHAR(20);
```

### Example: Drop a Table

```sql
DROP TABLE students;
```

**Key idea:** DDL changes the design or structure of the database.

---

## 4. Data Manipulation Language

**Data Manipulation Language** is used to insert, read, update, and delete records inside tables.

### Common DML Commands

| Command | Purpose |
| --- | --- |
| `SELECT` | Reads data from a table. |
| `INSERT` | Adds new records. |
| `UPDATE` | Modifies existing records. |
| `DELETE` | Removes records. |

### Example: Insert Data

```sql
INSERT INTO students (student_id, student_name, email, age)
VALUES (1, 'Aung Aung', 'aung@example.com', 20);
```

### Example: Read Data

```sql
SELECT student_id, student_name, email
FROM students;
```

### Example: Update Data

```sql
UPDATE students
SET age = 21
WHERE student_id = 1;
```

### Example: Delete Data

```sql
DELETE FROM students
WHERE student_id = 1;
```

**Key idea:** DML works with the data stored inside tables.

---

## 5. Data Control Language

**Data Control Language** is used to control database permissions.

It decides who can:

- Read data.
- Insert data.
- Update data.
- Delete data.
- Create or modify database objects.

### Common DCL Commands

| Command | Purpose |
| --- | --- |
| `GRANT` | Gives permission to a user. |
| `REVOKE` | Removes permission from a user. |

### Example: Grant Permission

```sql
GRANT SELECT, INSERT
ON students
TO 'student_user';
```

### Example: Revoke Permission

```sql
REVOKE INSERT
ON students
FROM 'student_user';
```

**Key idea:** DCL protects the database by controlling user access.

---

## 6. Transaction Control Language

**Transaction Control Language** is used to manage transactions.

A transaction is a group of SQL operations treated as one unit of work.

### Common TCL Commands

| Command | Purpose |
| --- | --- |
| `START TRANSACTION` | Begins a transaction. |
| `COMMIT` | Saves all changes in the transaction. |
| `ROLLBACK` | Cancels all uncommitted changes. |
| `SAVEPOINT` | Creates a point inside a transaction to roll back to. |

### Example: Commit a Transaction

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;
```

### Example: Rollback a Transaction

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

ROLLBACK;
```

**Key idea:** TCL helps keep database changes safe and consistent.

---

## 7. Transaction Properties

A **transaction** is a sequence of database operations that must be handled as one complete unit.

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;
```

The database should not save only one update. Both updates should succeed together, or both should be cancelled.

### ACID Properties

| Property | Meaning | Simple Example |
| --- | --- | --- |
| **Atomicity** | All operations in a transaction succeed, or none are saved. | Money is deducted and added together, not halfway. |
| **Consistency** | A transaction keeps the database valid. | Balance should not become negative if the rule says it cannot. |
| **Isolation** | Concurrent transactions should not interfere incorrectly. | One user should not see another user's unfinished update. |
| **Durability** | Committed changes remain saved. | After `COMMIT`, data survives restart or reconnect. |

**Key idea:** ACID makes transactions reliable.

### Serializability

**Serializability** means that even when transactions run at the same time, the final result should be the same as if the transactions ran one after another.

Serial execution:

```text
T1 runs completely -> T2 runs completely
```

Concurrent execution:

```text
T1 step 1 -> T2 step 1 -> T1 step 2 -> T2 step 2
```

Serializable concurrent execution:

```text
The steps may be mixed,
but the final result is still correct,
as if T1 and T2 ran one by one.
```

**Key idea:** serializability is the correctness goal for concurrent transactions.

---

## 8. Single-User vs Multiuser Database Systems

### Single-User Database System

A **single-user database system** allows only one user or one process to access the database at a time.

This is simpler because:

- Only one transaction runs at a time.
- No other user changes the same data at the same moment.
- Concurrency problems are rare or impossible.

Example:

```text
User 1 uses the database.
No other user can update it at the same time.
```

### Multiuser Database System

A **multiuser database system** allows many users or applications to access the same database at the same time.

This is powerful, but it creates concurrency problems.

Example:

```text
User 1 updates an account balance.
User 2 reads or updates the same account balance at the same time.
```

Multiuser databases need **concurrency control**.

---

## 9. Concurrency Control

**Concurrency control** is the database technique used to manage simultaneous transactions safely.

It protects the database from problems such as:

| Problem | Meaning |
| --- | --- |
| **Lost update** | One transaction overwrites another transaction's update. |
| **Uncommitted data** | A transaction reads data that another transaction has not committed yet. |
| **Inconsistent retrieval** | A transaction reads mixed old and new data while another transaction is updating. |

Concurrency control uses tools such as:

- Locks
- Isolation levels
- Transaction logs
- Timestamps
- Multi-version concurrency control, also called MVCC

---

## 10. Lost Update Problem

A **lost update** happens when two transactions read the same data, both update it, and one update overwrites the other.

Example starting data:

```text
account_id | balance
1          | 1000
```

Incorrect execution:

```text
Time | Transaction 1                  | Transaction 2
---  | ---                            | ---
1    | Read balance = 1000            |
2    |                                | Read balance = 1000
3    | Add 100 -> new balance = 1100  |
4    |                                | Add 200 -> new balance = 1200
5    | Write balance = 1100           |
6    |                                | Write balance = 1200
```

Final balance:

```text
1200
```

But the correct balance should be:

```text
1000 + 100 + 200 = 1300
```

The `+100` update was lost because Transaction 2 wrote a value based on old data.

**Key idea:** lost update means one user's update disappears.

---

## 11. Serial Execution of Two Transactions

The simplest correct approach is **serial execution**, where one transaction finishes before the next transaction starts.

Example:

```text
Initial balance = 1000

T1: add 100
T2: add 200
```

Correct serial execution:

```text
Time | Transaction 1                  | Transaction 2
---  | ---                            | ---
1    | Read balance = 1000            |
2    | Add 100                        |
3    | Write balance = 1100           |
4    | COMMIT                         |
5    |                                | Read balance = 1100
6    |                                | Add 200
7    |                                | Write balance = 1300
8    |                                | COMMIT
```

Final balance:

```text
1300
```

Serial execution is correct, but it can be slow because transactions wait for each other.

---

## 12. Why Locks Are Needed

A **lock** prevents two transactions from changing the same data at the same time.

When Transaction 1 updates a row, the database can lock that row.

```text
T1 locks account 1.
T2 wants to update account 1.
T2 must wait.
```

Example:

```sql
START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 1;

COMMIT;
```

`FOR UPDATE` tells the database:

```text
I plan to update this row.
Lock it so another transaction cannot update it at the same time.
```

**Key idea:** locks help prevent lost updates.

---

## 13. Commit Is Needed to Unlock

Locks should not stay forever. A transaction normally releases its locks when it finishes.

Common lock release points:

- `COMMIT`
- `ROLLBACK`

Example:

```text
Time | Transaction 1                  | Transaction 2
---  | ---                            | ---
1    | START TRANSACTION              |
2    | Lock account 1                 |
3    | Update account 1               |
4    |                                | Waits for account 1
5    | COMMIT                         |
6    | Lock is released               |
7    |                                | Can now update account 1
```

If Transaction 1 never commits or rolls back, Transaction 2 may keep waiting.

**Key idea:** `COMMIT` saves the work and releases the lock.

---

## 14. Correct Execution of Two Transactions

Correct concurrent execution allows transactions to overlap, but still protects shared data.

Starting data:

```text
account_id | balance
1          | 1000
```

Correct execution using a lock:

```text
Time | Transaction 1                  | Transaction 2
---  | ---                            | ---
1    | START TRANSACTION              |
2    | Read and lock balance = 1000   |
3    | Add 100                        |
4    | Write balance = 1100           |
5    |                                | START TRANSACTION
6    |                                | Tries to lock same row and waits
7    | COMMIT and unlock              |
8    |                                | Read and lock balance = 1100
9    |                                | Add 200
10   |                                | Write balance = 1300
11   |                                | COMMIT and unlock
```

Final balance:

```text
1300
```

This execution is correct because Transaction 2 uses the committed result from Transaction 1.

---

## 15. Uncommitted Data Problem

An **uncommitted data problem** happens when one transaction reads data written by another transaction before it commits.

This is also called a **dirty read**.

Starting data:

```text
account_id | balance
1          | 1000
```

Incorrect execution:

```text
Time | Transaction 1                  | Transaction 2
---  | ---                            | ---
1    | START TRANSACTION              |
2    | Update balance to 500          |
3    |                                | Read balance = 500
4    | ROLLBACK                       |
```

Problem:

```text
Transaction 2 read 500,
but Transaction 1 cancelled that change.
The real committed balance is still 1000.
```

This is dangerous because Transaction 2 made a decision using data that never became permanent.

Correct behavior:

```text
Transaction 2 should only read committed data,
or wait until Transaction 1 commits or rolls back.
```

**Key idea:** never trust uncommitted data.

---

## 16. Inconsistent Retrieval Problem

An **inconsistent retrieval** happens when a transaction reads several rows while another transaction is changing some of those rows.

Example:

```text
Transaction 1 calculates total account balance.
Transaction 2 transfers money between accounts at the same time.
```

Starting data:

```text
Account A = 1000
Account B = 1000
Total     = 2000
```

Incorrect timeline:

```text
Time | Transaction 1: Calculate Total | Transaction 2: Transfer
---  | ---                            | ---
1    | Read Account A = 1000          |
2    |                                | Deduct 100 from Account A
3    |                                | Add 100 to Account B
4    | Read Account B = 1100          |
```

Transaction 1 calculates:

```text
1000 + 1100 = 2100
```

But the real total should still be:

```text
2000
```

**Key idea:** inconsistent retrieval means a transaction reads a mixture of old and new values.

---

## 17. SQL Command Categories Summary

| Category | Used For | Commands |
| --- | --- | --- |
| **DDL** | Database structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML** | Table data | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **DCL** | User permissions | `GRANT`, `REVOKE` |
| **TCL** | Transactions | `START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

### Quick Classification Practice

| SQL Command | Category |
| --- | --- |
| `CREATE TABLE students (...)` | DDL |
| `INSERT INTO students VALUES (...)` | DML |
| `GRANT SELECT ON students TO user1` | DCL |
| `COMMIT` | TCL |
| `UPDATE students SET age = 21` | DML |
| `DROP TABLE students` | DDL |

---

## 18. Exercises

### Exercise 1: Identify the Category

Classify each command as DDL, DML, DCL, or TCL:

```sql
CREATE DATABASE school;
INSERT INTO students VALUES (1, 'Su Su');
GRANT SELECT ON students TO user1;
ROLLBACK;
ALTER TABLE students ADD email VARCHAR(100);
DELETE FROM students WHERE student_id = 1;
```

### Exercise 2: Write SQL Commands

Write SQL for the following:

1. Create a table named `courses`.
2. Insert one course into the table.
3. Select all courses.
4. Update the course name.
5. Delete the course.

### Exercise 3: Transaction Practice

Write a transaction that:

1. Deducts `50000` from one student's payment balance.
2. Adds `50000` to another student's payment balance.
3. Uses `COMMIT` if both updates are correct.
4. Uses `ROLLBACK` if something goes wrong.

### Exercise 4: Lost Update Analysis

Two transactions update the same account:

```text
Initial balance = 1000
T1 adds 100
T2 adds 200
```

Answer:

1. What is the correct final balance?
2. How can the lost update problem produce the wrong final balance?
3. Why does locking solve the problem?

### Exercise 5: Dirty Read Analysis

Transaction 1 updates a student's payment status to `Paid`, but does not commit yet.

Transaction 2 reads the payment status as `Paid`.

Then Transaction 1 rolls back.

Answer:

1. What problem happened?
2. Why is this dangerous?
3. What should Transaction 2 read instead?

---

## 19. Review Questions

1. What does SQL stand for?
2. What is the difference between DDL and DML?
3. Which SQL category controls user permissions?
4. Which SQL category uses `COMMIT` and `ROLLBACK`?
5. Why should we use `WHERE` with `UPDATE` and `DELETE`?
6. What is the purpose of a transaction?
7. What are the four ACID properties?
8. What does serializability mean?
9. What is the lost update problem?
10. Why are locks needed in multiuser databases?
11. Why does `COMMIT` release locks?
12. What is an uncommitted data problem?
13. What is inconsistent retrieval?
