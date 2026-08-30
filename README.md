</> Markdown
# SQL Access Risk Analyzer
## Overview
This project demonstrates SQL-based audit analytics for user access, authentication activity, and access review monitoring.

The database contains sample user, role, login history, and access review data. The SQL queries identify potential access-control and security risks that may be relevant during an IT audit or security assurance review.

## Database Tables
The project uses four tables:

- 'roles' - user role and privilege information
- 'users' - user account, department, MFA, and account status information
- 'login_history' - login dats, failed login attempts, and source IP addresses
- 'access_reviews' - access review dates, reviewers, and review results

## Audit Queries
The project includes SQL queries for:

1. Identifying privileged users without MFA
2. Identifying disabled accounts
3. Finding users without access reviews
4. Retrieving the latest access review for each user
5. Identifying users whose latest access review failed
6. Analyzing increases in failed login activity
7. Identifying high-risk privileged users
8. Summarizing risk indicators by role
9. Comparing recent failed-login activity to historical average
10. identifying inactive or stale accounts
11. Producing a consolidated user access risk report

## SQL Techniques Demonstrated
This project uses:

- INNER JOIN
- LEFT JOIN
- GROUP BY
- CASE expressions
- Conditional aggregation
- Common Table Expressions (CTEs)
- Subqueries
- Window functions
- 'ROW_NUMBER()'
- 'LAG()'
- 'AVG() OVER()'
- 'PARTITION BY'
- Date calculations
- NULL handling

## Final Risk Report
The final audit query combines multiple risk indicators and classifies users as:

- **High Risk** - privileged users without MFA, users with high failed-login activity, or users with a failed access review
- **Medium Risk** - disabled accounts or accounts with stale login activity
- **Low Risk** - users without the defined high- or medium-risk indicators

## Project Structure
```text
SQL-Access-Risk-Analyzer/
├── README.md
├── database/
│   └── 01_create_tables_and_data.sql
└── queries/
    ├── 01_privileged_users_without_mfa.sql
    ├── 02_disabled_accounts.sql
    ├── 03_users_without_access_review.sql
    ├── 04_latest_access_review.sql
    ├── 05_latest_failed_access_reviews.sql
    ├── 06_failed_login_trend.sql
    ├── 07_high_risk_users.sql
    ├── 08_role_risk_summary.sql
    ├── 09_latest_login_vs_average.sql
    ├── 10_inactive_or_stale_accounts.sql
    └── 11_audit_risk_report.sql