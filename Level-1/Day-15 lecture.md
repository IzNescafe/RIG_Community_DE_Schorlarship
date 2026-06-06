# Day 15 Lecture: Oracle Views

> Theme: a view provides a controlled and reusable way to display data from one or more database tables.

## Learning Goals

By the end of Day 15, students should be able to:

- Explain what a database view is.
- Compare simple views and complex views.
- Explain view stability and how views use base-table data.
- Create, replace, query, and drop Oracle views.
- Perform `INSERT`, `UPDATE`, and `DELETE` operations through an updatable view.
- Understand the `FORCE`, `NOFORCE`, `WITH CHECK OPTION`, and `WITH READ ONLY` options.
- Explain, create, refresh, and remove materialized views.

---

## Exam Recap

| Topic | Key Point |
| --- | --- |
| <span style="color:#2563eb"><strong>View</strong></span> | A stored SQL query that behaves like a virtual table. |
| <span style="color:#16a34a"><strong>Simple View</strong></span> | Usually based on one table and may allow DML operations. |
| <span style="color:#9333ea"><strong>Complex View</strong></span> | Uses multiple tables, joins, groups, or aggregate functions. |
| <span style="color:#ea580c"><strong>View Stability</strong></span> | A normal view stores its query definition, not a separate copy of the data. |

**Easy memory tip:** a table stores data; a normal view stores a query.

---

## 1. What Is a View?

A **view** is a named SQL query that displays data like a virtual table.

- It can retrieve data from one or more base tables.
- It can hide unnecessary or sensitive columns.
- It can simplify complex queries.
- It can provide users with controlled access to data.
- It normally stores only the query definition, not the result data.

```text
User queries the view
        |
        v
View runs its stored SELECT statement
        |
        v
Data is retrieved from the base table or tables
```

### Why Use Views?

| Reason | Explanation |
| --- | --- |
| **Security** | Hide sensitive columns such as salary or password data. |
| **Simplicity** | Save and reuse a complex query. |
| **Consistency** | Give users the same defined representation of data. |
| **Abstraction** | Hide some database-table complexity from users. |
| **Customized access** | Show different data to different users. |

---

## 2. View Stability

A normal Oracle view **does not store a separate copy of the data**. It stores the view definition, which is the `SELECT` statement used to create it.

- Data remains stored in the base tables.
- When base-table data changes, the view displays the latest matching data.
- If the required base table or column is removed, the view may become invalid.
- Oracle can revalidate an invalid view when its required objects become available again.

```text
Base-table data changes
          |
          v
Query the view again
          |
          v
View shows the latest matching data
```

> **Note:** a materialized view is different because it physically stores query results.

---

## 3. Simple View

A **simple view** is normally created from one table and does not contain complex operations.

Common characteristics:

- Uses one base table.
- Does not normally use aggregate functions.
- Does not normally use `GROUP BY`.
- Does not normally use `DISTINCT`.
- May allow `INSERT`, `UPDATE`, and `DELETE` operations.

### Create Simple View Syntax

```sql
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name
    [(column_alias, ...)]
AS
    SELECT column_name, ...
    FROM table_name
    [WHERE condition]
    [WITH CHECK OPTION]
    [WITH READ ONLY];
```

### Simple View Example

```sql
CREATE VIEW active_employee_view AS
SELECT
    employee_id,
    employee_name,
    department_id
FROM employees
WHERE status = 'ACTIVE';
```

Query the view:

```sql
SELECT *
FROM active_employee_view;
```

### Simple View with Column Aliases

Column aliases give the view's displayed columns clearer or different names.

#### Method 1: Aliases After the View Name

The number and order of aliases must match the columns in the `SELECT` list.

```sql
CREATE OR REPLACE VIEW employee_contact_view (
    id,
    full_name,
    email_address
) AS
SELECT
    employee_id,
    employee_name,
    email
FROM employees;
```

Query using the alias names:

```sql
SELECT
    id,
    full_name,
    email_address
FROM employee_contact_view;
```

#### Method 2: Aliases Inside the `SELECT`

```sql
CREATE OR REPLACE VIEW employee_contact_view AS
SELECT
    employee_id AS id,
    employee_name AS full_name,
    email AS email_address
FROM employees;
```

| Base-Table Column | View Column Alias |
| --- | --- |
| `employee_id` | `id` |
| `employee_name` | `full_name` |
| `email` | `email_address` |

