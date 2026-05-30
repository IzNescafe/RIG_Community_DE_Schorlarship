# Day 6 Lecture: SQL Querying, Joins, Set Theory, and Views

> Theme: SQL queries become powerful when we understand clauses, filtering, grouping, joins, set operations, and views.

## Learning Goals

By the end of Day 6, students should be able to:

- Explain `sql_safe_updates` mode in MySQL.
- Write SQL using the correct clause order.
- Understand selection and projection.
- Apply set theory ideas such as intersection, difference, and cross join.
- Use `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`.
- Use aggregate functions with `GROUP BY` and `HAVING`.
- Sort results using `ORDER BY ASC` and `DESC`.
- Explain what a SQL view is and why views are useful.

---

## Exam Recap Guide

<table>
<tr>
<td><strong><span style="color:#2563eb">Blue</span></strong></td>
<td>Core definitions and concepts</td>
</tr>
<tr>
<td><strong><span style="color:#16a34a">Green</span></strong></td>
<td>Processes, workflows, and step-by-step logic</td>
</tr>
<tr>
<td><strong><span style="color:#ea580c">Orange</span></strong></td>
<td>SQL syntax, commands, formulas, and examples</td>
</tr>
<tr>
<td><strong><span style="color:#dc2626">Red</span></strong></td>
<td>Risks, mistakes, anomalies, and warnings</td>
</tr>
</table>

### Quick Topic Map

| Color | Topic | What to Recap Before Exam |
| --- | --- | --- |
| <span style="color:#2563eb">&#9679;</span> | 1. SQL Safe Updates | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#16a34a">&#9679;</span> | 2. SQL Syntax Structure | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#9333ea">&#9679;</span> | 3. Selection and Projection | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#ea580c">&#9679;</span> | 4. Set Theory in SQL | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#dc2626">&#9679;</span> | 5. Intersection | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#0891b2">&#9679;</span> | 6. Difference | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#4f46e5">&#9679;</span> | 7. Cross Join | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#65a30d">&#9679;</span> | 8. SQL Joins | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#2563eb">&#9679;</span> | 9. Aggregate Functions | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#16a34a">&#9679;</span> | 10. ORDER BY | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#9333ea">&#9679;</span> | 11. View Concept | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#ea580c">&#9679;</span> | 12. Full Query Example | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#dc2626">&#9679;</span> | 13. Exercises | Review definitions, tables, examples, workflows, and key ideas. |
| <span style="color:#0891b2">&#9679;</span> | 14. Review Questions | Review definitions, tables, examples, workflows, and key ideas. |

### Last-Minute Checklist

- Read each **Key idea** line first.
- Memorize the main terms and compare similar concepts.
- Re-run or rewrite the SQL examples by hand where SQL is included.
- Use the review questions at the end as mock exam prompts.

---

## 1. SQL Safe Updates

MySQL has a safety setting called `sql_safe_updates`.

It helps prevent accidental `UPDATE` or `DELETE` commands that affect too many rows.

### Check Current Setting

```sql
SELECT @@SQL_SAFE_UPDATES;
```

### Turn Safe Updates Off

```sql
SET SQL_SAFE_UPDATES = 0;
```

When `sql_safe_updates = 0`, MySQL allows updates and deletes even without key-based conditions.

Example:

```sql
UPDATE products
SET price = price + 1000;
```

This updates every row, so it can be dangerous.

### Turn Safe Updates On

```sql
SET SQL_SAFE_UPDATES = 1;
```

When `sql_safe_updates = 1`, MySQL is stricter. It may block `UPDATE` or `DELETE` statements that do not use a key column or a `LIMIT`.

Safer example:

```sql
UPDATE products
SET price = price + 1000
WHERE product_id = 1;
```

**Key idea:** safe update mode protects beginners and production databases from accidental mass updates.

---

## 2. SQL Syntax Structure

SQL clauses must be written in the correct order.

Basic structure:

```sql
SELECT column_list
FROM table_name
WHERE condition
GROUP BY column_name
HAVING group_condition
ORDER BY column_name ASC;
```

### SQL Clause Order

| Clause | Purpose |
| --- | --- |
| `SELECT` | Chooses which columns or expressions to show. |
| `FROM` | Chooses the table or tables to read from. |
| `WHERE` | Filters rows before grouping. |
| `GROUP BY` | Groups rows that have the same value. |
| `HAVING` | Filters groups after aggregation. |
| `ORDER BY` | Sorts the final result. |

Memory trick:

```text
SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
```

Example:

```sql
SELECT category, COUNT(*) AS total_products
FROM products
WHERE price > 0
GROUP BY category
HAVING COUNT(*) >= 2
ORDER BY total_products DESC;
```

---

