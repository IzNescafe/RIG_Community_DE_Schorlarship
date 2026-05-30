# Day 8 Lecture: Data and Database Management with MSSQL Server Architecture

> Theme: good databases are not only about tables and SQL. They also require governance, architecture, security, quality, integration, and reliable database management systems.

## Learning Goals

By the end of Day 8, students should be able to:

- Explain what data management means.
- Describe the major processes of data management.
- Understand how data management supports business decision-making.
- Explain the difference between data management and database management.
- Describe the main layers of Microsoft SQL Server architecture.
- Understand how SQL Server receives, processes, stores, and returns data.

---

## 1. Data and Database Management

### What Is Data?

**Data** is raw facts that can be stored, processed, and analyzed.

Examples:

- Customer name
- Phone number
- Order amount
- Payment status
- Login time
- Product price
- Sensor reading

Data becomes useful when it is organized and given meaning.

### What Is a Database?

A **database** is an organized collection of data.

Example:

```text
customers(customer_id, customer_name, phone_number)
orders(order_id, customer_id, order_date, total_amount)
products(product_id, product_name, price)
```

### What Is Database Management?

**Database management** focuses on storing, organizing, protecting, retrieving, and maintaining data inside a database system.

Database management includes:

- Creating databases and tables.
- Writing SQL queries.
- Managing users and permissions.
- Backing up and restoring data.
- Monitoring database performance.
- Protecting data from loss or corruption.

### What Is Data Management?

**Data management** is the broader practice of managing data across its full life cycle.

It includes how data is:

- Collected.
- Stored.
- Organized.
- Secured.
- Integrated.
- Shared.
- Analyzed.
- Archived.
- Deleted.

Simple definition:

```text
Data management is the process of making sure data is accurate,
secure, usable, available, and meaningful for the organization.
```

### Data Management vs Database Management

| Topic | Data Management | Database Management |
| --- | --- | --- |
| Scope | Broad organization-wide data practice. | Focuses on database systems. |
| Main concern | Data quality, governance, meaning, security, integration. | Storage, queries, performance, backup, access. |
| Example | Defining who owns customer data. | Creating the `customers` table. |
| Tools | Policies, catalogs, warehouses, ETL tools, BI tools. | MSSQL Server, MySQL, PostgreSQL, Oracle. |

**Key idea:** database management is one part of data management.

---

## 2. Why Data Management Matters

Poor data management can cause:

- Wrong business reports.
- Duplicate customer records.
- Security and privacy problems.
- Data loss.
- Inconsistent data between departments.
- Slow decision-making.
- Compliance issues.

Good data management helps organizations:

- Trust their reports.
- Protect sensitive information.
- Improve customer service.
- Reduce duplicated work.
- Support analytics and AI.
- Make better decisions.

Example:

```text
If customer phone numbers are duplicated, missing, or outdated,
a telecom company may fail to contact customers before they churn.
```

### Why We Need Data Management

| Reason | Explanation |
| --- | --- |
| **Increases productivity** | Teams spend less time searching, cleaning, or correcting data. |
| **Smooth operations** | Business processes run more consistently when data is organized and available. |
| **Reduces security risk** | Access control, governance, and monitoring help protect sensitive data. |
| **Cost effective** | Clean and well-managed data reduces duplicated work, storage waste, and error correction costs. |
| **Minimal chance of data loss** | Backup, recovery, and proper storage operations help prevent permanent data loss. |
| **Better decision-making** | Accurate and trusted data leads to better reports, analytics, and business decisions. |

Example:

```text
If customer, billing, and service data are managed properly,
a telecom company can quickly identify high-risk churn customers
and take action before losing revenue.
```

### Benefits of Data Management

| Benefit | Description | Example |
| --- | --- | --- |
| **Improved data accuracy** | Data rules and validation reduce wrong or incomplete records. | Phone numbers follow one valid format. |
| **Faster access to data** | Organized data is easier to search, query, and report. | Managers can quickly view monthly sales. |
| **Better collaboration** | Departments use shared definitions and trusted data sources. | Finance and sales use the same customer ID. |
| **Stronger security** | Sensitive data is protected through permissions and monitoring. | Only authorized staff can view salary data. |
| **Reliable reporting** | Reports become more consistent when source data is clean. | Dashboards show the same revenue totals. |
| **Regulatory compliance** | Data policies help organizations follow legal and industry rules. | Customer privacy rules are documented and enforced. |
| **Business intelligence support** | Clean, integrated data supports analytics, dashboards, and AI. | Churn prediction uses accurate customer history. |
| **Reduced operational risk** | Backups, recovery plans, and data controls reduce business disruption. | Data can be restored after accidental deletion. |

