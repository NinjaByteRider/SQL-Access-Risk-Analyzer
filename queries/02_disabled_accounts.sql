-- Identify disabled user accounts.

select username,
       department,
       role_name,
       enabled
from users
join roles
on users.role_id = roles.role_id 
where enabled = false
and role_name is not null;