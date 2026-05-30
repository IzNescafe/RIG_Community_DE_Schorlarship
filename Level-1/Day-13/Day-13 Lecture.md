# Day 13 Lecture: Concept of Compliance in Banking

> Theme: compliance in banking protects customers, banks, and the financial system by making sure banking activities follow laws, regulations, security standards, and reporting rules.

## Learning Goals

By the end of Day 13, students should be able to:

- Explain what compliance means in banking.
- Identify major banking compliance requirements.
- Understand KYC, AML, data privacy, and regulatory reporting.
- Describe a basic banking compliance workflow.
- Explain how banks monitor transactions and detect suspicious activity.

---

## 1. What Is Compliance?

**Compliance** means following required laws, regulations, policies, standards, and procedures.

In banking, compliance means the bank must operate according to the rules set by regulators and financial authorities.

Simple definition:

```text
Compliance in banking means making sure banking activities follow legal,
regulatory, security, privacy, and reporting requirements.
```

### Why Compliance Matters

Compliance helps banks:

- Prevent money laundering.
- Prevent fraud.
- Protect customer data.
- Follow central bank rules.
- Reduce legal and financial risk.
- Build customer trust.
- Avoid fines and penalties.
- Support safe financial operations.

Example:

```text
If a customer deposits a very large amount of money without clear source,
the bank may need to review the transaction and report suspicious activity.
```

---

## 2. What Is Compliance in Banking?

**Banking compliance** is the process of ensuring that a bank follows all rules related to customer onboarding, account opening, transactions, data protection, reporting, and financial operations.

Banking compliance includes:

| Compliance Area | Meaning |
| --- | --- |
| **Central Bank regulations** | Rules issued by the central bank to control banking operations and financial stability. |
| **AML laws** | Anti-Money Laundering laws that prevent illegal money from entering the financial system. |
| **KYC requirements** | Know Your Customer rules that require banks to verify customer identity. |
| **Data privacy laws** | Rules for protecting customer personal data. |
| **Security standards** | Technical and operational standards for protecting systems and transactions. |
| **Financial reporting rules** | Rules for preparing and submitting accurate financial reports to regulators. |

**Key idea:** banking compliance is not one rule. It is a system of rules that protects the bank and the financial ecosystem.

---

## 3. Central Bank Regulations

The **Central Bank** creates rules that banks must follow.

These rules may cover:

- Bank licensing.
- Capital requirements.
- Interest rate rules.
- Customer protection.
- Transaction limits.
- Reporting requirements.
- Risk management.
- Foreign exchange controls.

Example:

```text
A central bank may require banks to submit monthly transaction reports
or maintain a minimum level of capital.
```

---

## 4. AML Laws

**AML** means **Anti-Money Laundering**.

Money laundering is the process of hiding the illegal source of money.

AML refers to the **policies, technologies, and controls** used to protect the financial system from illegal financial activity.

AML is used to:

- Detect illegal financial activities.
- Prevent money laundering.
- Identify suspicious transactions.
- Comply with financial regulations.

AML laws require banks to:

- Monitor transactions.
- Detect suspicious activity.
- Verify source of funds.
- Screen customers against watchlists.
- Report suspicious transactions.
- Keep records for investigation.

### AML Process

Money laundering is commonly explained in three stages:

| Stage | Meaning | Example |
| --- | --- | --- |
| **Placement** | Dirty money enters the financial system. | Criminal cash is deposited into a bank account. |
| **Layering** | Money is moved through multiple transactions to hide its source. | Funds are transferred between many accounts, banks, or countries. |
| **Integration** | Money appears legal and is used in normal business or personal spending. | Laundered money is used to buy property, invest in a company, or make luxury purchases. |

Process flow:

```text
  ->  Placement
  -> Layering
  -> Integration
```

Important note:

```text
In integration, the money appears legal, not illegal.
That is the purpose of money laundering.
```

Example suspicious activity:

```text
A customer deposits large amounts of cash many times in one week
without a clear business reason.
```

### AML Detection Rules

AML systems use rules to identify transactions or behavior that may be suspicious.

