# Day 14 Lecture: Docker, Oracle Database, and PL/SQL

> Theme: modern database work often combines deployment tools like Docker with database platforms like Oracle and procedural database programming using PL/SQL.

## Learning Goals

By the end of Day 14, students should be able to:

- Explain what Docker is and why developers use it.
- Compare traditional deployment with Docker deployment.
- Describe the basic Oracle database architecture.
- Identify common Oracle data types.
- Explain Oracle views, synonyms, sequences, and indexes.
- Write basic PL/SQL using `IF` and `FOR LOOP`.
- Understand PL/SQL procedures, functions, stored procedures, packages, and triggers.

---

## 1. Docker

### What Is Docker?

**Docker** is a platform used to package and run applications in isolated environments called **containers**.

A container includes:

- Application code.
- Runtime.
- Libraries.
- Dependencies.
- Configuration needed to run the application.

Simple definition:

```text
Docker packages an application and its dependencies into a container
so it can run consistently on different machines.
```

### Container Idea

```text
Application
  + Runtime
  + Libraries
  + Dependencies
  + Configuration
  = Docker Container
```

Example:

```text
A database lab can run Oracle, MySQL, or PostgreSQL in containers
without installing each database directly on the main computer.
```

### Why Use Docker?

| Reason | Explanation |
| --- | --- |
| **Consistency** | The same container works across different machines. |
| **Portability** | Containers can run on laptop, server, or cloud. |
| **Isolation** | Each application runs in its own environment. |
| **Easy setup** | Developers can start services with fewer manual installation steps. |
| **Faster deployment** | Applications can be deployed quickly. |
| **Version control for environment** | Docker images define the exact runtime environment. |
| **Scalability** | Containers can be started, stopped, and duplicated easily. |
| **Cleaner development** | Avoids dependency conflicts on the host machine. |

### Docker Terms

| Term | Meaning |
| --- | --- |
| **Image** | A blueprint/template used to create containers. |
| **Container** | A running instance of an image. |
| **Dockerfile** | A text file containing instructions to build an image. |
| **Docker Hub** | Online registry for Docker images. |
| **Volume** | Persistent storage used by containers. |
| **Port mapping** | Connects a container port to a host machine port. |
| **Docker Compose** | Tool for running multiple containers using one configuration file. |

---

## 2. Traditional Deployment vs Docker Deployment

### Traditional Deployment

In traditional deployment, software is installed directly on the operating system.

```text
Host Operating System
  -> Install runtime
  -> Install dependencies
  -> Configure application
  -> Run application
```

Problems:

- Different computers may have different versions.
- Dependency conflicts can happen.
- Setup can be slow.
- Moving the application to another server may be difficult.
- Rollback can be complicated.

### Docker Deployment

In Docker deployment, the application runs inside a container.

```text
Host Operating System
  -> Docker Engine
  -> Container
      -> Application + dependencies
```

Benefits:

- Same environment everywhere.
- Easier to move between machines.
- Faster setup.
- Cleaner isolation.
- Easier rollback using previous images.

### Comparison Table

| Topic | Traditional Deployment | Docker Deployment |
| --- | --- | --- |
| Environment | Installed directly on host OS. | Packaged inside container. |
| Dependencies | Installed manually. | Included in image. |
| Portability | May fail on another machine. | Runs consistently if Docker is available. |
| Setup speed | Often slower. | Usually faster. |
| Isolation | Lower isolation. | Stronger application isolation. |
| Version conflicts | More likely. | Less likely. |
| Rollback | Manual and harder. | Use previous image version. |
| Scaling | More manual. | Containers can be duplicated. |

**Key idea:** Docker makes deployment more consistent, portable, and repeatable.

---

## 3. Oracle Database Architecture

Oracle Database is a relational database management system used for enterprise applications.

Oracle architecture has two major ideas:

```text
Oracle Instance + Oracle Database
```

### Oracle Instance

An **Oracle instance** is the running memory and background processes used to access the database.

It includes:

- Memory structures.
- Background processes.

### Oracle Database

An **Oracle database** is the physical set of files where data is stored.

It includes:

- Data files.
- Control files.
- Redo log files.

### Architecture Diagram

```text
+-----------------------------------+
|          Oracle Instance          |
|                                   |
|  +-----------------------------+  |
|  | SGA: Shared Global Area     |  |
|  | Database Buffer Cache       |  |
|  | Redo Log Buffer             |  |
|  | Shared Pool                 |  |
|  | Large Pool                  |  |
|  | Java Pool                   |  |
|  +-----------------------------+  |
|                                   |
|  Background Processes             |
|  SMON, PMON, DBWR, LGWR, CKPT     |
+----------------+------------------+
                 |
                 v
+-----------------------------------+
|          Oracle Database          |
|                                   |
|  Data Files                       |
|  Control Files                    |
|  Redo Log Files                   |
+-----------------------------------+
```

