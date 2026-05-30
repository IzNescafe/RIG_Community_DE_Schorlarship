# Day 5 Lecture: MySQL Module 2

> Theme: MySQL is a fast, scalable, and widely used relational database management system built around a client-server architecture.

## Learning Goals

By the end of Day 5, students should be able to:

- Explain what MySQL is.
- Identify the main features of MySQL.
- Describe MySQL client-server architecture.
- Explain the client layer, server layer, and storage layer.
- Understand why InnoDB is the default MySQL storage engine.
- Choose suitable MySQL data types for table columns.
- Use SQL operators to build conditions and expressions.

---

## 1. What Is MySQL?

**MySQL** is an open-source relational database management system, also called an **RDBMS**.

It is used to store, organize, retrieve, and manage structured data using SQL.

MySQL is:

- Supported by **Oracle**.
- Fast for many common database workloads.
- Scalable for small, medium, and large applications.
- Easy to use compared with many enterprise database systems.
- Widely used in web applications, business systems, dashboards, and backend services.

### Simple Definition

```text
MySQL is a database management system that stores data in tables
and lets users manage that data using SQL.
```

### Common Use Cases

- Student management systems.
- Ecommerce websites.
- Inventory systems.
- Banking or payment records.
- HR and payroll systems.
- Blogs, CMS platforms, and web applications.

---

## 2. Key Features of MySQL

| Feature | Meaning |
| --- | --- |
| **Client-server architecture** | Clients send requests; the MySQL server processes them. |
| **Fast performance** | Optimized for quick data storage and retrieval. |
| **Scalability** | Can support small apps and larger production systems. |
| **Ease of use** | SQL syntax and tools are beginner-friendly. |
| **Multithreading** | Multiple client connections can be handled at the same time. |
| **Parallel processing** | MySQL can process multiple operations efficiently. |
| **Security** | Supports users, passwords, roles, and privilege checks. |
| **Storage engines** | Supports engines such as InnoDB and MyISAM. |
| **Transaction support** | InnoDB supports ACID transactions. |

### Client-Server Idea

```text
Client sends SQL request -> MySQL Server processes request -> Storage engine reads/writes data
```

Example:

```sql
SELECT * FROM students;
```

This query is sent from a client tool to the MySQL server. The server checks the request, executes it, gets data from storage, and sends the result back.

---

## 3. MySQL Architecture Overview

MySQL architecture can be understood in three main layers:

1. **Client Layer**
2. **Server Layer**
3. **Storage Layer**

```text
+------------------------------+
|        Client Layer          |
|  Apps, MySQL CLI, Workbench  |
+--------------+---------------+
               |
               v
+------------------------------+
|        Server Layer          |
| Parser, Optimizer, Executor  |
| Security, Cache, Functions   |
+--------------+---------------+
               |
               v
+------------------------------+
|        Storage Layer         |
|   InnoDB, MyISAM, Memory     |
+------------------------------+
```

**Key idea:** the client asks, the server thinks, and the storage layer saves or retrieves the data.

---

## 4. Client Layer

The **client layer** is the part that sends requests and instructions to the MySQL server.

Clients can be:

- MySQL Command Line Client.
- MySQL Workbench.
- Web applications.
- Backend APIs.
- Reporting tools.
- Programming languages such as Python, Java, PHP, or JavaScript.

### What the Client Layer Does

| Responsibility | Meaning |
| --- | --- |
| Sends SQL requests | The client sends commands such as `SELECT`, `INSERT`, `UPDATE`, and `DELETE`. |
| Receives results | The client receives query results or error messages from the server. |
| Starts connections | The client connects to the MySQL server using host, port, username, and password. |
| Displays output | The client shows tables, rows, success messages, or errors. |

### Important Client/Connection Services

| Service | Meaning |
| --- | --- |
| **Connection handling** | MySQL accepts, manages, and closes client connections. |
| **Authentication** | MySQL checks whether the username and password are valid. |
| **Post-authentication checks** | After login, MySQL checks what the user is allowed to do. |
| **Privilege checks** | MySQL verifies permissions before executing commands. |