**Easy memory tip:** aliases change the column names displayed by the view, not the original base-table column names.

### Updating a Simple View

An updatable simple view can modify data in its base table.

```sql
UPDATE active_employee_view
SET employee_name = 'Aung Min'
WHERE employee_id = 101;
```

The update affects the matching row in the `employees` base table.

---

## 4. Complex View

A **complex view** uses advanced query operations or data from multiple tables.

It may contain:

- Multiple tables.
- Joins.
- Aggregate functions such as `SUM`, `AVG`, or `COUNT`.
- `GROUP BY`.
- `DISTINCT`.
- Calculated columns.

### Complex View Example

```sql
CREATE VIEW department_salary_view AS
SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;
```

Query the view:

```sql
SELECT *
FROM department_salary_view;
```

Complex views are commonly read-only because Oracle may not be able to identify one base-table row to modify.

---

## 5. Simple View vs Complex View

| Feature | Simple View | Complex View |
| --- | --- | --- |
| Number of base tables | Usually one | One or more |
| Joins | Normally no | Often yes |
| Aggregate functions | No | May use aggregates |
| `GROUP BY` | No | May use `GROUP BY` |
| DML operations | Often possible | Often restricted |
| Main purpose | Filter or hide table data | Summarize or combine data |

---

## 6. Insert, Update, and Delete with a View

An **updatable view** allows DML operations to be performed through the view. Oracle applies the changes to the underlying base table because a normal view does not store its own data.

```text
INSERT, UPDATE, or DELETE through a view
                    |
                    v
          Base-table data changes
```

Use this view for the following examples:

```sql
CREATE OR REPLACE VIEW employee_dml_view AS
SELECT
    employee_id,
    employee_name,
    department_id,
    status
FROM employees;
```

### Insert Through a View

An `INSERT` through a view adds a new row to the base table.

```sql
INSERT INTO employee_dml_view (
    employee_id,
    employee_name,
    department_id,
    status
)
VALUES (
    104,
    'Mya Mya',
    20,
    'ACTIVE'
);
```

The new row is inserted into the `employees` table.

An insert may fail when:

- The view does not include a required base-table column.
- An omitted base-table column is `NOT NULL` and has no default value.
- The new row violates a primary key, foreign key, or other constraint.
- The row violates the view's `WITH CHECK OPTION` condition.

### Update Through a View

An `UPDATE` through a view changes the matching base-table row.

```sql
UPDATE employee_dml_view
SET
    employee_name = 'Mya Thiri',
    department_id = 30
WHERE employee_id = 104;
```

The matching row in the `employees` table is updated.

### Delete Through a View

A `DELETE` through a view removes the matching row from the base table.

```sql
DELETE FROM employee_dml_view
WHERE employee_id = 104;
```

The matching row is deleted from the `employees` table, not merely hidden from the view.

### DML Through a Filtered View

When a view contains a `WHERE` condition, DML can affect only rows visible through that view.

```sql
CREATE OR REPLACE VIEW active_employee_dml_view AS
SELECT employee_id, employee_name, department_id, status
FROM employees
WHERE status = 'ACTIVE'
WITH CHECK OPTION;
```

```sql
UPDATE active_employee_dml_view
SET employee_name = 'Aung Aung'
WHERE employee_id = 101;

DELETE FROM active_employee_dml_view
WHERE employee_id = 101;
```

The update is allowed if the employee remains active. The delete removes the visible active employee from the base table.

### When View DML Is Restricted

Oracle commonly restricts DML when a view contains:

- Aggregate functions such as `SUM`, `AVG`, or `COUNT`.
- `GROUP BY`.
- `DISTINCT`.
- Set operators such as `UNION`, `INTERSECT`, or `MINUS`.
- Calculated columns that do not directly map to a base-table column.
- Multiple tables where Oracle cannot determine which base table to modify.
- `WITH READ ONLY`.

| DML Operation | Effect Through an Updatable View |
| --- | --- |
| `INSERT` | Adds a row to the base table. |
| `UPDATE` | Changes a matching base-table row. |
| `DELETE` | Removes a matching row from the base table. |

**Easy memory tip:** view DML changes the base table because a normal view stores no data.

### Rules for Performing DML Operations on a View

#### Rule 1: Rows Cannot Be Deleted from a View Containing Certain Features

You cannot delete rows through a view if the view contains any of the following:

