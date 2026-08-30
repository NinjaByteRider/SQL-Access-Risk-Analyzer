-- Identify user whose latest login is more than 30 days old.

WITH oldlogins AS (
     SELECT username,
            login_date,
            ROW_NUMBER() OVER (
                 PARTITION BY login_history.user_id
                 ORDER BY login_date) AS row_num
     FROM users
     LEFT JOIN login_history
     ON users.user_id = login_history.user_id)
SELECT username,
       login_date,
       DATE '2026-08-30' - login_date AS days_since_login
FROM oldlogins 
WHERE row_num = 1
AND DATE '2026-08-30' - login_date > 30;