Example:

```text
User logs in as student_user.
MySQL checks the password.
MySQL checks whether student_user can SELECT from the students table.
If permission exists, the query is allowed.
```

### Client Request Flow

```text
1. Client connects to MySQL.
2. MySQL checks username and password.
3. Client sends SQL query.
4. MySQL checks user privileges.
5. Server processes the query.
6. Client receives the result.
```

---

## 5. Server Layer

The **server layer** is the brain of MySQL architecture.

It receives SQL from the client, understands it, decides the best way to execute it, and communicates with the storage layer.

### Main Jobs of the Server Layer

| Component | Purpose |
| --- | --- |
| **Connection manager** | Manages client connections. |
| **Thread handler** | Assigns or manages a thread for each client connection so multiple clients can work at the same time. |
| **Parser** | Checks SQL syntax and breaks the query into understandable parts. |
| **Preprocessor** | Checks table names, column names, and basic validity. |
| **Optimizer** | Chooses an efficient way to execute the query. |
| **Executor** | Runs the query plan. |
| **Privilege checker** | Confirms the user has permission. |
| **Query cache or buffers** | Helps improve performance, depending on version and configuration. |
| **Built-in functions** | Handles functions such as `COUNT()`, `SUM()`, `NOW()`, and `CONCAT()`. |

### Thread Handling

MySQL is a multithreaded database server.

This means it can handle many client connections at the same time.

```text
Client 1 -> Thread 1
Client 2 -> Thread 2
Client 3 -> Thread 3
```

Each thread can process work for a client connection, such as receiving SQL commands, checking permissions, executing queries, and returning results.

Why thread handling matters:

- Many users can connect at the same time.
- Long-running queries do not have to stop every other user.
- The server can manage concurrent database work more efficiently.
- It supports multiuser database applications.

### From Parser to Optimized Execution Plan

When MySQL receives a query, it does not execute the text immediately. It first converts the SQL into an execution plan.

Example query:

```sql
SELECT student_name
FROM students
WHERE student_id = 1;
```

Query processing flow:

```text
SQL Query
  |
  v
Parser
  |
  | checks syntax
  v
Preprocessor
  |
  | checks table names, column names, and privileges
  v
Optimizer
  |
  | chooses the best way to access data
  v
Optimized Execution Plan
  |
  v
Executor
  |
  | asks the storage engine for rows
  v
Result
```

### What the Optimizer Decides

The optimizer may decide:

- Whether to use an index.
- Which table to read first in a join.
- Which filtering condition to apply early.
- Which access path is cheaper.
- How to reduce unnecessary row reads.

Simple example:

```text
Without index:
MySQL may scan many rows.

With index on student_id:
MySQL can find the row faster.
```

**Key idea:** the parser understands the SQL, but the optimizer decides the efficient execution plan.

### Server Layer Example

Query:

```sql
SELECT student_name
FROM students
WHERE student_id = 1;
```

Server layer process:

```text
1. Check SQL syntax.
2. Check whether the students table exists.
3. Check whether student_id and student_name columns exist.
4. Check whether the user has SELECT permission.
5. Choose an efficient way to find the row.
6. Ask the storage layer for the data.
7. Return the result to the client.
```

**Key idea:** the server layer understands and executes SQL.

---

## 6. Storage Layer

The **storage layer** is responsible for storing, retrieving, and managing data physically on disk.

It handles:

- Tables.
- Indexes.
- Rows.
- Transactions.
- Locks.
- Disk storage.
- Crash recovery.
- Data files.
- Engine-specific storage behavior.

Different applications have different storage requirements, so MySQL supports multiple storage engines.

Example:

```text
A banking system needs transactions and crash recovery.
A logging system may need fast append-only storage.
A temporary calculation table may need memory-based storage.
```

### InnoDB: Default Storage Engine

**InnoDB** is the default MySQL storage engine.