- Group functions such as `SUM`, `AVG`, `COUNT`, `MAX`, or `MIN`.
- A `GROUP BY` clause.
- The `DISTINCT` keyword.
- The pseudocolumn `ROWNUM`.

Example of a view that does **not** allow `DELETE`:

```sql
CREATE OR REPLACE VIEW department_employee_count_view AS
SELECT
    department_id,
    COUNT(employee_id) AS employee_count
FROM employees
GROUP BY department_id;
```

This operation fails:

```sql
DELETE FROM department_employee_count_view
WHERE department_id = 20;
```

It fails because each row in the view represents a summarized group, not one identifiable row in the `employees` table.

| View Feature | Can Delete Through View? | Reason |
| --- | --- | --- |
| Simple columns from one table | Usually yes | Each view row can map to a base-table row. |
| Group function | No | The result is calculated from multiple rows. |
| `GROUP BY` | No | Each view row represents a group. |
| `DISTINCT` | No | Duplicate base-table rows may appear as one view row. |
| `ROWNUM` | No | It is a generated pseudocolumn. |

**Rule 1 memory tip:** `DELETE` requires each view row to identify a real base-table row.

---

## 7. Oracle View Options

### `OR REPLACE`

Recreates an existing view without dropping it first.

```sql
CREATE OR REPLACE VIEW active_employee_view AS
SELECT employee_id, employee_name, department_id, hire_date
FROM employees
WHERE status = 'ACTIVE';
```

### `FORCE`

The `FORCE` option tells Oracle to create a view even when its required base table does not exist or cannot currently be accessed.

- The view definition is created.
- The view normally has an `INVALID` status.
- The invalid view cannot be queried successfully.
- The view can become valid after the missing object or privilege becomes available.
- It is useful when database objects must be created in a planned deployment order.

```sql
CREATE FORCE VIEW future_employee_view AS
SELECT employee_id, employee_name
FROM future_employees;
```

At this point, Oracle creates `future_employee_view`, but querying it fails if `future_employees` does not exist.

### Checking the View Status

```sql
SELECT
    object_name,
    status
FROM user_objects
WHERE object_name = 'FUTURE_EMPLOYEE_VIEW';
```

Possible statuses:

| Status | Meaning |
| --- | --- |
| `VALID` | The view can successfully access its required objects. |
| `INVALID` | The view has missing or inaccessible dependencies. |

### Making a Forced View Valid

Create the missing base table:

```sql
CREATE TABLE future_employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100)
);
```

Compile the view:

```sql
ALTER VIEW future_employee_view COMPILE;
```

Query the view:

```sql
SELECT *
FROM future_employee_view;
```

### `FORCE` vs `NOFORCE`

| Feature | `FORCE` | `NOFORCE` |
| --- | --- | --- |
| Base object must exist during creation | No | Yes |
| Creates an invalid view | Yes, when dependencies are unavailable | No |
| Default Oracle behavior | No | Yes |
| Common use | Planned deployments with objects created later | Normal view creation |

**Easy memory tip:** `FORCE` creates the view now and allows its required objects to be fixed later.

### `NOFORCE`

The `NOFORCE` option tells Oracle to create a view only when all required base objects exist and are accessible.

- Oracle validates the view definition during creation.
- Required tables, views, and columns must exist.
- The user must have the required privileges.
- If validation fails, Oracle does not create the view.
- `NOFORCE` is Oracle's default view-creation behavior.

### Successful `NOFORCE` Example

This succeeds when the `employees` table and selected columns exist:

```sql
CREATE NOFORCE VIEW employee_name_view AS
SELECT employee_id, employee_name
FROM employees;
```

Because `NOFORCE` is the default, this statement behaves the same way:

```sql
CREATE VIEW employee_name_view AS
SELECT employee_id, employee_name
FROM employees;
```

### Failed `NOFORCE` Example

This fails when `missing_employees` does not exist:

```sql
CREATE NOFORCE VIEW missing_employee_view AS
SELECT employee_id, employee_name
FROM missing_employees;
```

Oracle reports an error and does not create `missing_employee_view`.

### When to Use `NOFORCE`

- When creating views during normal database development.
- When required tables and columns should already exist.
- When errors in object names or permissions must be detected immediately.
- When you do not want invalid views stored in the database.

| Question | `NOFORCE` Answer |
| --- | --- |
| Must the base table exist? | Yes |
| Must selected columns exist? | Yes |
| Are required privileges needed? | Yes |
| Can an invalid view be created? | No |
| Is it Oracle's default? | Yes |