## 3. Selection and Projection

Selection and projection are relational database concepts.

### Selection

**Selection** means choosing rows.

In SQL, selection is done with `WHERE`.

```sql
SELECT *
FROM students
WHERE city = 'Yangon';
```

This selects only students from Yangon.

### Projection

**Projection** means choosing columns.

In SQL, projection is done with `SELECT`.

```sql
SELECT student_name, email
FROM students;
```

This shows only the `student_name` and `email` columns.

### Selection + Projection

```sql
SELECT student_name, email
FROM students
WHERE city = 'Yangon';
```

This chooses specific columns and specific rows.

---

## 4. Set Theory in SQL

SQL is based on relational theory, which is closely related to set theory.

Common set ideas:

| Set Concept | SQL Idea |
| --- | --- |
| Union | Combine results. |
| Intersection | Find common rows. |
| Difference | Find rows in one result but not another. |
| Cartesian product | Combine every row from one table with every row from another table. |

---

## 5. Intersection

**Intersection** returns values that exist in both sets.

Set idea:

```text
A = {1, 2, 3}
B = {2, 3, 4}
A intersection B = {2, 3}
```

SQL example using `INNER JOIN`:

```sql
SELECT students.student_id, students.student_name
FROM students
INNER JOIN enrollments
ON students.student_id = enrollments.student_id;
```

This returns students who have enrollment records.

SQL example using `IN`:

```sql
SELECT student_id, student_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
);
```

---

## 6. Difference

**Difference** returns values that exist in one set but not another.

Set idea:

```text
A = {1, 2, 3}
B = {2, 3, 4}
A difference B = {1}
```

SQL example using `LEFT JOIN`:

```sql
SELECT students.student_id, students.student_name
FROM students
LEFT JOIN enrollments
ON students.student_id = enrollments.student_id
WHERE enrollments.student_id IS NULL;
```

This returns students who are not enrolled in any course.

SQL example using `NOT IN`:

```sql
SELECT student_id, student_name
FROM students
WHERE student_id NOT IN (
    SELECT student_id
    FROM enrollments
);
```

---

## 7. Cross Join

A **cross join** returns the Cartesian product of two tables.

This means every row from the first table is matched with every row from the second table.

Example:

```text
students = 3 rows
courses  = 4 rows

cross join result = 3 x 4 = 12 rows
```

SQL syntax:

```sql
SELECT students.student_name, courses.course_name
FROM students
CROSS JOIN courses;
```

Use cross joins carefully because the result can become very large.

---

## 8. SQL Joins

Joins combine rows from two or more tables using related columns.

Example tables:

```text
students(student_id, student_name)
enrollments(enrollment_id, student_id, course_id)
courses(course_id, course_name)
```

### Inner Join

An **inner join** returns only matching rows from both tables.

```sql
SELECT students.student_name, courses.course_name
FROM enrollments
INNER JOIN students
ON enrollments.student_id = students.student_id
INNER JOIN courses
ON enrollments.course_id = courses.course_id;
```

Use `INNER JOIN` when you only want matching records.

### Left Join

A **left join** returns all rows from the left table and matching rows from the right table.

If no match exists, the right table columns return `NULL`.

```sql
SELECT students.student_name, enrollments.course_id
FROM students
LEFT JOIN enrollments
ON students.student_id = enrollments.student_id;
```

Use `LEFT JOIN` when you want all records from the first table.

### Right Join

A **right join** returns all rows from the right table and matching rows from the left table.

```sql
SELECT students.student_name, enrollments.course_id
FROM students
RIGHT JOIN enrollments
ON students.student_id = enrollments.student_id;
```

Use `RIGHT JOIN` when you want all records from the second table.

### Join Summary

| Join Type | Returns |
| --- | --- |
| `INNER JOIN` | Only matching rows from both tables. |
| `LEFT JOIN` | All rows from the left table, plus matching rows from the right table. |
| `RIGHT JOIN` | All rows from the right table, plus matching rows from the left table. |
| `CROSS JOIN` | Every combination of rows from both tables. |

---

## 9. Aggregate Functions

Aggregate functions calculate one result from many rows.

| Function | Meaning |
| --- | --- |
| `COUNT()` | Counts rows. |
| `SUM()` | Adds values. |
| `AVG()` | Calculates average. |
| `MIN()` | Finds minimum value. |
| `MAX()` | Finds maximum value. |

Example:

```sql
SELECT COUNT(*) AS total_students
FROM students;
```

### GROUP BY

`GROUP BY` groups rows before applying aggregate functions.

```sql
SELECT course_id, COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id;
```

### HAVING

`HAVING` filters grouped results after aggregation.

Use `HAVING` when filtering aggregate results.