It is commonly used because it supports:

- ACID transactions.
- `COMMIT` and `ROLLBACK`.
- Foreign keys.
- Row-level locking.
- Crash recovery.
- Better safety for multiuser applications.

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
) ENGINE = InnoDB;
```

If the engine is not specified, modern MySQL usually uses InnoDB by default.

**Key idea:** the storage layer physically manages the data, and InnoDB is the default engine for safe transactional work.

---

## 7. MySQL Architecture with Pluggable Storage Engines

MySQL uses a **pluggable storage engine architecture**.

This means the MySQL server layer can work with different storage engines depending on the table requirement.

```text
+------------------------------+
|        Client Layer          |
|  Workbench, CLI, App, API     |
+--------------+---------------+
               |
               v
+------------------------------+
|        Server Layer          |
| Parser -> Optimizer -> Exec  |
| Thread Handling + Privileges |
+--------------+---------------+
               |
               v
+------------------------------+
|   Pluggable Storage Engines  |
| InnoDB | MyISAM | CSV        |
| MEMORY | ARCHIVE | NDB       |
+------------------------------+
               |
               v
+------------------------------+
|      Physical Data Files     |
|     Disk / Memory / Cluster  |
+------------------------------+
```

### Why Pluggable Storage Engines Matter

Different storage engines are designed for different needs.

| Requirement | Better Engine Choice |
| --- | --- |
| Transactions and foreign keys | InnoDB |
| Simple read-heavy old systems | MyISAM |
| Plain CSV file storage | CSV |
| Temporary fast in-memory tables | MEMORY |
| Large compressed historical data | ARCHIVE |
| Distributed clustered storage | NDB |

**Key idea:** the server layer handles SQL, while the storage engine controls how the table is physically stored and managed.

---

## 8. Comparison of MySQL Storage Engines

| Storage Engine | Best For | Transactions | Locking | Main Notes |
| --- | --- | --- | --- | --- |
| **InnoDB** | General-purpose applications, banking, ecommerce, multiuser systems | Yes | Row-level locking | Default engine. Supports ACID, foreign keys, crash recovery, and high reliability. |
| **MyISAM** | Older read-heavy applications | No | Table-level locking | Simple and fast for reads, but no transactions or foreign keys. Less safe for write-heavy systems. |
| **CSV** | Data exchange using CSV files | No | Table-level behavior | Stores data in comma-separated value files. Easy to inspect, but not good for performance-heavy use. |
| **MEMORY** | Temporary fast access tables | No | Table-level locking | Stores data in RAM. Very fast, but data is lost when the server restarts. |
| **ARCHIVE** | Historical logs and compressed storage | No | Insert-focused | Good for storing large amounts of rarely updated historical data. Supports compressed storage. |
| **NDB** | Distributed clustered databases | Yes | Distributed row-level behavior | Used by MySQL Cluster. Supports high availability and distributed data storage. |

### Storage Engine Selection Examples

| Scenario | Suggested Engine | Reason |
| --- | --- | --- |
| Student payment system | InnoDB | Needs transactions and safety. |
| Temporary report calculation | MEMORY | Fast temporary data access. |
| Export/import table readable as CSV | CSV | Stores data in CSV format. |
| Old read-only content table | MyISAM | Simple read-heavy use case. |
| Large historical audit logs | ARCHIVE | Compresses large stored data. |
| High-availability distributed system | NDB | Designed for clustered storage. |

### Creating Tables with Different Engines

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
) ENGINE = InnoDB;
```

```sql
CREATE TABLE temp_report (
    report_id INT,
    total_amount DECIMAL(10,2)
) ENGINE = MEMORY;
```

```sql
CREATE TABLE imported_csv_data (
    id INT NOT NULL,
    description VARCHAR(255)
) ENGINE = CSV;
```

### How to Check Available Storage Engines

```sql
SHOW ENGINES;
```

This command shows which storage engines are available in the current MySQL server.

**Key idea:** choose the storage engine based on the table's purpose, not just because an engine exists.