**Easy memory tip:** `NOFORCE` checks first and creates the view only when everything required is ready.

### `WITH CHECK OPTION`

`WITH CHECK OPTION` ensures that every row inserted or updated through a view continues to satisfy the view's `WHERE` condition.

Without this option, a user may update a visible row so that it no longer belongs to the view. With this option, Oracle rejects that change.

```sql
CREATE OR REPLACE VIEW active_employee_view AS
SELECT employee_id, employee_name, status
FROM employees
WHERE status = 'ACTIVE'
WITH CHECK OPTION;
```

#### Valid Operations

These operations succeed because the resulting rows still satisfy `status = 'ACTIVE'`:

```sql
UPDATE active_employee_view
SET employee_name = 'Aung Min'
WHERE employee_id = 101;

INSERT INTO active_employee_view (
    employee_id,
    employee_name,
    status
)
VALUES (
    102,
    'Su Su',
    'ACTIVE'
);
```

#### Invalid Operations

These operations fail because the resulting rows would not satisfy the view condition:

```sql
UPDATE active_employee_view
SET status = 'INACTIVE'
WHERE employee_id = 101;

INSERT INTO active_employee_view (
    employee_id,
    employee_name,
    status
)
VALUES (
    103,
    'Kyaw Kyaw',
    'INACTIVE'
);
```

### Naming the Check Option Constraint

Oracle allows the check-option constraint to be given a name:

```sql
CREATE OR REPLACE VIEW active_employee_view AS
SELECT employee_id, employee_name, status
FROM employees
WHERE status = 'ACTIVE'
WITH CHECK OPTION CONSTRAINT active_employee_view_ck;
```

### Check Option Recap

| Operation Through the View | Result |
| --- | --- |
| Update a non-filtered column | Allowed if the row remains visible in the view. |
| Update `status` to `'ACTIVE'` | Allowed because the row satisfies the condition. |
| Update `status` to `'INACTIVE'` | Rejected because the row would leave the view. |
| Insert a row with `'ACTIVE'` status | Allowed if all other DML requirements are met. |
| Insert a row with `'INACTIVE'` status | Rejected because the row does not satisfy the condition. |
| Delete a visible row | Allowed on an otherwise updatable view. |

**Easy memory tip:** `WITH CHECK OPTION` allows changes only when the resulting row remains visible through the view.

### `WITH READ ONLY`

Prevents users from performing `INSERT`, `UPDATE`, or `DELETE` operations through the view.

```sql
CREATE OR REPLACE VIEW employee_read_only_view AS
SELECT employee_id, employee_name, department_id
FROM employees
WITH READ ONLY;
```

---

## 8. Managing Views

### Show the View Definition

```sql
SELECT text
FROM user_views
WHERE view_name = 'ACTIVE_EMPLOYEE_VIEW';
```

### Show All Views Owned by the Current User

```sql
SELECT view_name
FROM user_views
ORDER BY view_name;
```

### Removing a View

Use `DROP VIEW` to remove a normal view from the database.

```sql
DROP VIEW active_employee_view;
```

- It removes only the view definition.
- It does not remove or change data in the base tables.
- It does not remove the base tables.
- Objects that depend on the removed view may become invalid.
- The view can be recreated later using `CREATE VIEW`.

```text
DROP VIEW
    |
    +-- Removes view definition
    +-- Keeps base tables
    +-- Keeps base-table data
```

### Removing a View with Dependencies

Oracle supports `CASCADE CONSTRAINTS` when constraints depend on the view:

```sql
DROP VIEW active_employee_view CASCADE CONSTRAINTS;
```

| Command | Purpose |
| --- | --- |
| `DROP VIEW view_name;` | Removes the view definition. |
| `DROP VIEW view_name CASCADE CONSTRAINTS;` | Removes the view and dependent referential constraints. |

**Easy memory tip:** dropping a normal view removes the saved query, not the base-table data.

---

## 9. Materialized View

A **materialized view** is a database object that physically stores the result of a query.

Unlike a normal view, a materialized view:

- Stores query-result data.
- Uses database storage space.
- Can improve the performance of expensive queries.
- May contain older data until it is refreshed.
- Is commonly used for reporting, summaries, and data warehouses.

