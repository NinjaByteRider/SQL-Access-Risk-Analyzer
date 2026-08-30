-- Identify high-risk users based on privilege, MFA, and recent failed logins.

with highrisk as (
     select username,
            users.user_id,
            roles.role_id,
            login_history.failed_logins,
            login_history.login_date,
            ROW_NUMBER()over(
                  partition by login_history.user_id
                  order by login_date DESC) as latest_login
      from users
      join roles
      on users.role_id = roles.role_id
      join login_history
      on users.user_id = login_history.user_id
      where role_name in ('Admin', 'Super Admin')
      and 	mfa_enabled = FALSE)
select username,
       latest_login
from highrisk
where latest_login = 1
and failed_logins >= 5