---

## 9. MySQL Data Types

A **data type** defines what kind of value a column can store.

When creating a table, every column must have a data type.

Example:

```sql
CREATE TABLE students (
    student_id INT,
    student_name VARCHAR(100),
    birth_date DATE,
    gpa DECIMAL(3,2)
);
```

In this table:

- `student_id` stores whole numbers.
- `student_name` stores text.
- `birth_date` stores a date.
- `gpa` stores decimal values.

**Key idea:** choosing the correct data type improves correctness, storage efficiency, and performance.

### Numeric Data Types

Numeric data types store numbers.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `TINYINT` | Very small integer. Often used for small status values or flags. | `1` |
| `SMALLINT` | Small integer. Useful for small numeric ranges. | `250` |
| `MEDIUMINT` | Medium-size integer. Larger than `SMALLINT`, smaller than `INT`. | `50000` |
| `INT` or `INTEGER` | Standard whole number. Common for IDs and counts. | `1001` |
| `BIGINT` | Very large whole number. Useful for huge IDs or large counters. | `9000000000` |
| `DECIMAL(p,s)` | Exact decimal number. Best for money and precise values. | `1250.75` |
| `FLOAT` | Approximate floating-point number. Uses less storage but may have rounding. | `3.14` |
| `DOUBLE` | Larger approximate floating-point number. More precision than `FLOAT`. | `3.14159265` |
| `BIT` | Stores bit values. Can be used for binary flags. | `b'1'` |

Example:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    price DECIMAL(10,2),
    stock_quantity INT
);
```

Use `DECIMAL` for money instead of `FLOAT` because money should be exact.

### String Data Types

String data types store text, characters, or binary-like text values.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `CHAR(n)` | Fixed-length text. Best when values always have the same length. | `'M001'` |
| `VARCHAR(n)` | Variable-length text. Common for names, emails, and titles. | `'Aung Aung'` |
| `TINYTEXT` | Very small text field. | short note |
| `TEXT` | Long text field. Useful for descriptions or comments. | product description |
| `MEDIUMTEXT` | Larger text field than `TEXT`. | article body |
| `LONGTEXT` | Very large text field. | large document |
| `BINARY(n)` | Fixed-length binary data. | binary bytes |
| `VARBINARY(n)` | Variable-length binary data. | binary bytes |
| `BLOB` | Binary large object. Used for binary files or raw data. | image/file bytes |

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    email VARCHAR(100),
    gender CHAR(1)
);
```

Use `VARCHAR` for most normal text columns because it stores variable-length text efficiently.

### Date and Time Data Types

Date and time data types store temporal values.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `DATE` | Stores date only in `YYYY-MM-DD` format. | `2026-05-28` |
| `TIME` | Stores time only in `HH:MM:SS` format. | `09:30:00` |
| `DATETIME` | Stores date and time together. | `2026-05-28 09:30:00` |
| `TIMESTAMP` | Stores date and time, often used for created/updated times. Time zone handling depends on server settings. | `2026-05-28 09:30:00` |
| `YEAR` | Stores year only. | `2026` |

Example:

```sql
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    attendance_date DATE,
    check_in_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Use `DATE` when you only need the date. Use `DATETIME` or `TIMESTAMP` when you need both date and time.

### Boolean Data Type

MySQL supports `BOOLEAN`, but it is treated like `TINYINT(1)`.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `BOOLEAN` or `BOOL` | Stores true/false values. Internally handled like `TINYINT(1)`. | `TRUE`, `FALSE` |

Example:

```sql
CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    task_name VARCHAR(100),
    is_completed BOOLEAN
);
```

In MySQL:

```text
TRUE  = 1
FALSE = 0
```

### JSON Data Type

The `JSON` data type stores JSON documents.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `JSON` | Stores structured JSON data. Useful for flexible attributes. | `{"color": "red", "size": "M"}` |

Example:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    attributes JSON
);
```

Use `JSON` when some data is flexible or semi-structured, but do not use it to replace good relational design for important core data.

