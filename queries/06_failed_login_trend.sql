-- Identify increase in failed login activity over time.

with failedlogintrend as(
      select users.username,
             login_history.failed_logins,
             login_history.login_date,
             lag(failed_logins) over (
                 partition by login_history.user_id 
                 order by login_date) as previous_failed_logins
      from users
      join login_history
      on users.user_id = login_history.user_id)
select username,
       login_date,
       failed_logins,
       previous_failed_logins,
       failed_logins - previous_failed_logins as increase_amount
from failedlogintrend
where failed_logins > previous_failed_logins;