| Detection Rule | Meaning | Example |
| --- | --- | --- |
| **Large transfer** | A transfer amount is unusually high for the customer profile. | A student account sends 200,000,000 MMK. |
| **Rapid transfers** | Money moves quickly through accounts in a short time. | Deposit received and transferred out within minutes. |
| **Foreign transfers** | Transaction involves another country, especially a high-risk location. | Transfer to a country on a high-risk monitoring list. |
| **Dormant accounts** | An inactive account suddenly becomes active with unusual transactions. | No activity for one year, then large cash deposits begin. |
| **Structuring** | Large transactions are split into smaller amounts to avoid reporting limits. | Ten transfers of 9,900,000 MMK instead of one 99,000,000 MMK transfer. |

### AML Risk Factors

AML risk can be detected from:

| Risk Factor | What to Check |
| --- | --- |
| **Customer behavior** | Does the activity match the customer's normal profile? |
| **Transaction volume** | Is the amount unusually large or increasing suddenly? |
| **Geographic location** | Does the transaction involve high-risk countries or unusual locations? |
| **Transaction frequency** | Are there too many transactions in a short period? |

Example:

```text
A low-income customer suddenly receives many large foreign transfers
from high-risk locations within two days.
```

This may trigger AML review because the behavior, volume, geography, and frequency are unusual.

### AML Best Practices

| Best Practice | Purpose |
| --- | --- |
| **Real-time transaction monitoring** | Detect suspicious activity as transactions happen. |
| **AI-based anomaly detection** | Identify unusual patterns that fixed rules may miss. |
| **Daily AML scanning** | Review daily transactions, customers, and watchlist updates. |
| **Threshold screening** | Trigger alerts when transaction amounts exceed defined limits. |
| **Automated reporting** | Generate compliance reports quickly and consistently. |

**Key idea:** AML protects the financial system from illegal money movement.

---

## 5. KYC Requirements

**KYC** means **Know Your Customer**.

KYC is the process of verifying customer identity before or during account opening.

Banks may collect:

- Full name.
- Date of birth.
- National ID or passport.
- Address.
- Phone number.
- Occupation.
- Source of income.
- Business registration documents for companies.

KYC helps banks answer:

```text
Who is this customer?
Can we verify their identity?
What is their risk level?
Are they allowed to open an account?
```

### Customer Risk Levels

| Risk Level | Description |
| --- | --- |
| Low risk | Normal customer with clear identity and normal transaction behavior. |
| Medium risk | Customer needs closer review due to occupation, location, or transaction pattern. |
| High risk | Customer may require enhanced due diligence and stronger monitoring. |

### KYC Workflow

KYC workflow is a **multi-stage data verification process** used to confirm that a customer is real, reachable, and financially understandable before the bank provides full services.

```text
Customer Registration
  -> Government ID Verification
  -> Contact Verification
  -> Address Verification
  -> Biometric Verification
  -> Income Verification
  -> Customer Risk Profiling
  -> KYC Approval / Review / Rejection
```

### Multi-Stage Data Verification Process

| Stage | Purpose | Example |
| --- | --- | --- |
| **Government ID verification** | Confirms the customer's legal identity. | National ID, passport, driving license. |
| **Contact verification** | Confirms the customer can be contacted. | OTP to phone number or email verification. |
| **Address verification** | Confirms where the customer lives or operates. | Utility bill, bank statement, household registration. |
| **Biometric verification** | Confirms the person matches the identity document. | Face scan, fingerprint, liveness check. |
| **Income verification** | Confirms source of income and financial profile. | Salary slip, employment letter, business income document. |

### KYC Best Practices

| Best Practice | Purpose |
| --- | --- |
| **Periodic customer review** | Re-check customer information regularly, especially for high-risk customers. |
| **Biometric verification** | Reduce identity fraud by confirming the customer's physical identity. |
| **Document expiry checking** | Detect expired ID cards, passports, licenses, or business documents. |
| **Address validation** | Confirm that customer address information is real and current. |
| **Customer risk profiling** | Assign risk level based on identity, occupation, geography, income, and behavior. |
| **Multi-factor verification** | Use more than one verification method, such as ID document plus OTP plus biometric. |

