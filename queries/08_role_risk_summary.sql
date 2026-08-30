-- Summarize user risk indicators by role.

with allinfo as (
     select role_name,
            SUM(
                case
                	when mfa_enabled = FALSE then 1
                	else 0
                end
                ) as no_mfa_users,
             SUM(
                case
                	when enabled = FALSE then 1
                	else 0
                end
                ) as disabled_users,
              COUNT (*) as total_users
     from users
     join roles
     on users.role_id = roles.role_id
     group by roles.role_name)
select role_name,
       total_users,
       no_mfa_users,
       disabled_users
from allinfo;