### Main Oracle Architecture Components

| Component | Meaning |
| --- | --- |
| **SGA** | Shared Global Area; memory shared by Oracle processes. |
| **PGA** | Program Global Area; private memory for a server process. |
| **Database Buffer Cache** | Stores recently used data blocks in memory. |
| **Shared Pool** | Stores parsed SQL and execution plans. |
| **Redo Log Buffer** | Stores change records before writing to redo logs. |
| **Large Pool** | Optional memory area used for large operations such as backup/recovery, parallel execution, and shared server work. |
| **Java Pool** | Memory used for Java code and Java Virtual Machine work inside Oracle. |
| **DBWR / DBWn** | Database Writer; writes modified data blocks to data files. |
| **LGWR** | Log Writer; writes redo records to redo log files. |
| **CKPT** | Checkpoint process; updates file headers and checkpoint information. |
| **SMON** | System Monitor; performs recovery after failure. |
| **PMON** | Process Monitor; cleans up failed user processes. |

### SGA Memory Components

The **SGA** is the shared memory area of an Oracle instance. These components help Oracle process SQL faster and recover data safely.

| SGA Component | Main Purpose | Easy Memory Tip |
| --- | --- | --- |
| **Database Buffer Cache** | Keeps copies of recently used table and index blocks. | Speeds up data reading and writing. |
| **Redo Log Buffer** | Temporarily stores records of database changes. | Helps recovery after failure. |
| **Shared Pool** | Stores parsed SQL, execution plans, and data dictionary information. | Reuses SQL work instead of parsing again. |
| **Large Pool** | Handles large memory tasks like backup, restore, parallel query, and shared server operations. | Supports heavy background work. |
| **Java Pool** | Stores memory for Java execution inside Oracle. | Needed when Oracle runs Java code. |

### PGA: Program Global Area

The **PGA** is a private memory area used by one server process. Unlike the **SGA**, it is not shared by all users.

| PGA Feature | Explanation |
| --- | --- |
| **Full name** | Program Global Area |
| **Memory type** | Private memory |
| **Used by** | One server process or background process |
| **Main purpose** | Stores session-specific work while SQL is running |
| **Examples of use** | Sorting, hashing, cursor information, session variables, and private SQL work areas |

```text
User Session
     |
     v
Server Process
     |
     v
PGA: private memory for that process
```

### SGA vs PGA

| Feature | SGA | PGA |
| --- | --- | --- |
| Full name | Shared Global Area | Program Global Area |
| Sharing | Shared by many Oracle processes | Private to one process |
| Scope | Instance-level memory | Process/session-level memory |
| Stores | Buffer cache, shared pool, redo log buffer, large pool, Java pool | Sort area, session data, cursor state, private SQL work area |
| Main use | Speeds up shared database work | Supports one user's SQL execution work |

**Easy memory tip:** **SGA is shared**, but **PGA is private**.

### Oracle Process Types

Oracle uses different process types to connect users to the database and execute SQL commands.

```text
User Process
     |
     v
Server Process
     |
     v
Oracle Instance
     |
     v
Database Files
```

| Process Type | Meaning | Main Responsibility |
| --- | --- | --- |
| **User Process** | The program or application used by the user to connect to Oracle. | Sends SQL requests to the database. |
| **Server Process** | Oracle process that handles the user's request. | Parses SQL, executes SQL, reads data, and returns results. |
| **Background Process** | Oracle internal process running behind the scenes. | Manages writing, recovery, cleanup, checkpoints, and redo logs. |

### User Process

A **user process** starts when a user runs an application that connects to Oracle.

Examples:

- SQL Developer.
- SQL*Plus.
- Java, Python, PHP, or web application.
- Banking or business application connected to Oracle.

Main job:

```text
Send request from user/application to Oracle.
```

### Server Process

A **server process** is created by Oracle to serve the user process.

It can:

- Receive SQL statements from the user process.
- Parse and execute SQL.
- Read data blocks from database files or memory.
- Return query results to the user.
- Use PGA memory for private SQL work.

**Easy memory tip:** the user process asks; the server process works.

### Background Processes

Background processes run behind the scenes to manage memory, write data, recover the database, and keep the Oracle instance stable.