Example:

```text
A customer uploads a national ID, verifies phone number by OTP,
submits address proof, completes face verification, and provides income details.
The system assigns a risk score before account opening.
```

**Key idea:** KYC helps banks know who they are serving.

---

## 6. Data Privacy Laws

Banks store sensitive customer data.

Examples:

- Name.
- Address.
- Phone number.
- National ID.
- Bank account number.
- Transaction history.
- Salary or income information.

Data privacy laws require banks to:

- Collect only necessary data.
- Protect customer data.
- Limit who can access data.
- Use data only for approved purposes.
- Store data securely.
- Delete or archive data according to policy.

Example:

```text
A teller may view customer account details for service purposes,
but should not download or share customer data outside the bank.
```

---

## 7. Security Standards

Security standards protect banking systems and customer transactions.

### Security Goals

Security is commonly explained using three main goals: **confidentiality**, **integrity**, and **availability**.

| Goal | Meaning | Banking Example |
| --- | --- | --- |
| **Confidentiality** | Protect data from unauthorized access. | Only authorized staff can view customer account details. |
| **Integrity** | Prevent unauthorized or incorrect modification of data. | A transaction amount cannot be changed without approval and audit record. |
| **Availability** | Ensure systems and data are available when needed. | Mobile banking and ATM services should stay online. |

They may include:

- Strong passwords.
- Multi-factor authentication.
- Encryption.
- Secure network communication.
- Access control.
- Audit logs.
- Security monitoring.
- Incident response.

Example:

```text
Online banking should use encryption so attackers cannot read customer data
while it travels over the internet.
```

### Security Controls and Purpose

| Control | Purpose |
| --- | --- |
| **Authentication** | Verify who the user is. |
| **Authorization** | Control what the user is allowed to do. |
| **Encryption** | Protect data while stored or transmitted. |
| **Multi-factor authentication** | Add extra login protection beyond password. |
| **Access control** | Limit data access based on role or responsibility. |
| **Audit logging** | Record important user and system activities. |
| **Backup and recovery** | Restore data after failure, deletion, or attack. |
| **Security monitoring** | Detect suspicious activity or attacks. |
| **Patch management** | Fix known software vulnerabilities. |
| **Incident response** | Respond quickly when a security issue happens. |

### Common Security Threats

| Threat | Meaning | Example |
| --- | --- | --- |
| **SQL injection** | An attacker inserts malicious SQL into an input field. | Login form input changes the SQL query and exposes customer records. |
| **Insider threat** | A trusted employee misuses access. | Staff downloads customer data without permission. |
| **Data breach** | Sensitive data is accessed or leaked without authorization. | Customer names, phone numbers, and account numbers are stolen. |
| **Ransomware** | Malware encrypts files or systems and demands payment. | Bank systems become locked and attackers demand money to restore access. |

### Threat, Control, and Protection

| Threat | Useful Controls |
| --- | --- |
| SQL injection | Input validation, prepared statements, least privilege, code review. |
| Insider threat | Role-based access, audit logs, privileged user monitoring, approval workflow. |
| Data breach | Encryption, access control, monitoring, data masking, secure backups. |
| Ransomware | Backups, endpoint protection, patching, network segmentation, incident response. |

**Key idea:** security standards reduce cyber risk and protect financial transactions.

---

## 8. Financial Reporting Rules

Banks must prepare accurate reports for management, auditors, and regulators.

Financial reporting may include:

- Balance sheet.
- Income statement.
- Loan reports.
- Deposit reports.
- Liquidity reports.
- Suspicious transaction reports.
- Capital adequacy reports.

Example:

```text
The bank may need to report total deposits, loans, and suspicious transactions
to the regulator within a required time period.
```

**Key idea:** financial reporting rules make banking activity transparent and accountable.

---

## 9. Compliance Workflow

A banking compliance workflow shows how customer and transaction activities are checked from registration to reporting.

Basic workflow:

```text
Customer Registration
  -> KYC Verification
  -> Account Opening
  -> Transaction Monitoring
  -> AML Screening
  -> Suspicious Detection
  -> Regulatory Reporting
```

---