```text
Normal View
    = Stores query definition
    = Reads current base-table data when queried

Materialized View
    = Stores query definition and query-result data
    = Must be refreshed to receive newer base-table data
```

### Why Use Materialized Views?

Materialized views are used when reading a previously calculated result is more efficient than repeatedly running an expensive query.

| Use Case | How a Materialized View Helps |
| --- | --- |
| **Faster reporting** | Stores report results so users do not repeatedly run complex joins and calculations. |
| **Data warehouse aggregation** | Precalculates totals, averages, counts, and grouped summaries from large datasets. |
| **Executive dashboards** | Provides fast access to key performance indicators and summarized business data. |
| **Reduce database load** | Reduces repeated work on busy base tables and lowers CPU and query-processing demand. |
| **Distributed databases** | Stores a local copy of remote data, reducing network requests and improving availability. |

```text
Large Base Tables
      |
      v
Complex Join and Aggregation
      |
      v
Materialized View Stores the Result
      |
      v
Reports and Dashboards Read Quickly
```

### Strengths of Materialized Views

| Strength | Explanation |
| --- | --- |
| **Fast query performance** | Users read stored results instead of recalculating complex queries. |
| **Reduced database workload** | Repeated reports do not continuously scan and join large base tables. |
| **Efficient aggregation** | Summaries such as daily sales, monthly totals, and customer counts can be precomputed. |
| **Predictable report speed** | Stored results provide more consistent response times for dashboards and reports. |
| **Supports indexes** | Indexes can be created on materialized views to improve access further. |
| **Supports query rewrite** | Oracle may automatically use a suitable materialized view to answer a query faster. |
| **Reduced network traffic** | Local stored copies reduce the need to repeatedly retrieve remote data. |
| **Improved remote-data availability** | Previously refreshed data may remain available when a remote source is slow or unavailable. |
| **Flexible refresh options** | Data can be refreshed completely, incrementally, on demand, or on commit. |

> **Important:** materialized views improve reading performance by using extra storage and accepting that data may not always be fully current.

### Weaknesses of Materialized Views

| Weakness | Explanation |
| --- | --- |
| **Data can become outdated** | Changes in base tables are not visible until the materialized view is refreshed. |
| **Additional storage usage** | Query-result data and any indexes require extra disk space. |
| **Refresh overhead** | Refreshing consumes CPU, memory, disk I/O, and sometimes network bandwidth. |
| **Maintenance complexity** | Refresh schedules, dependencies, logs, indexes, and failures must be managed. |
| **Slow complete refresh** | A complete refresh may rerun an expensive query and rebuild all stored results. |
| **Fast refresh requirements** | Fast refresh often requires materialized-view logs and has query-design restrictions. |
| **Base-table DML overhead** | `ON COMMIT` refreshes and materialized-view logs can slow base-table transactions. |
| **Temporary inconsistency** | Different materialized views may show data from different refresh times. |
| **Dependency risk** | Changes to base tables, columns, or privileges may invalidate the materialized view. |
| **Not suitable for real-time data** | It may be inappropriate when users require the latest committed data immediately. |

### When Not to Use a Materialized View

- When every query must show the latest committed data.
- When the source tables change frequently but the stored result is rarely queried.
- When storage space is limited.
- When refresh cost is greater than the performance benefit.
- When the query is already simple and fast.
- When maintaining refresh schedules and dependencies would create unnecessary complexity.

### Strengths vs Weaknesses

| Strength | Related Weakness |
| --- | --- |
| Faster report queries | Results may be outdated. |
| Reduced repeated query work | Refresh operations create their own workload. |
| Stored aggregation results | Stored results require additional disk space. |
| Local copy of remote data | Refreshing remote data can use network bandwidth. |
| Automatic `ON COMMIT` refresh | Base-table transactions may become slower. |

**Easy memory tip:** materialized views exchange extra storage, refresh work, and possible stale data for faster reads.

### Normal View vs Materialized View

