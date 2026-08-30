-- Produce a consolidated user access risk report.

WITH latestlogin AS (
     SELECT users.user_id,
            mfa_enabled,
            enabled,
            failed_logins,
            login_date,
            role_name,
            ROW_NUMBER() OVER (
                PARTITION BY users.user_id
                ORDER BY login_date DESC) AS row_num
     FROM users
     LEFT JOIN login_history
     ON users.user_id = login_history.user_id
     LEFT JOIN roles
     ON users.role_id = roles.role_id),
     latestreview AS (
     SELECT username,
            users.user_id,
            result,
            ROW_NUMBER() OVER (
               PARTITION BY users.user_id
               ORDER BY review_date DESC) AS row_num
     FROM users
     LEFT JOIN access_reviews
     ON users.user_id = access_reviews.user_id)
SELECT username,
       role_name,
       mfa_enabled,
       enabled,
       failed_logins,
       result,
       DATE '2026-08-30' - login_date AS days_since_login,
       CASE 
       	WHEN (role_name IN ('Admin', 'Super Admin') AND mfa_enabled IS FALSE)
       	OR failed_logins >= 5
       	OR result = 'Fail' THEN 'High Risk'
       	WHEN enabled IS FALSE OR DATE '2026-08-30' - login_date > 30 THEN 'Medium Risk'
       	ELSE 'Low Risk'
       END AS risk_level
FROM latestlogin
JOIN latestreview 
ON latestlogin.user_id = latestreview.user_id
WHERE latestlogin.row_num = 1
AND latestreview.row_num = 1;    