### ENUM and SET Data Types

`ENUM` and `SET` restrict values to a defined list.

| Data Type | Description | Example Value |
| --- | --- | --- |
| `ENUM` | Allows one value from a predefined list. | `'Pending'` |
| `SET` | Allows multiple values from a predefined list. | `'SQL,Python'` |

Example:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    status ENUM('Pending', 'Paid', 'Shipped', 'Cancelled')
);
```

Example with `SET`:

```sql
CREATE TABLE student_skills (
    student_id INT,
    skills SET('SQL', 'Python', 'Excel', 'Power BI')
);
```

Note:

```text
ENUM can be useful for stable status values.
SET should be used carefully because many-to-many tables are often better for normalized design.
```

### Choosing the Right Data Type

| Need | Suggested Data Type |
| --- | --- |
| Primary key ID | `INT` or `BIGINT` |
| Name or email | `VARCHAR(n)` |
| Fixed code such as `M001` | `CHAR(n)` |
| Money | `DECIMAL(10,2)` |
| Quantity or count | `INT` |
| Long description | `TEXT` |
| Date only | `DATE` |
| Date and time | `DATETIME` or `TIMESTAMP` |
| True/false value | `BOOLEAN` |
| Flexible attributes | `JSON` |
| One status from fixed choices | `ENUM` |

### Example Table with Multiple Data Types

```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code CHAR(6),
    course_name VARCHAR(100),
    price DECIMAL(10,2),
    start_date DATE,
    is_active BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Data Type Selection Tips

- Use the smallest type that safely fits the data.
- Use `VARCHAR` for most text.
- Use `DECIMAL` for money.
- Use `DATE`, `TIME`, `DATETIME`, or `TIMESTAMP` instead of storing dates as text.
- Use `INT` or `BIGINT` for IDs.
- Avoid storing multiple values in one column if the data should be normalized.
- Choose data types based on meaning, not only on what currently works.

---

## 10. SQL Operators

**SQL operators** are symbols or keywords used to compare values, combine conditions, calculate values, and filter query results.

Operators are commonly used in:

- `SELECT`
- `WHERE`
- `JOIN`
- `UPDATE`
- `DELETE`
- `HAVING`

Example:

```sql
SELECT *
FROM students
WHERE age >= 18;
```

In this query, `>=` is an operator.

---

### Arithmetic Operators

Arithmetic operators perform mathematical calculations.

| Operator | Meaning | Example |
| --- | --- | --- |
| `+` | Addition | `salary + 50000` |
| `-` | Subtraction | `balance - 100` |
| `*` | Multiplication | `price * quantity` |
| `/` | Division | `total / 2` |
| `%` or `MOD` | Remainder | `10 % 3` |

Example:

```sql
SELECT product_name, price, quantity, price * quantity AS total_amount
FROM order_items;
```

### Comparison Operators

Comparison operators compare two values and return true or false.

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equal to | `department = 'IT'` |
| `<>` or `!=` | Not equal to | `status <> 'Cancelled'` |
| `>` | Greater than | `salary > 500000` |
| `<` | Less than | `age < 18` |
| `>=` | Greater than or equal to | `score >= 80` |
| `<=` | Less than or equal to | `price <= 10000` |

Example:

```sql
SELECT *
FROM employees
WHERE salary >= 700000;
```

### Logical Operators

Logical operators combine multiple conditions.

| Operator | Meaning | Example |
| --- | --- | --- |
| `AND` | Both conditions must be true. | `department = 'IT' AND salary > 700000` |
| `OR` | At least one condition must be true. | `department = 'IT' OR department = 'HR'` |
| `NOT` | Reverses a condition. | `NOT status = 'Inactive'` |

Example:

```sql
SELECT *
FROM employees
WHERE department = 'IT'
  AND salary > 700000;
```

### Special Comparison Operators

These operators make filtering easier and more readable.

