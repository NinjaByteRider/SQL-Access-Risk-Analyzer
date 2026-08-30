-- Identify privileged users who do not have MFA enabled.

select username,
       department,
       role_name,
       privilege_level,
       mfa_enabled
from users
join roles 
on users.role_id = roles.role_id
where role_name = 'Admin'
or role_name = 'Super Admin'
and mfa_enabled = false;