**Key idea:** data management turns raw data into a trusted business asset.

---

## 3. Data Management Market

The **data management market** includes tools, services, platforms, and jobs that help organizations collect, store, protect, integrate, analyze, and govern data.

As organizations generate more data from apps, websites, payments, sensors, customer systems, and cloud platforms, the need for data management continues to grow.

### Major Areas in the Data Market

The data market can be understood as a value chain. Data is generated first, then stored, processed, analyzed, governed, used for AI, and sometimes monetized.

```text
Data Generation
  -> Data Storage
  -> Data Engineering
  -> Analytics and BI
  -> AI/ML Platforms
  -> Data Governance
  -> Cloud and AI Infrastructure
  -> Data Monetization
```

| Market Area | What It Means | Example |
| --- | --- | --- |
| **Data generation** | Creating data from business activities, applications, devices, and users. | Orders, payments, web clicks, call records, sensor data. |
| **Data storage** | Saving data in databases, warehouses, lakes, or cloud storage. | SQL Server, MySQL, data warehouse, data lake. |
| **Data engineering** | Moving, cleaning, transforming, and preparing data for use. | ETL/ELT pipelines, data integration, batch jobs. |
| **Analytics and BI** | Turning data into reports, dashboards, and insights. | Sales dashboard, churn report, KPI dashboard. |
| **AI/ML platforms** | Using data to train models, predict outcomes, and automate decisions. | Churn prediction, recommendation system, fraud detection. |
| **Data governance** | Managing data rules, ownership, quality, privacy, and compliance. | Data catalog, access policy, data quality rules. |
| **Cloud and AI infrastructure** | Providing scalable computing, storage, and model infrastructure. | Cloud databases, GPU servers, managed AI platforms. |
| **Data monetization** | Creating business value or revenue from data. | Selling insights, improving targeting, reducing churn, optimizing pricing. |

### Data Market Flow Example

```text
Telecom customers make calls and use mobile data.
  -> Call records and usage data are generated.
  -> Data is stored in databases and data lakes.
  -> Data engineers clean and prepare the data.
  -> Analysts build churn and revenue dashboards.
  -> AI/ML models predict customers likely to leave.
  -> Governance controls privacy and access.
  -> Cloud infrastructure scales the system.
  -> The company reduces churn and increases revenue.
```

### Why the Market Is Growing

- Businesses are producing more digital data.
- Cloud platforms make data storage and analytics easier to scale.
- AI and machine learning require clean and well-managed data.
- Cybersecurity and privacy requirements are increasing.
- Companies need faster reporting and better decision-making.
- Data-driven competition is becoming more important in every industry.

### Career Opportunities

Data management creates many job roles:

- Database administrator.
- Data analyst.
- Data engineer.
- Data architect.
- Data governance analyst.
- Data quality analyst.
- BI developer.
- Cloud database engineer.
- Data security specialist.

Example:

```text
A telecom company needs data engineers to integrate call records,
data analysts to study churn, database administrators to maintain systems,
and governance teams to protect customer information.
```

**Key idea:** data management is not only a technical topic. It is also a growing business and career field.

---

## 4. Data Analytics

**Data analytics** is the process of examining data to find patterns, answer questions, and support better decisions.

Simple definition:

```text
Data analytics turns data into insight.
```

Example:

```text
Raw data: customer usage records, payment history, complaints
Insight: customers with low usage and many complaints are likely to churn
Decision: offer retention promotion to high-risk customers
```

### Why Data Analytics Matters

Data analytics helps organizations:

- Understand what happened.
- Find business problems.
- Measure performance.
- Predict future outcomes.
- Improve customer experience.
- Reduce cost.
- Increase revenue.
- Make evidence-based decisions.

### Types of Data Analytics