## 10. Customer Registration

Customer registration is the first step where the bank collects customer information.

Collected information may include:

- Customer name.
- Date of birth.
- Phone number.
- Email.
- Address.
- ID document.
- Occupation.
- Source of income.

Example:

```text
A new customer submits their name, phone number, national ID,
address, and occupation to register with the bank.
```

---

## 11. KYC Verification

KYC verification checks whether the customer information is valid.

The bank may:

- Verify ID document.
- Check customer address.
- Confirm phone number.
- Review occupation and source of income.
- Check customer risk level.
- Screen against sanctions or watchlists.

KYC result:

```text
Approved
Rejected
Need more information
High-risk review required
```

---

## 12. Account Opening

After successful KYC verification, the bank can open the account.

Account opening may include:

- Assigning account number.
- Selecting account type.
- Setting account status.
- Creating digital banking access.
- Setting transaction limits.
- Recording customer consent.

Example:

```text
Customer passes KYC.
Bank opens a savings account.
Account status becomes Active.
```

---

## 13. Transaction Monitoring

Transaction monitoring checks customer transactions for unusual behavior.

The bank may monitor:

- Large cash deposits.
- Frequent transfers.
- Transactions to high-risk countries.
- Sudden changes in behavior.
- Many small deposits under reporting limits.
- Transactions that do not match customer profile.

Example:

```text
A student account suddenly receives many high-value international transfers.
The system flags the account for review.
```

---

## 14. AML Screening

AML screening checks customers and transactions against risk sources.

Screening may include:

- Sanctions lists.
- Politically exposed persons, also called PEPs.
- Watchlists.
- High-risk countries.
- Suspicious merchant or account lists.

Example:

```text
Before processing a transfer, the bank checks whether the sender or receiver
appears on a sanctions list.
```

---

## 15. Suspicious Detection

Suspicious detection identifies activity that may require investigation.

Suspicious activity can include:

- Unusual transaction size.
- Unusual transaction frequency.
- Unclear source of funds.
- Account behavior inconsistent with customer profile.
- Many transactions just below reporting threshold.
- Transfers involving high-risk parties.

Possible actions:

- Mark transaction for review.
- Request more customer information.
- Freeze or hold transaction according to policy.
- Escalate to compliance officer.
- Prepare suspicious transaction report.

---

## 16. Regulatory Reporting

Regulatory reporting is the process of submitting required reports to regulators.

Reports may include:

- Suspicious transaction reports.
- Large transaction reports.
- Monthly compliance reports.
- Financial reports.
- Risk reports.
- Audit reports.

Example:

```text
If a transaction is confirmed as suspicious,
the bank submits a suspicious transaction report to the regulator.
```

**Key idea:** reporting closes the compliance workflow by informing regulators when required.

---

## 17. Compliance Workflow Summary

| Step | Purpose | Output |
| --- | --- | --- |
| Customer registration | Collect customer information. | Customer profile created. |
| KYC verification | Verify identity and risk. | KYC approved, rejected, or reviewed. |
| Account opening | Create account after approval. | Active bank account. |
| Transaction monitoring | Watch account activity. | Alerts or normal activity. |
| AML screening | Check against AML risk sources. | Match, no match, or review. |
| Suspicious detection | Identify possible illegal activity. | Case created or escalated. |
| Regulatory reporting | Submit required reports. | Report sent to regulator. |

---

## 18. Compliance Architecture

**Compliance architecture** describes how banking systems, data, rules, checks, and reports work together to support compliance.

In a core banking system, compliance architecture connects:

- Customers.
- Accounts.
- Transactions.
- KYC verification.
- AML monitoring.
- Fraud verification.
- Risk scoring.
- Audit logs.
- Regulatory reporting.

### Core Banking Compliance Architecture

```text
Customer
  |
  | one customer can have many accounts
  v
Accounts
  |
  | each account can have many transactions
  v
Transactions
  |
  +--> KYC Verification
  +--> AML Monitoring
  +--> Fraud Verification
  +--> Risk Scoring
  +--> Audit Logs
  +--> Regulatory Reporting
```

### Main Data Relationship