| Background Process | Full Name | Main Purpose |
| --- | --- | --- |
| **SMON** | System Monitor Process | Performs instance recovery after failure and cleans up temporary segments. |
| **PMON** | Process Monitor Process | Cleans up failed user processes and releases locked resources. |
| **DBWR / DBWn** | Database Writer Process | Writes changed data blocks from the database buffer cache to data files. |
| **LGWR** | Log Writer Process | Writes redo records from the redo log buffer to redo log files. |
| **CKPT** | Checkpoint Process | Signals checkpoints and updates control files and data file headers. |

```text
Database Buffer Cache --DBWR--> Data Files
Redo Log Buffer       --LGWR--> Redo Log Files
Failed Process        --PMON--> Cleanup
Database Failure      --SMON--> Recovery
Checkpoint Event      --CKPT--> File Header Updates
```

**Key idea:** memory components temporarily hold work, and background processes move that work safely to database files.

### Oracle Physical Files

| File Type | Purpose |
| --- | --- |
| **Data files** | Store actual table and index data. |
| **Control files** | Store database structure and metadata. |
| **Redo log files** | Store changes for recovery. |
| **Archive log files** | Store old redo logs when archive mode is enabled. |
| **Parameter files** | Store database startup configuration. |

**Key idea:** the Oracle instance runs the database, and the Oracle database stores the data physically.

### Logical Storage Data

Logical storage explains how Oracle organizes data inside the database. It is the structure Oracle uses to manage space logically, while physical files store the actual bytes on disk.

```text
Tablespace
    |
    v
Segment
    |
    v
Extent
    |
    v
Data Block
```

| Logical Storage Unit | Meaning | Example |
| --- | --- | --- |
| **Data Block** | Smallest unit of storage in Oracle. Oracle reads and writes data in blocks. | A block may store rows from a table. |
| **Extent** | A group of continuous data blocks. | More blocks added when a table grows. |
| **Segment** | A set of extents that stores one database object. | Table segment, index segment, undo segment. |
| **Tablespace** | Logical storage container made up of one or more data files. | `USERS`, `SYSTEM`, `SYSAUX` tablespaces. |

### Logical Storage Hierarchy

| Level | Storage Unit | Simple Explanation |
| --- | --- | --- |
| 1 | **Tablespace** | Biggest logical container. |
| 2 | **Segment** | Space used by one object, such as a table or index. |
| 3 | **Extent** | Group of data blocks allocated together. |
| 4 | **Data Block** | Smallest storage unit used by Oracle. |

**Easy memory tip:** tablespaces contain segments, segments contain extents, and extents contain data blocks.

---

## 4. Oracle Data Types

A **data type** defines what kind of value a column can store.

### Character Data Types

| Data Type | Description | Example |
| --- | --- | --- |
| `CHAR(n)` | Fixed-length character data. | `'M001'` |
| `VARCHAR2(n)` | Variable-length character data; commonly used for text. | `'Aung Aung'` |
| `NCHAR(n)` | Fixed-length Unicode character data. | Unicode text |
| `NVARCHAR2(n)` | Variable-length Unicode character data. | Unicode name |
| `CLOB` | Large character object for long text. | Article, document |
| `NCLOB` | Large Unicode character object. | Long Unicode text |

### Numeric Data Types

| Data Type | Description | Example |
| --- | --- | --- |
| `NUMBER` | General numeric type. | `1000` |
| `NUMBER(p)` | Number with precision. | `NUMBER(5)` |
| `NUMBER(p,s)` | Number with precision and scale. | `NUMBER(10,2)` |
| `FLOAT` | Approximate numeric value. | `3.14` |
| `BINARY_FLOAT` | 32-bit floating point number. | `3.14` |
| `BINARY_DOUBLE` | 64-bit floating point number. | `3.14159` |

Use `NUMBER(10,2)` for money-like values.

### Date and Time Data Types

| Data Type | Description | Example |
| --- | --- | --- |
| `DATE` | Stores date and time up to seconds. | `2026-05-31 10:30:00` |
| `TIMESTAMP` | Stores date and time with fractional seconds. | `2026-05-31 10:30:00.123` |
| `TIMESTAMP WITH TIME ZONE` | Timestamp with time zone information. | Time zone aware time |
| `INTERVAL YEAR TO MONTH` | Stores period of years and months. | `2 years 3 months` |
| `INTERVAL DAY TO SECOND` | Stores period of days, hours, minutes, seconds. | `3 days 04:30:00` |

### Binary and LOB Data Types