| Feature | Normal View | Materialized View |
| --- | --- | --- |
| Basic definition | A stored query that behaves like a virtual table. | A stored query whose results are physically saved. |
| Stores query definition | Yes | Yes |
| Physically stores result data | No | Yes |
| Additional storage required | Very little; stores mainly the definition | Yes; stores the query-result rows |
| Data freshness | Shows current base-table data whenever queried | May show older data until refreshed |
| Refresh required | No | Yes, unless configured to refresh automatically |
| Query execution | Executes the underlying query each time | Reads previously stored result data |
| Query performance | Can be slower for complex queries | Often faster for expensive queries |
| Effect of base-table changes | Visible immediately on the next query | Visible only after refresh |
| DML through the object | Possible for some updatable views | Normally used for reading, not direct DML |
| Indexes | Cannot create indexes directly on a normal view | Can have indexes because results are stored |
| Common use | Security and query simplification | Reporting and performance improvement |
| Typical environment | Transactional applications | Reporting systems and data warehouses |
| Creation command | `CREATE VIEW` | `CREATE MATERIALIZED VIEW` |
| Removal command | `DROP VIEW` | `DROP MATERIALIZED VIEW` |

### Example of Data Freshness

```text
Base-table data is updated
        |
        +--> Normal View
        |       Shows the change on the next query
        |
        +--> Materialized View
                Shows the old result until refreshed
```

### When to Use Each One

| Requirement | Better Choice | Reason |
| --- | --- | --- |
| Always show the latest data | Normal view | It reads current base-table data. |
| Hide sensitive columns | Normal view | It provides controlled data access. |
| Simplify a reusable query | Normal view | It saves the query definition. |
| Speed up an expensive report | Materialized view | It stores the calculated result. |
| Reduce repeated joins and aggregations | Materialized view | The complex result can be precomputed. |
| Build data-warehouse summaries | Materialized view | It supports stored reporting data. |

### Important Trade-Off

```text
Normal View:
Fresh data, but complex queries may take longer.

Materialized View:
Faster query results, but stored data may become outdated.
```

**Exam answer:** a normal view stores only the query definition and always retrieves current data. A materialized view physically stores the query result for faster reading, but it must be refreshed to show newer base-table changes.

### Creating a Materialized View

```sql
CREATE MATERIALIZED VIEW department_salary_mv
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT
    department_id,
    COUNT(employee_id) AS employee_count,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;
```

| Clause | Meaning |
| --- | --- |
| `BUILD IMMEDIATE` | Creates and fills the materialized view immediately. |
| `BUILD DEFERRED` | Creates it now but fills it during a later refresh. |
| `REFRESH COMPLETE` | Runs the complete query again during refresh. |
| `REFRESH FAST` | Applies only changes when the required materialized-view logs exist. |
| `REFRESH FORCE` | Attempts fast refresh, then uses complete refresh if necessary. |
| `ON DEMAND` | Refreshes only when manually requested or scheduled. |
| `ON COMMIT` | Refreshes when changes to the base table are committed. |

### Querying a Materialized View

```sql
SELECT *
FROM department_salary_mv;
```

It can be queried like a table or normal view.

### Refreshing a Materialized View

Refresh manually using the Oracle supplied package:

```sql
BEGIN
    DBMS_MVIEW.REFRESH('DEPARTMENT_SALARY_MV');
END;
/
```

After refreshing, the stored result reflects newer base-table data.

### Removing a Materialized View

Use `DROP MATERIALIZED VIEW`, not `DROP VIEW`:

```sql
DROP MATERIALIZED VIEW department_salary_mv;
```

Dropping the materialized view removes its definition and stored result data. It does not remove data from the original base tables.

| Object to Remove | Correct Command |
| --- | --- |
| Normal view | `DROP VIEW view_name;` |
| Materialized view | `DROP MATERIALIZED VIEW materialized_view_name;` |

**Easy memory tip:** a normal view stores a query; a materialized view stores the query result.

---

## 10. Oracle Sequence

A **sequence** is an Oracle database object that automatically generates unique numeric values.

Sequences are commonly used to generate:

- Primary-key values.
- Employee IDs.
- Customer IDs.
- Order numbers.
- Transaction numbers.

```text
Sequence
   |
   v
Generates numbers: 1, 2, 3, 4, ...
   |
   v
Numbers can be inserted into a table
```

### Why Use a Sequence?

| Benefit | Explanation |
| --- | --- |
| **Automatic numbering** | Oracle generates the next number automatically. |
| **Unique values** | Helps generate unique identifiers for table rows. |
| **Multi-user support** | Multiple users can request numbers without manually finding the highest ID. |
| **Independent object** | A sequence is not permanently connected to one specific table. |
| **Customizable** | It can increment, cycle, cache values, and define minimum or maximum values. |

### Create Sequence Syntax