| Operator | Meaning | Example |
| --- | --- | --- |
| `BETWEEN` | Checks whether a value is inside a range. | `salary BETWEEN 500000 AND 900000` |
| `IN` | Checks whether a value matches any value in a list. | `department IN ('IT', 'HR')` |
| `LIKE` | Searches using a pattern. | `student_name LIKE 'A%'` |
| `IS NULL` | Checks for missing or unknown value. | `email IS NULL` |
| `IS NOT NULL` | Checks for existing value. | `phone IS NOT NULL` |
| `EXISTS` | Checks whether a subquery returns rows. | `EXISTS (SELECT 1 FROM orders ...)` |

Example with `BETWEEN`:

```sql
SELECT *
FROM employees
WHERE salary BETWEEN 500000 AND 900000;
```

Example with `IN`:

```sql
SELECT *
FROM employees
WHERE department IN ('IT', 'Finance', 'HR');
```

Example with `LIKE`:

```sql
SELECT *
FROM students
WHERE student_name LIKE 'A%';
```

Pattern meaning:

| Pattern | Meaning |
| --- | --- |
| `'A%'` | Starts with `A`. |
| `'%A'` | Ends with `A`. |
| `'%A%'` | Contains `A`. |
| `'_a%'` | Second character is `a`. |

### NULL Operators

`NULL` means missing, unknown, or not provided.

Do not compare `NULL` using `=`.

Incorrect:

```sql
SELECT *
FROM students
WHERE email = NULL;
```

Correct:

```sql
SELECT *
FROM students
WHERE email IS NULL;
```

To find rows where the value exists:

```sql
SELECT *
FROM students
WHERE email IS NOT NULL;
```

**Key idea:** use `IS NULL` and `IS NOT NULL` for missing values.

### Operator Precedence

SQL evaluates some operators before others.

Common order:

```text
1. Parentheses ()
2. Arithmetic operators
3. Comparison operators
4. NOT
5. AND
6. OR
```

Example:

```sql
SELECT *
FROM employees
WHERE department = 'IT'
   OR department = 'HR'
  AND salary > 700000;
```

This can be confusing because `AND` is evaluated before `OR`.

Clearer version:

```sql
SELECT *
FROM employees
WHERE (department = 'IT' OR department = 'HR')
  AND salary > 700000;
```

**Key idea:** use parentheses when combining `AND` and `OR`.

### SQL Operators Summary

| Operator Type | Used For | Examples |
| --- | --- | --- |
| Arithmetic | Calculations | `+`, `-`, `*`, `/`, `%` |
| Comparison | Comparing values | `=`, `<>`, `>`, `<`, `>=`, `<=` |
| Logical | Combining conditions | `AND`, `OR`, `NOT` |
| Range/List | Cleaner filtering | `BETWEEN`, `IN` |
| Pattern | Text searching | `LIKE` |
| NULL | Missing values | `IS NULL`, `IS NOT NULL` |

---

## 11. Full MySQL Query Flow

Example query:

```sql
SELECT * FROM students WHERE student_id = 1;
```

Flow:

```text
Client Layer
  |
  | sends SQL request
  v
Server Layer
  |
  | parses, checks privileges, optimizes, executes
  v
Storage Layer
  |
  | reads table/index data from InnoDB
  v
Server Layer
  |
  | prepares result
  v
Client Layer
  |
  | displays result to user
```

### Short Version

```text
Client -> Server -> Storage -> Server -> Client
```

---

## 12. MySQL Architecture Summary

| Layer | Main Role | Example |
| --- | --- | --- |
| **Client Layer** | Sends requests to MySQL server. | MySQL Workbench runs `SELECT * FROM students;` |
| **Server Layer** | Brain of MySQL; parses, checks, optimizes, and executes SQL. | Optimizer chooses how to find a row. |
| **Storage Layer** | Stores and retrieves actual data. | InnoDB reads rows from disk. |

### Memory Trick

```text
Client asks.
Server thinks.
Storage saves.
```

---

## 13. Exercises

### Exercise 1: Identify the Layer