| Type | Main Question | Example |
| --- | --- | --- |
| **Descriptive analytics** | What happened? | Total sales last month. |
| **Diagnostic analytics** | Why did it happen? | Why sales dropped in Mandalay. |
| **Predictive analytics** | What is likely to happen? | Which customers may churn next month. |
| **Prescriptive analytics** | What should we do? | Which offer should be given to each customer. |

### Data Analytics Process

```text
Business Question
  -> Data Collection
  -> Data Cleaning
  -> Data Analysis
  -> Visualization
  -> Insight
  -> Decision / Action
```

Example:

```text
Question: Why are customers leaving?
Data: call usage, internet usage, complaints, payment records
Cleaning: remove duplicates and fix missing values
Analysis: compare churned vs active customers
Visualization: churn dashboard
Insight: customers with repeated complaints churn more
Action: improve support and offer retention plans
```

### Data Analytics Project Processes

A data analytics project usually follows a clear process from business problem to action.

Simple process:

```text
Business Understanding
  -> Data Exploration
  -> Data Preparation
  -> Data Modelling
  -> Data Evaluation
  -> Deployment
```

| Step | Process | Main Question | Example |
| --- | --- | --- | --- |
| 1 | **Business understanding** | What problem are we trying to solve? | Why are telecom customers leaving? |
| 2 | **Data exploration** | What data do we have, and what does it show? | Check customer usage, complaints, plan type, and payment records. |
| 3 | **Data preparation** | How do we clean and prepare the data? | Remove duplicates, handle missing values, and standardize city names. |
| 4 | **Data modelling** | What analysis or model should we build? | Build a churn prediction model or customer segmentation. |
| 5 | **Data evaluation** | Are the results useful, accurate, and meaningful? | Check whether the model correctly identifies high-risk customers. |
| 6 | **Deployment** | How will the result be used in real work? | Show churn risk in a dashboard or send customer lists to the retention team. |

> Note: Some frameworks show deployment at the end because the solution is deployed after evaluation. In business discussion, deployment may also be discussed early so the team knows how the result will be used.

Detailed project activities:

| Step | Process | Description | Example |
| --- | --- | --- | --- |
| 1 | **Define the problem** | Identify the business question or decision that needs data. | Why are customers leaving? |
| 2 | **Collect data** | Gather relevant data from databases, files, APIs, surveys, or systems. | Customer usage, complaints, billing, payments. |
| 3 | **Understand the data** | Review columns, data types, meanings, missing values, and relationships. | Check what `customer_status` and `last_payment_date` mean. |
| 4 | **Clean the data** | Fix missing values, duplicates, invalid formats, and inconsistent values. | Convert `ygn`, `Yangon`, and `YANGON` into one standard value. |
| 5 | **Transform the data** | Prepare data for analysis by creating new columns, grouping, joining, or filtering. | Create `monthly_usage` and `complaint_count`. |
| 6 | **Analyze the data** | Use SQL, statistics, charts, or models to find patterns. | Compare churned customers with active customers. |
| 7 | **Visualize results** | Present findings with charts, dashboards, or summary tables. | Build a churn dashboard by city and customer type. |
| 8 | **Interpret insights** | Explain what the results mean for the business. | Customers with many complaints are more likely to churn. |
| 9 | **Recommend action** | Suggest what the organization should do next. | Offer support calls or discounts to high-risk customers. |
| 10 | **Monitor results** | Track whether the action improves the business outcome. | Check whether churn rate decreases next month. |

Project flow:

```text
Problem
  -> Data
  -> Cleaning
  -> Transformation
  -> Analysis
  -> Visualization
  -> Insight
  -> Action
  -> Monitoring
```

### Mini Analytics Project Example

Business problem:

```text
The telecom company wants to reduce customer churn.
```

Analytics process:

```text
1. Define problem: identify why customers leave.
2. Collect data: usage, payment, complaint, plan, and location data.
3. Clean data: remove duplicates and fix missing city names.
4. Transform data: calculate monthly usage and complaint count.
5. Analyze data: compare churned and active customers.
6. Visualize data: create churn dashboard by city and plan.
7. Interpret insight: high complaint count is linked to churn.
8. Recommend action: contact high-risk customers early.
9. Monitor result: compare churn rate before and after action.
```

### Common Data Analytics Techniques