```text
customers(customer_id, customer_name, kyc_status, risk_score)
accounts(account_id, customer_id, account_type, account_status)
transactions(transaction_id, account_id, transaction_date, amount, transaction_type)
```

Relationship:

```text
One customer -> many accounts
One account  -> many transactions
```

Example:

```text
Aung Aung can have:
- Savings account
- Current account
- Loan account

Each account can have many deposits, withdrawals, and transfers.
```

### Architecture Components

| Component | Purpose |
| --- | --- |
| **Customer module** | Stores customer profile and identity information. |
| **Account module** | Stores bank accounts linked to customers. |
| **Transaction module** | Stores deposits, withdrawals, transfers, and payments. |
| **KYC verification** | Checks customer identity and required documents. |
| **AML monitoring** | Monitors transactions for money laundering patterns. |
| **Fraud verification** | Detects unusual or potentially fraudulent activity. |
| **Risk scoring** | Gives customers or transactions a risk level. |
| **Audit logs** | Records important system actions for investigation. |
| **Regulatory reporting** | Prepares reports required by regulators. |

### KYC Verification in Architecture

KYC verification checks the customer before or during account opening.

```text
Customer submits information
  -> ID document checked
  -> Address checked
  -> Watchlist screening
  -> Risk level assigned
  -> KYC status updated
```

Possible KYC statuses:

```text
Pending
Verified
Rejected
Need Review
```

### AML Monitoring in Architecture

AML monitoring checks transaction patterns.

Examples:

- Large cash deposits.
- Frequent transfers.
- Transactions involving high-risk countries.
- Many small transactions under reporting limits.
- Transactions that do not match customer profile.

```text
Transaction created
  -> AML rules checked
  -> Alert created if suspicious
  -> Compliance officer reviews alert
```

### Fraud Verification in Architecture

Fraud verification focuses on suspicious behavior that may harm the customer or bank.

Examples:

- Login from unusual location.
- Sudden high-value transfer.
- Multiple failed login attempts.
- Card transaction from impossible location.
- Transaction pattern different from normal behavior.

```text
Transaction request
  -> Fraud rules checked
  -> Risk signal detected
  -> Transaction approved, held, or rejected
```

### Risk Scoring

**Risk scoring** assigns a risk level to customers, accounts, or transactions.

Risk factors may include:

- Customer occupation.
- Country or region.
- Transaction amount.
- Transaction frequency.
- KYC completeness.
- AML screening result.
- Fraud signals.

Example:

```text
Low risk    = normal customer behavior
Medium risk = unusual activity needs monitoring
High risk   = requires enhanced due diligence
```

### Audit Logs

**Audit logs** record important events in the banking system.

Audit logging records all important user and system activities.

Audit logs may store:

- Who logged in.
- Who changed customer data.
- Who approved KYC.
- Who opened an account.
- Who changed transaction status.
- When the action happened.

Example:

```text
2026-05-30 10:30
User: compliance_officer_01
Action: Approved KYC
Customer: C001
```

### Why Audit Logging Matters

| Purpose | Explanation |
| --- | --- |
| **Accountability** | Tracks who performed each action. |
| **Investigation** | Supports incident analysis when something goes wrong. |
| **Security** | Helps detect unauthorized access or suspicious system activity. |
| **Compliance** | Helps meet regulatory and audit requirements. |

### Audit Logging Architecture

```text
User / System Action
  -> Application Layer
  -> Audit Logging Service
  -> Audit Log Storage
  -> Monitoring and Alerting
  -> Compliance Review / Investigation / Reporting
```

### What Should Be Logged?

| Event Type | Example |
| --- | --- |
| Login activity | Successful login, failed login, logout. |
| Customer data changes | Customer phone, address, KYC status, risk score updated. |
| Account actions | Account opened, frozen, closed, or limit changed. |
| Transaction actions | Transaction created, held, approved, rejected, reversed. |
| Compliance actions | AML alert reviewed, suspicious case escalated, report submitted. |
| Permission changes | User role changed, permission granted, permission revoked. |

### Audit Log Fields

```text
audit_id
event_time
user_id
user_role
action_type
target_table
target_record_id
old_value
new_value
ip_address
device_info
result_status
```