```sql
SELECT course_id, COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id
HAVING COUNT(*) >= 5;
```

Why not `WHERE`?

```text
WHERE filters rows before grouping.
HAVING filters groups after aggregate functions.
```

Example:

```sql
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 700000;
```

**Key idea:** aggregate conditions belong in `HAVING`, not `WHERE`.

---

## 10. ORDER BY

`ORDER BY` sorts the final query result.

### Ascending Order

`ASC` means ascending order.

```sql
SELECT student_name, age
FROM students
ORDER BY age ASC;
```

Smallest to largest:

```text
18, 19, 20, 21
```

### Descending Order

`DESC` means descending order.

```sql
SELECT student_name, age
FROM students
ORDER BY age DESC;
```

Largest to smallest:

```text
21, 20, 19, 18
```

If `ASC` or `DESC` is not written, SQL usually sorts in ascending order by default.

---

## 11. View Concept

A **view** is a saved SQL query that behaves like a virtual table.

In MySQL, a view does not usually store the data itself. It stores the query definition, and MySQL runs that query when the view is used.

```text
View = saved SELECT query
```

### MySQL Views

A **MySQL view** can be created from one table or from multiple joined tables.

Base tables:

```text
students(student_id, student_name, email, is_active)
enrollments(enrollment_id, student_id, course_id)
courses(course_id, course_name)
```

View:

```text
student_course_view
```

The view can hide the join logic and give users a simpler table-like result.

### Why Use Views?

Views are useful for:

- Simplifying complex queries.
- Hiding sensitive columns.
- Showing only the data a user needs.
- Reusing common query logic.
- Improving readability for reports.
- Giving users a cleaner interface to the database.

Example:

```sql
CREATE VIEW active_students_view AS
SELECT student_id, student_name, email
FROM students
WHERE is_active = 1;
```

Use the view:

```sql
SELECT *
FROM active_students_view;
```

The user does not need to write the `WHERE is_active = 1` condition every time.

### Strengths of Views

| Strength | Explanation |
| --- | --- |
| Simplicity | A view can hide long joins or complex filtering. |
| Reusability | The same query logic can be reused many times. |
| Security | A view can expose only selected columns and hide sensitive data. |
| Consistency | Reports can use the same saved logic instead of rewriting queries differently. |
| Readability | View names can describe business meaning, such as `active_students_view`. |
| Abstraction | Users can query a view without knowing the full table structure. |

Example: hide sensitive columns.

```sql
CREATE VIEW public_student_view AS
SELECT student_id, student_name, email
FROM students;
```

This view does not show private columns such as password, address, or phone number.

### Weaknesses of Views

| Weakness | Explanation |
| --- | --- |
| Performance issues | Complex views can be slower, especially when they contain joins, grouping, or nested views. |
| Limited updatability | Not all views can be updated directly. Views with joins, grouping, aggregate functions, or `DISTINCT` may not be updatable. |
| Dependency risk | If a base table or column is changed or dropped, the view may break. |
| Storage overhead | Normal views store only definitions, but temporary processing can use memory or disk. Materialized-style patterns also require extra storage. |
| Debugging difficulty | Errors can be harder to trace when queries depend on many views or nested views. |
| Security misconfiguration | A poorly designed view may expose sensitive columns or rows by mistake. |

**Key idea:** views make querying easier, but they do not automatically make queries faster or safer.

### Create a View

```sql
CREATE VIEW student_course_view AS
SELECT students.student_id,
       students.student_name,
       courses.course_name
FROM enrollments
INNER JOIN students
ON enrollments.student_id = students.student_id
INNER JOIN courses
ON enrollments.course_id = courses.course_id;
```

### Use a View

```sql
SELECT *
FROM student_course_view;
```

### Replace a View

```sql
CREATE OR REPLACE VIEW student_course_view AS
SELECT students.student_name,
       courses.course_name
FROM enrollments
INNER JOIN students
ON enrollments.student_id = students.student_id
INNER JOIN courses
ON enrollments.course_id = courses.course_id;
```

### Drop a View

```sql
DROP VIEW student_course_view;
```

### MySQL View Algorithms

MySQL can process views using different algorithms.

Common algorithms:

- `MERGE`
- `TEMPTABLE`
- `UNDEFINED`

### MERGE Algorithm

With `MERGE`, MySQL combines the view query with the outer query.

Example:

```sql
CREATE ALGORITHM = MERGE VIEW active_students_view AS
SELECT student_id, student_name, email
FROM students
WHERE is_active = 1;
```

If the user runs:

```sql
SELECT *
FROM active_students_view
WHERE student_name LIKE 'A%';
```

MySQL can merge it like:

```sql
SELECT student_id, student_name, email
FROM students
WHERE is_active = 1
  AND student_name LIKE 'A%';
```