| Technique | Purpose |
| --- | --- |
| Filtering | Focus on specific records. |
| Grouping | Summarize data by category. |
| Aggregation | Calculate totals, averages, counts, minimums, and maximums. |
| Trend analysis | Study changes over time. |
| Segmentation | Divide customers or products into groups. |
| Correlation analysis | Find relationships between variables. |
| Visualization | Turn data into charts and dashboards. |

### Data Analytics Tools

Common tools include:

- SQL
- Excel
- Power BI
- Tableau
- Python
- R
- SQL Server Reporting Services
- Cloud analytics platforms

### Data Analytics vs Business Intelligence

| Topic | Data Analytics | Business Intelligence |
| --- | --- | --- |
| Focus | Finding insights and patterns. | Reporting and monitoring business performance. |
| Main question | Why did it happen, and what may happen next? | What happened, and what is happening now? |
| Output | Analysis, models, recommendations. | Dashboards, KPIs, reports. |
| Example | Predicting customer churn. | Monthly revenue dashboard. |

**Key idea:** BI is often part of analytics, but analytics can go deeper into causes, predictions, and recommendations.

---

## 5. Processes of Data Management

Data management includes many connected processes.

| No. | Process | Main Purpose |
| --- | --- | --- |
| 1 | Data governance | Defines rules, ownership, standards, and accountability. |
| 2 | Data architecture | Designs how data flows and is stored across systems. |
| 3 | Data modelling | Defines entities, relationships, tables, and structures. |
| 4 | Data storage and operations | Stores, maintains, backs up, and operates data systems. |
| 5 | Data security | Protects data from unauthorized access or misuse. |
| 6 | Data integration and interoperability | Combines data from different systems and makes systems work together. |
| 7 | Documents and content | Manages files, documents, images, and unstructured content. |
| 8 | Reference and master data | Manages important shared data such as customer, product, and location data. |
| 9 | Data warehousing | Stores historical and analytical data for reporting. |
| 10 | Metadata | Manages data about data. |
| 11 | Data quality | Ensures data is accurate, complete, consistent, and reliable. |

---

## 6. Data Governance

**Data governance** defines how data should be managed, who owns it, and what rules must be followed.

It answers questions such as:

- Who owns customer data?
- Who can approve data changes?
- Which data is sensitive?
- What naming standards should be used?
- How long should data be kept?

Example:

```text
The customer service department can update customer contact information,
but only the finance department can update billing status.
```

**Key idea:** governance creates rules and accountability for data.

---

## 7. Data Architecture

**Data architecture** describes how data is organized across systems.

It includes:

- Databases.
- Data warehouses.
- Data lakes.
- APIs.
- ETL pipelines.
- Reporting systems.
- Backup systems.

Architecture diagram:

```text
Operational Systems
  |
  v
ETL / Integration
  |
  v
Data Warehouse
  |
  v
Reports / Dashboards / Analytics
```

**Key idea:** data architecture is the blueprint for how data moves and lives in an organization.

---

## 8. Data Modelling

**Data modelling** is the process of designing how data should be structured.

It includes:

- Entities.
- Attributes.
- Relationships.
- Primary keys.
- Foreign keys.
- Constraints.

Example:

```text
Customer places Order
Order contains Product
```

Possible tables:

```text
customers(customer_id, customer_name, phone_number)
orders(order_id, customer_id, order_date)
products(product_id, product_name, price)
order_items(order_id, product_id, quantity)
```

**Key idea:** data modelling turns real-world business information into database structure.

---

## 9. Data Storage and Operations

**Data storage and operations** focuses on storing and maintaining data systems every day.

It includes:

- Database installation.
- Table creation.
- Index management.
- Backup and restore.
- Monitoring.
- Performance tuning.
- Storage capacity planning.
- Disaster recovery.

Example:

```text
A DBA schedules daily backups for the telecom customer database
so data can be restored if the server fails.
```

**Key idea:** storage and operations keep data available and reliable.

---

## 10. Data Security

**Data security** protects data from unauthorized access, corruption, misuse, or loss.

It includes:

- Authentication.
- Authorization.
- Encryption.
- Auditing.
- Role-based access control.
- Backup protection.
- Data masking.

Example:

```text
Only HR managers can view employee salary data.
Other employees can view names and departments only.
```

**Key idea:** data security protects confidentiality, integrity, and availability.

---

## 11. Data Integration and Interoperability

**Data integration** combines data from multiple sources.

