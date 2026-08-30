-- Compare each user's latest failed_login count with their historical average.

WITH comparelogin AS (
     SELECT username,
            login_date,
            failed_logins,
            ROW_NUMBER() OVER (
                PARTITION BY login_history.user_id
                ORDER BY login_date DESC) AS row_num,
            AVG (failed_logins) OVER (
                PARTITION BY login_history.user_id) AS avg_failed_logins
     FROM users
     JOIN login_history
     ON users.user_id = login_history.user_id)
SELECT username,
       login_date,
       failed_logins,
       row_num,
       avg_failed_logins
FROM comparelogin
WHERE row_num = 1
AND failed_logins > avg_failed_logins;      