MERGE is often more efficient because MySQL can optimize the combined query.

### TEMPTABLE Algorithm

With `TEMPTABLE`, MySQL creates a temporary table from the view result first, then runs the outer query on that temporary result.

Example:

```sql
CREATE ALGORITHM = TEMPTABLE VIEW course_count_view AS
SELECT course_id, COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id;
```

Then:

```sql
SELECT *
FROM course_count_view
WHERE total_students >= 5;
```

MySQL may:

```text
1. Build the grouped view result into a temporary table.
2. Filter the temporary result using total_students >= 5.
```

TEMPTABLE is useful for some complex views, but it can be slower because temporary data must be created.

### MERGE vs TEMPTABLE

| Algorithm | How It Works | Strength | Weakness |
| --- | --- | --- | --- |
| `MERGE` | Combines the view query with the outer query. | Often faster and more optimizable. | Cannot be used for every type of view. |
| `TEMPTABLE` | Creates a temporary result first. | Works for complex views such as grouped results. | Can be slower and may use memory or disk. |
| `UNDEFINED` | MySQL chooses the algorithm. | Convenient default. | Less explicit control. |

### When NOT to Use Views

Avoid or be careful with views when:

- The view hides very complex logic that students or developers need to understand.
- The view joins many large tables and causes performance problems.
- The view depends on other views too deeply.
- The view is used as a replacement for proper table design.
- The view exposes sensitive data without careful permission checks.
- The view needs frequent updates but is not updatable.
- The same query would be clearer and safer written directly.

Bad use case:

```text
Creating many nested views:
view_1 -> view_2 -> view_3 -> report_view
```

This can make debugging and performance tuning difficult.

Better approach:

```text
Use views for clear reusable query logic,
but keep important business logic understandable and documented.
```

**Key idea:** a view is a reusable virtual table created from a query, but it should be used carefully.

---

## 12. Full Query Example

```sql
SELECT courses.course_name,
       COUNT(enrollments.student_id) AS total_students
FROM courses
LEFT JOIN enrollments
ON courses.course_id = enrollments.course_id
GROUP BY courses.course_name
HAVING COUNT(enrollments.student_id) >= 1
ORDER BY total_students DESC;
```

This query:

1. Starts from `courses`.
2. Joins enrollment data.
3. Groups rows by course.
4. Counts students in each course.
5. Keeps only courses with at least one student.
6. Sorts courses from highest student count to lowest.

---

## 13. Exercises

### Exercise 1: SQL Clause Order

Put these clauses in the correct order:

```text
ORDER BY
FROM
HAVING
SELECT
WHERE
GROUP BY
```

### Exercise 2: Selection and Projection

Write a query that selects only `student_name` and `email` from students who live in `Yangon`.

### Exercise 3: Joins

Write queries for:

1. Students with their enrolled courses using `INNER JOIN`.
2. All students, including students with no enrollments, using `LEFT JOIN`.
3. All enrollments, including rows where student data may be missing, using `RIGHT JOIN`.

### Exercise 4: Aggregates and HAVING

Write a query that shows each course and the number of students enrolled.

Only show courses with more than `3` students.

### Exercise 5: View

Create a view named `active_student_view` that shows:

- `student_id`
- `student_name`
- `email`

Only include active students.

### Exercise 6: View Strengths and Weaknesses

For each situation, decide whether a view is a good idea or not:

1. A report needs the same long join every week.
2. A user should see student names and emails but not private phone numbers.
3. A query joins many large tables and already runs very slowly.
4. A developer creates five nested views to hide all business logic.
5. A dashboard needs a simple reusable query for active students.

### Exercise 7: View Algorithm

Choose the better view algorithm idea:

1. A simple view filters active students from one table.
2. A view groups enrollments and counts students per course.
3. A view has complex aggregation and MySQL needs a temporary result.

---

## 14. Review Questions

1. What is `sql_safe_updates`?
2. What is the difference between `sql_safe_updates = 0` and `sql_safe_updates = 1`?
3. What is selection in SQL?
4. What is projection in SQL?
5. What does `CROSS JOIN` do?
6. What is the difference between intersection and difference?
7. What is the difference between `INNER JOIN` and `LEFT JOIN`?
8. What is the purpose of `GROUP BY`?
9. Why do aggregate conditions use `HAVING`?
10. What is the difference between `ASC` and `DESC`?
11. What is a SQL view?
12. Why are views useful?
13. What are three strengths of views?
14. What are three weaknesses of views?
15. What is the difference between the `MERGE` and `TEMPTABLE` view algorithms?
16. When should we avoid using views?
17. Why can nested views be difficult to debug?
18. How can a view cause a security problem?