```sql
CREATE SEQUENCE sequence_name
START WITH initial_value
INCREMENT BY increment_value
[MINVALUE minimum_value | NOMINVALUE]
[MAXVALUE maximum_value | NOMAXVALUE]
[CYCLE | NOCYCLE]
[CACHE cache_size | NOCACHE];
```

### Create Sequence Example

```sql
CREATE SEQUENCE employee_seq
START WITH 1001
INCREMENT BY 1
NOCYCLE
CACHE 20;
```

This sequence begins at `1001` and increases by `1`.

### `NEXTVAL` and `CURRVAL`

| Pseudocolumn | Purpose |
| --- | --- |
| `sequence_name.NEXTVAL` | Generates and returns the next sequence value. |
| `sequence_name.CURRVAL` | Returns the latest sequence value generated in the current session. |

Get the next value:

```sql
SELECT employee_seq.NEXTVAL
FROM dual;
```

Get the current session value:

```sql
SELECT employee_seq.CURRVAL
FROM dual;
```

`CURRVAL` cannot be used in a session until `NEXTVAL` has been used at least once.

### Insert Data Using a Sequence

```sql
INSERT INTO employees (
    employee_id,
    employee_name,
    status
)
VALUES (
    employee_seq.NEXTVAL,
    'Aung Aung',
    'ACTIVE'
);
```

### Alter a Sequence

```sql
ALTER SEQUENCE employee_seq
INCREMENT BY 5
NOCACHE;
```

Oracle does not allow the original `START WITH` value to be changed using `ALTER SEQUENCE`.

### Remove a Sequence

```sql
DROP SEQUENCE employee_seq;
```

Dropping a sequence does not remove rows or values that were already inserted into tables.

### Important Sequence Rules

- Sequence numbers may contain gaps.
- A rolled-back transaction does not return a used sequence number.
- Multiple tables can use the same sequence.
- A sequence does not automatically insert values; `NEXTVAL` must be used.
- `CYCLE` restarts the sequence after reaching its limit.
- `NOCYCLE` stops generating values after reaching its limit.
- `CACHE` improves performance by keeping sequence values in memory.

**Easy memory tip:** `NEXTVAL` creates the next number; `CURRVAL` shows the current session's latest number.

---

## Summary

| Concept | Exam Definition |
| --- | --- |
| **View** | A named query that behaves like a virtual table. |
| **Base table** | The table from which a view retrieves its data. |
| **Simple view** | A view normally based on one table without complex operations. |
| **Complex view** | A view using joins, multiple tables, grouping, or aggregates. |
| **View stability** | A view stores its definition and shows current matching base-table data. |
| **View DML** | `INSERT`, `UPDATE`, and `DELETE` through an updatable view modify its base table. |
| **Drop view** | Removes a normal view definition without removing base-table data. |
| **Materialized view** | Physically stores query-result data and must be refreshed. |
| **Materialized-view strength** | Improves reporting performance and reduces repeated database work. |
| **Materialized-view weakness** | Requires extra storage and refresh work, and its data may become outdated. |
| **Sequence** | An Oracle object that automatically generates numeric values. |
| **`NEXTVAL`** | Generates and returns the next sequence number. |
| **`CURRVAL`** | Returns the current session's latest generated sequence number. |
| **`OR REPLACE`** | Changes an existing view definition. |
| **`FORCE`** | Creates a view even when required objects are unavailable. |
| **`NOFORCE`** | Creates a view only when required objects are available. |
| **`WITH CHECK OPTION`** | Ensures DML through the view follows its condition. |
| **`WITH READ ONLY`** | Prevents DML operations through the view. |

## Review Questions

1. What is a database view?
2. Does a normal view store a separate copy of data?
3. What is the difference between a simple view and a complex view?
4. When can a simple view be updated?
5. Why are complex views often not updatable?
6. What is the purpose of `OR REPLACE`?
7. What is the difference between `FORCE` and `NOFORCE`?
8. What does `WITH CHECK OPTION` prevent?
9. What does `WITH READ ONLY` do?
10. What happens to base-table data when a view is dropped?
11. Where is a row stored when it is inserted through a normal view?
12. Why are aggregate views commonly not updatable?
13. What happens to base-table data when a normal view is removed?
14. What is the difference between a normal view and a materialized view?
15. Why must a materialized view be refreshed?
16. Which command removes a materialized view?
17. How can a materialized view reduce database load?
18. Why are materialized views useful in distributed databases?
19. What are the main weaknesses of a materialized view?
20. When should a materialized view not be used?
21. What is an Oracle sequence?
22. What is the difference between `NEXTVAL` and `CURRVAL`?
23. Why can sequence numbers contain gaps?