**Interoperability** means different systems can exchange and use data correctly.

Examples:

- CRM sends customer data to billing.
- Ecommerce sends order data to inventory.
- Telecom call records are combined with customer profiles.
- A dashboard reads data from multiple databases.

Common methods:

- ETL: Extract, Transform, Load.
- APIs.
- Data pipelines.
- File import/export.
- Replication.

**Key idea:** integration connects data; interoperability makes connected systems understand each other.

---

## 12. Documents and Content

Not all data is stored in tables.

Organizations also manage:

- PDF files.
- Word documents.
- Images.
- Videos.
- Contracts.
- Emails.
- Scanned forms.

This is called **documents and content management**.

Example:

```text
A telecom company stores customer ID scans and signed service contracts.
```

**Key idea:** document and content management handles unstructured or semi-structured information.

---

## 13. Reference and Master Data

### Reference Data

**Reference data** is a controlled list of valid values.

Examples:

- Country codes.
- City names.
- Product categories.
- Payment status values.
- Customer type values.

### Master Data

**Master data** is core business data shared across many systems.

Examples:

- Customer.
- Product.
- Employee.
- Supplier.
- Location.

Example:

```text
The same customer record should be consistent in billing,
customer service, marketing, and reporting systems.
```

**Key idea:** reference data standardizes values; master data standardizes important business entities.

---

## 14. Data Warehousing

A **data warehouse** stores data for analysis and reporting.

It usually contains:

- Historical data.
- Cleaned data.
- Integrated data from many systems.
- Aggregated data for reporting.

Operational database:

```text
Used for daily work.
Example: inserting orders, updating payments.
```

Data warehouse:

```text
Used for analysis.
Example: monthly sales report, churn prediction, business dashboard.
```

**Key idea:** data warehouses support decision-making and analytics.

---

## 15. Metadata

**Metadata** means data about data.

Examples:

- Table name.
- Column name.
- Data type.
- Data owner.
- Last updated date.
- Source system.
- Meaning of a field.

Example:

```text
Column: customer_status
Data type: VARCHAR(20)
Allowed values: Active, Suspended, Churned
Owner: Customer Operations Team
```

**Key idea:** metadata helps people understand, find, and trust data.

---

## 16. Data Quality

**Data quality** means data is fit for use.

Good data should be:

| Quality Dimension | Meaning |
| --- | --- |
| Accuracy | Data is correct. |
| Completeness | Required data is not missing. |
| Consistency | Data matches across systems. |
| Timeliness | Data is up to date. |
| Validity | Data follows rules and formats. |
| Uniqueness | Duplicate records are avoided. |

Example data quality problem:

```text
Customer phone number is missing.
Customer city is spelled three different ways.
Same customer appears twice with different IDs.
```

**Key idea:** poor data quality creates poor decisions.

---

## 17. MSSQL Server Architecture

**Microsoft SQL Server**, often called **MSSQL Server** or **SQL Server**, is a relational database management system from Microsoft.

It stores data, processes SQL queries, manages security, supports transactions, and provides tools for administration and analytics.

### Main Architecture Layers

SQL Server architecture can be understood in four major parts:

1. Client applications
2. Protocol layer
3. Relational engine
4. Storage engine

```text
+-----------------------------+
|      Client Applications     |
| SSMS, Apps, APIs, Reports    |
+--------------+--------------+
               |
               v
+-----------------------------+
|        Protocol Layer        |
|  TDS, TCP/IP, Named Pipes    |
+--------------+--------------+
               |
               v
+-----------------------------+
|       Relational Engine      |
| Parser, Optimizer, Executor  |
+--------------+--------------+
               |
               v
+-----------------------------+
|        Storage Engine        |
| Data Files, Logs, Buffer     |
+-----------------------------+
```

**Key idea:** clients send requests, SQL Server processes them, and the storage engine reads or writes the data.

---

## 18. Client Applications

Client applications are tools or programs that connect to SQL Server.

Examples:

- SQL Server Management Studio, also called SSMS.
- Azure Data Studio.
- Web applications.
- Desktop applications.
- Reporting tools.
- APIs and backend services.

Example:

```sql
SELECT *
FROM Customers;
```

The client sends this SQL command to SQL Server.

---

## 19. Protocol Layer

The **protocol layer** manages communication between clients and SQL Server.