### Audit Logging Best Practices

- Log both successful and failed sensitive actions.
- Protect audit logs from editing or deletion.
- Store timestamps accurately.
- Record who, what, when, where, and result.
- Review logs regularly.
- Generate alerts for unusual activities.
- Keep logs according to regulatory retention rules.

Best practices diagram:

```text
                    Audit Logging Best Practices
                                 |
        -----------------------------------------------------
        |          |             |             |             |
        v          v             v             v             v
 Immutable   Centralized    Log Retention   Monitor      Encrypt
   Logs     Audit Storage     Policies     Privileged     Audit
                                             Users        Records
        \          |             |             |             /
         ---------------------------------------------------
                                 |
                                 v
                        Real-Time Alerting
```

| Best Practice | Purpose |
| --- | --- |
| **Immutable logs** | Prevent audit records from being edited or deleted. |
| **Centralized audit storage** | Store logs in one protected place for review and reporting. |
| **Log retention policies** | Define how long logs must be kept for compliance. |
| **Monitor privileged users** | Watch admin and high-access users closely. |
| **Encrypt audit records** | Protect logs from unauthorized reading or tampering. |
| **Real-time alerting** | Notify security or compliance teams immediately when suspicious activity happens. |

**Key idea:** audit logs help with investigation, accountability, and regulatory review.

### Regulatory Reporting in Architecture

Regulatory reporting uses data from customers, accounts, transactions, alerts, and audit logs.

```text
Customer + Account + Transaction + Alert + Audit Data
  -> Compliance Report
  -> Submitted to Regulator
```

Examples:

- Suspicious transaction report.
- Large transaction report.
- KYC completion report.
- Monthly compliance report.
- Fraud incident report.

### Compliance Architecture Summary

```text
Customer Data
  -> Account Data
  -> Transaction Data
  -> Compliance Checks
  -> Alerts and Risk Scores
  -> Audit Logs
  -> Regulatory Reports
```

**Key idea:** compliance architecture makes sure banking activity is checked, recorded, scored, and reported.

---

## 19. Example Compliance Scenario

Scenario:

```text
A new customer opens an account and later receives several large transfers
from unknown sources.
```

Workflow:

```text
1. Customer registers with ID and address.
2. Bank performs KYC verification.
3. Account is opened after approval.
4. System monitors incoming transfers.
5. AML screening checks sender and receiver risk.
6. Large unusual transfers are flagged.
7. Compliance officer reviews the case.
8. If suspicious, bank reports to regulator.
```

---

## 20. Exercises

### Exercise 1: Compliance Areas

Match each area with its purpose:

| Area | Purpose |
| --- | --- |
| Central Bank regulations |  |
| AML laws |  |
| KYC requirements |  |
| Data privacy laws |  |
| Security standards |  |
| Financial reporting rules |  |

### Exercise 2: KYC Information

List five pieces of customer information a bank may collect during KYC.

### Exercise 3: Compliance Workflow

Put these steps in the correct order:

```text
AML Screening
Account Opening
Customer Registration
Regulatory Reporting
Transaction Monitoring
KYC Verification
Suspicious Detection
```

### Exercise 4: Suspicious Activity

Give three examples of suspicious banking activity.

### Exercise 5: Compliance Architecture

Design a simple compliance architecture with these entities:

- Customer
- Account
- Transaction
- KYC Verification
- AML Alert
- Audit Log
- Regulatory Report

Show which entities connect to each other.

---

## 21. Review Questions

1. What is compliance?
2. What is compliance in banking?
3. Why do banks need compliance?
4. What are Central Bank regulations?
5. What does AML mean?
6. What does KYC mean?
7. Why is data privacy important in banking?
8. What are examples of security standards?
9. What is transaction monitoring?
10. What is AML screening?
11. What is suspicious detection?
12. What is regulatory reporting?
13. What are the steps in a basic banking compliance workflow?
14. What is compliance architecture?
15. Why can one customer have many accounts?
16. Why can one account have many transactions?
17. What is the purpose of risk scoring?
18. Why are audit logs important in compliance?