---

## နောက်ဆုံးမှတ်ထားရန် အရေးကြီးသောအချက်များ

| အကြောင်းအရာ | အရေးကြီးသော မှတ်ချက် |
| --- | --- |
| **View** | View သည် virtual table တစ်ခုဖြစ်ပြီး ပုံမှန်အားဖြင့် data ကို သီးခြားသိမ်းထားခြင်းမရှိပါ။ `SELECT` query definition ကိုသာ သိမ်းထားသည်။ |
| **Base Table** | View မှ ပြသသော data အစစ်များကို base table တွင် သိမ်းထားသည်။ |
| **Simple View** | ပုံမှန်အားဖြင့် table တစ်ခုတည်းအပေါ် အခြေခံထားပြီး DML ပြုလုပ်နိုင်ခြေရှိသည်။ |
| **Complex View** | Join, aggregate function, `GROUP BY` သို့မဟုတ် table များစွာပါဝင်သောကြောင့် DML ပြုလုပ်ရန် ကန့်သတ်ချက်များရှိတတ်သည်။ |
| **Column Alias** | Alias သည် view တွင် ပြသသော column အမည်ကိုသာ ပြောင်းလဲပြီး base-table column အမည်ကို မပြောင်းလဲပါ။ |
| **`OR REPLACE`** | ရှိပြီးသား view ကို `DROP` မလုပ်ဘဲ definition အသစ်ဖြင့် ပြန်လည်ဖန်တီးသည်။ |
| **`FORCE`** | Base object မရှိသေးလျှင်လည်း view ကို invalid အခြေအနေဖြင့် ဖန်တီးခွင့်ပြုသည်။ |
| **`NOFORCE`** | လိုအပ်သော base object များရှိမှသာ view ကို ဖန်တီးသည်။ Oracle ၏ default ဖြစ်သည်။ |
| **`WITH CHECK OPTION`** | View condition နှင့် မကိုက်ညီသွားစေသော `INSERT` သို့မဟုတ် `UPDATE` ကို တားဆီးသည်။ |
| **`WITH READ ONLY`** | View မှတစ်ဆင့် `INSERT`, `UPDATE`, `DELETE` ပြုလုပ်ခြင်းကို တားဆီးသည်။ |

### View မှတစ်ဆင့် DML ပြုလုပ်သောအခါ

- View မှတစ်ဆင့် `INSERT` လုပ်လျှင် row အသစ်ကို **base table** ထဲသို့ ထည့်သည်။
- View မှတစ်ဆင့် `UPDATE` လုပ်လျှင် **base-table row** ကို ပြင်ဆင်သည်။
- View မှတစ်ဆင့် `DELETE` လုပ်လျှင် row ကို view မှ ဖျောက်ရုံမဟုတ်ဘဲ **base table မှ အမှန်တကယ်ဖျက်သည်**။
- `WITH CHECK OPTION` ပါသော view တွင် ပြင်ဆင်ပြီးနောက် row သည် view condition နှင့် ဆက်လက်ကိုက်ညီနေရမည်။
- `WITH READ ONLY` ပါသော view တွင် DML လုံးဝပြုလုပ်၍မရပါ။

### DML ပြုလုပ်၍မရနိုင်သော အခြေအနေများ

View တွင် အောက်ပါအချက်များပါဝင်လျှင် DML ပြုလုပ်ရန် ကန့်သတ်ချက်ရှိနိုင်သည်။

- `SUM`, `AVG`, `COUNT`, `MAX`, `MIN` ကဲ့သို့သော aggregate functions
- `GROUP BY`
- `DISTINCT`
- `ROWNUM`
- `UNION`, `INTERSECT`, `MINUS`
- Base-table column နှင့် တိုက်ရိုက်မချိတ်ဆက်သော calculated columns
- ပြင်ဆင်ရမည့် base table ကို Oracle က မဆုံးဖြတ်နိုင်သော joins

> **စာမေးပွဲအတွက် အလွယ်မှတ်ရန်:** ပုံမှန် View သည် data မသိမ်းပါ။ View မှတစ်ဆင့် DML ပြုလုပ်လျှင် base table ကို ပြောင်းလဲခြင်းဖြစ်သည်။