Common protocols:

- TDS: Tabular Data Stream.
- TCP/IP.
- Named Pipes.
- Shared Memory.

The protocol layer handles:

- Client connection.
- Network communication.
- Request transfer.
- Result transfer.

**Key idea:** the protocol layer carries requests and results between client and server.

---

## 20. Relational Engine

The **relational engine** is responsible for understanding and executing SQL queries.

It includes:

- Parser.
- Algebrizer or binder.
- Query optimizer.
- Query executor.

### Query Processing Flow

```text
SQL Query
  |
  v
Parser
  |
  | checks syntax
  v
Algebrizer / Binder
  |
  | checks tables, columns, data types, and permissions
  v
Optimizer
  |
  | creates an efficient execution plan
  v
Executor
  |
  | runs the plan
  v
Result
```

**Key idea:** the relational engine turns SQL text into an execution plan and runs it.

---

## 21. Storage Engine

The **storage engine** manages how data is physically stored and retrieved.

It handles:

- Data files.
- Log files.
- Pages and extents.
- Indexes.
- Buffer pool.
- Transactions.
- Locking.
- Recovery.

### SQL Server Database Files

| File Type | Extension | Purpose |
| --- | --- | --- |
| Primary data file | `.mdf` | Main database data file. |
| Secondary data file | `.ndf` | Optional extra data file. |
| Transaction log file | `.ldf` | Stores transaction log records for recovery. |

### Buffer Pool

The **buffer pool** is memory used to cache database pages.

```text
If data is already in memory, SQL Server can read it faster.
If not, SQL Server reads it from disk and places it into memory.
```

### Transaction Log

The transaction log records changes before they are permanently written to data files.

This supports:

- Rollback.
- Crash recovery.
- Durability.

**Key idea:** the storage engine protects and manages the physical data.

---

## 22. MSSQL Query Execution Example

Example query:

```sql
SELECT customer_name
FROM Customers
WHERE customer_id = 1;
```

Execution flow:

```text
1. Client sends query from SSMS.
2. Protocol layer transfers request to SQL Server.
3. Relational engine parses and optimizes query.
4. Storage engine checks buffer pool or reads data from disk.
5. Result is returned to the relational engine.
6. SQL Server sends result back to the client.
```

Short version:

```text
Client -> Protocol -> Relational Engine -> Storage Engine -> Client
```

---

## 23. Exercises

### Exercise 1: Data Management Processes

Match each process to its purpose:

| Process | Purpose |
| --- | --- |
| Data governance |  |
| Data architecture |  |
| Data modelling |  |
| Data security |  |
| Data quality |  |
| Metadata |  |

### Exercise 2: Data Quality

Find three data quality problems in this data:

```text
customer_id | customer_name | phone       | city
1           | Aung Aung     | 09123456789 | Yangon
2           | Su Su         |             | ygn
3           | Aung Aung     | 09123456789 | Yangon
```

### Exercise 3: Data Analytics

A telecom company wants to reduce customer churn.

Answer:

1. What data should the company collect?
2. What descriptive analytics question can be asked?
3. What predictive analytics question can be asked?
4. What action can the company take after finding high-risk customers?

### Exercise 4: MSSQL Architecture

Explain the role of each part:

```text
Client Applications:
Protocol Layer:
Relational Engine:
Storage Engine:
```

### Exercise 5: Query Flow

Describe what happens when this query runs in SQL Server:

```sql
SELECT *
FROM Customers
WHERE city = 'Yangon';
```

---

## 24. Review Questions

1. What is data management?
2. What is database management?
3. What is the difference between data management and database management?
4. Why is data governance important?
5. What is data architecture?
6. What is data modelling?
7. Why is data security important?
8. What is data integration?
9. What is the difference between reference data and master data?
10. What is a data warehouse used for?
11. What is metadata?
12. What are three dimensions of data quality?
13. What is data analytics?
14. What are the four types of data analytics?
15. What is the difference between data analytics and business intelligence?
16. What is an example of predictive analytics?
17. What is MSSQL Server?
18. What are the main layers of SQL Server architecture?
19. What is the role of the relational engine?
20. What is the role of the storage engine?
21. What are `.mdf`, `.ndf`, and `.ldf` files?
22. What is the buffer pool?
23. Why is the transaction log important?