Identify whether each task belongs to the client layer, server layer, or storage layer:

1. MySQL Workbench sends a `SELECT` query.
2. MySQL checks if the user has permission.
3. InnoDB stores table rows.
4. The optimizer chooses an execution plan.
5. The client displays query results.

### Exercise 2: Explain the Query Flow

Explain what happens when this query runs:

```sql
SELECT student_name
FROM students
WHERE student_id = 1;
```

Use this structure:

```text
Client Layer:
Server Layer:
Storage Layer:
Result:
```

### Exercise 3: InnoDB

Answer the following:

1. What is the default MySQL storage engine?
2. Why is InnoDB commonly used?
3. Which InnoDB features help with transactions?

### Exercise 4: Parser to Execution Plan

Explain the flow of this query from parser to optimized execution plan:

```sql
SELECT *
FROM students
WHERE student_id = 1;
```

Use this structure:

```text
Parser:
Preprocessor:
Optimizer:
Executor:
Storage engine:
```

### Exercise 5: Choose the Storage Engine

Choose the best storage engine and explain why:

1. A payment table that needs rollback.
2. A temporary reporting table.
3. A large historical log table.
4. A table that should be stored as CSV.
5. A clustered high-availability database table.

### Exercise 6: Choose the Data Type

Choose a suitable MySQL data type for each column:

| Column | Suggested Data Type |
| --- | --- |
| `student_id` |  |
| `student_name` |  |
| `email` |  |
| `birth_date` |  |
| `course_price` |  |
| `is_active` |  |
| `created_at` |  |
| `profile_settings` |  |

### Exercise 7: Create a Table with Data Types

Create a table named `enrollments` with suitable data types for:

1. `enrollment_id`
2. `student_id`
3. `course_name`
4. `enrollment_date`
5. `payment_amount`
6. `payment_status`

### Exercise 8: SQL Operators Practice

Write SQL queries for the following:

1. Select employees whose salary is greater than `700000`.
2. Select students whose names start with `A`.
3. Select products with prices between `10000` and `50000`.
4. Select employees from `IT`, `HR`, or `Finance`.
5. Select students whose email is missing.
6. Select active courses where the price is less than or equal to `100000`.

### Exercise 9: Fix the Operator Mistake

Fix this query:

```sql
SELECT *
FROM students
WHERE email = NULL;
```

Fix this query so the logic is clear:

```sql
SELECT *
FROM employees
WHERE department = 'IT'
   OR department = 'HR'
  AND salary > 700000;
```

---

## 14. Review Questions

1. What is MySQL?
2. Which company supports MySQL?
3. What does client-server architecture mean?
4. What is the role of the client layer?
5. What is the role of the server layer?
6. Why is the server layer called the brain of MySQL architecture?
7. What is the role of the storage layer?
8. What is the default MySQL storage engine?
9. Why is InnoDB useful for multiuser databases?
10. What does this flow mean: `Client -> Server -> Storage -> Server -> Client`?
11. What is thread handling in MySQL?
12. What is the role of the parser?
13. What does the optimizer produce?
14. What does pluggable storage engine architecture mean?
15. Which storage engine is best for transactions?
16. What is the difference between InnoDB and MyISAM?
17. When might the MEMORY engine be useful?
18. What does `SHOW ENGINES;` do?
19. What is a MySQL data type?
20. What is the difference between `CHAR` and `VARCHAR`?
21. Why should `DECIMAL` be used for money?
22. What data type should be used for a date only?
23. What is the difference between `DATETIME` and `DATE`?
24. What does MySQL use internally for `BOOLEAN`?
25. When might `JSON` be useful?
26. What are SQL operators?
27. What is the difference between arithmetic and comparison operators?
28. What is the difference between `AND` and `OR`?
29. When should we use `BETWEEN`?
30. When should we use `IN`?
31. What does `LIKE 'A%'` mean?
32. Why should we use `IS NULL` instead of `= NULL`?
33. Why are parentheses useful when combining `AND` and `OR`?