| Data Type | Description | Example |
| --- | --- | --- |
| `BLOB` | Binary large object. | Image, file bytes |
| `BFILE` | Pointer to binary file stored outside the database. | External file |
| `RAW(n)` | Raw binary data. | Small binary value |
| `LONG RAW` | Older binary type; usually avoided in new design. | Legacy binary data |

### Example Table

```sql
CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100),
    birth_date DATE,
    gpa NUMBER(3,2),
    profile_note CLOB
);
```

---

## 5. Oracle Objects: View, Synonym, Sequence, and Index

### View

A **view** is a saved SQL query that behaves like a virtual table.

```sql
CREATE VIEW active_students_view AS
SELECT student_id, student_name
FROM students
WHERE status = 'ACTIVE';
```

Use a view:

```sql
SELECT *
FROM active_students_view;
```

### Synonym

A **synonym** is an alternative name for a database object.

It can simplify object names or hide schema details.

```sql
CREATE SYNONYM stu FOR students;
```

Use synonym:

```sql
SELECT *
FROM stu;
```

### Sequence

A **sequence** generates numeric values automatically.

It is commonly used for primary key IDs.

```sql
CREATE SEQUENCE student_seq
START WITH 1
INCREMENT BY 1;
```

Use sequence:

```sql
INSERT INTO students (student_id, student_name)
VALUES (student_seq.NEXTVAL, 'Su Su');
```

### Index

An **index** improves search performance.

```sql
CREATE INDEX idx_students_name
ON students(student_name);
```

Index benefit:

```text
Without index: database may scan many rows.
With index: database can find matching rows faster.
```

### Object Summary

| Object | Purpose |
| --- | --- |
| **View** | Reusable virtual table from a query. |
| **Synonym** | Alternative name for a database object. |
| **Sequence** | Generates automatic numeric values. |
| **Index** | Improves query search performance. |

---

## 6. Programming in Oracle with PL/SQL

**PL/SQL** means **Procedural Language/SQL**.

It is Oracle's procedural extension to SQL.

SQL is mainly used for:

```text
Querying and changing data.
```

PL/SQL is used for:

```text
Variables, conditions, loops, procedures, functions, packages, and triggers.
```

### Basic PL/SQL Block

```sql
DECLARE
    v_message VARCHAR2(100);
BEGIN
    v_message := 'Hello PL/SQL';
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/
```

PL/SQL block parts:

| Part | Purpose |
| --- | --- |
| `DECLARE` | Optional section for variables. |
| `BEGIN` | Starts executable code. |
| `EXCEPTION` | Optional error-handling section. |
| `END;` | Ends the block. |
| `/` | Executes the block in many Oracle tools. |

### IF Statement

```sql
DECLARE
    v_score NUMBER := 85;
BEGIN
    IF v_score >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('Pass with distinction');
    ELSIF v_score >= 50 THEN
        DBMS_OUTPUT.PUT_LINE('Pass');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
/
```

### FOR LOOP

```sql
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;
END;
/
```

### Cursor FOR LOOP

```sql
BEGIN
    FOR rec IN (
        SELECT student_id, student_name
        FROM students
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.student_id || ' - ' || rec.student_name);
    END LOOP;
END;
/
```

---

## 7. PL/SQL Procedures, Functions, and Stored Procedures

### Procedure

A **procedure** is a named PL/SQL block that performs an action.

```sql
CREATE OR REPLACE PROCEDURE add_student (
    p_student_id IN NUMBER,
    p_student_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO students (student_id, student_name)
    VALUES (p_student_id, p_student_name);
END;
/
```

Run procedure:

```sql
BEGIN
    add_student(1, 'Aung Aung');
END;
/
```

### Function

A **function** is a named PL/SQL block that returns a value.

```sql
CREATE OR REPLACE FUNCTION calculate_bonus (
    p_salary IN NUMBER
) RETURN NUMBER AS
BEGIN
    RETURN p_salary * 0.10;
END;
/
```

Use function:

```sql
SELECT calculate_bonus(500000) AS bonus
FROM dual;
```

### Stored Procedure

A **stored procedure** is a procedure saved inside the database.

In Oracle, procedures and functions are stored database objects.

| Object | Returns Value? | Main Use |
| --- | --- | --- |
| **Procedure** | Usually no direct return value. | Perform an action such as insert/update. |
| **Function** | Yes. | Calculate and return a value. |
| **Stored procedure** | Stored in database. | Reusable business logic. |

---

## 8. Packages

A **package** groups related procedures, functions, variables, and types together.

A package has two parts:

| Part | Purpose |
| --- | --- |
| **Package specification** | Public interface; declares what can be used. |
| **Package body** | Implementation; contains actual code. |

### Package Specification

```sql
CREATE OR REPLACE PACKAGE student_pkg AS
    PROCEDURE add_student(p_student_id NUMBER, p_student_name VARCHAR2);
    FUNCTION get_student_count RETURN NUMBER;
END student_pkg;
/
```

### Package Body

```sql
CREATE OR REPLACE PACKAGE BODY student_pkg AS
    PROCEDURE add_student(p_student_id NUMBER, p_student_name VARCHAR2) AS
    BEGIN
        INSERT INTO students (student_id, student_name)
        VALUES (p_student_id, p_student_name);
    END;

    FUNCTION get_student_count RETURN NUMBER AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM students;

        RETURN v_count;
    END;
END student_pkg;
/
```

Use package:

```sql
BEGIN
    student_pkg.add_student(2, 'Kyaw Kyaw');
END;
/
```

**Key idea:** packages organize related database code and make large PL/SQL projects cleaner.

---

## 9. Triggers

A **trigger** is a PL/SQL block that automatically runs when a specific database event happens.

Common trigger events:

- `INSERT`
- `UPDATE`
- `DELETE`

Common trigger timing:

- `BEFORE`
- `AFTER`

### Example: Audit Trigger

```sql
CREATE TABLE student_audit (
    audit_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    student_id NUMBER,
    action_name VARCHAR2(20),
    action_date DATE
);
```

```sql
CREATE OR REPLACE TRIGGER trg_student_insert_audit
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_name, action_date)
    VALUES (:NEW.student_id, 'INSERT', SYSDATE);
END;
/
```

Explanation:

```text
When a new student is inserted,
the trigger automatically writes a record into student_audit.
```

### Trigger Notes

| Keyword | Meaning |
| --- | --- |
| `:NEW` | New value after insert/update. |
| `:OLD` | Old value before update/delete. |
| `FOR EACH ROW` | Trigger runs once for each affected row. |

Use triggers carefully:

- Good for audit logs.
- Good for enforcing some automatic rules.
- Can make debugging harder if overused.
- Should not hide too much business logic.

---

## 10. Summary Table

| Topic | Main Idea |
| --- | --- |
| Docker | Runs applications in containers. |
| Traditional deployment | Installs software directly on host system. |
| Docker deployment | Packages app and dependencies into containers. |
| Oracle architecture | Instance plus database files. |
| Oracle data types | Define what columns can store. |
| View | Saved query as virtual table. |
| Synonym | Alternative name for database object. |
| Sequence | Automatic number generator. |
| Index | Improves query performance. |
| PL/SQL | Oracle procedural language for database programming. |
| Procedure | Performs an action. |
| Function | Returns a value. |
| Package | Groups related PL/SQL code. |
| Trigger | Runs automatically on database events. |

---

## 11. Exercises

### Exercise 1: Docker

Answer:

1. What is Docker?
2. Why is Docker useful for database labs?
3. What is the difference between an image and a container?

### Exercise 2: Oracle Architecture

Match each component with its role:

| Component | Role |
| --- | --- |
| SGA |  |
| PGA |  |
| DBWR / DBWn |  |
| LGWR |  |
| Data files |  |
| Redo log files |  |

### Exercise 3: Oracle Objects

Write SQL to:

1. Create a view for active students.
2. Create a sequence for student IDs.
3. Create an index on student name.
4. Create a synonym for the students table.

### Exercise 4: PL/SQL

Write a PL/SQL block that:

1. Declares a score variable.
2. Uses `IF` to print `Pass` or `Fail`.
3. Uses a `FOR LOOP` to print numbers from 1 to 5.

### Exercise 5: Procedure and Function

Create:

1. A procedure that inserts a student.
2. A function that calculates a 10% bonus from salary.

---

## 12. Review Questions

1. What is Docker?
2. Why do developers use Docker?
3. What is the difference between traditional deployment and Docker deployment?
4. What is an Oracle instance?
5. What is an Oracle database?
6. What is the difference between SGA and PGA?
7. What are Oracle data files?
8. What is the purpose of redo logs?
9. What is `VARCHAR2` used for?
10. What is a view?
11. What is a synonym?
12. What is a sequence?
13. What is an index?
14. What is PL/SQL?
15. What is the purpose of an `IF` statement?
16. What is the purpose of a `FOR LOOP`?
17. What is the difference between a procedure and a function?
18. What is a package?
19. What is a trigger?
20. Why should triggers be used carefully?
