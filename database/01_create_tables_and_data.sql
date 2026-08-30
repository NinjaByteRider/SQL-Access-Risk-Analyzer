select current_database();

--Create tables

create table if NOT EXISTS roles(role_id INT primary key, role_name VARCHAR(50), privilege_level INT);

create table if NOT EXISTS users (user_id INT primary key, username VARCHAR(50), department VARCHAR(50), role_id INT, enabled BOOLEAN, mfa_enabled BOOLEAN, created_date DATE, foreign key (role_id) references roles(role_id));

create table if NOT EXISTS login_history (login_id INT primary key, user_id INT, login_date DATE, failed_logins INT, source_ip VARCHAR(45), foreign key (user_id) references users(user_id));

create table if NOT EXISTS access_reviews (review_id INT primary key, user_id INT, review_date DATE, reviewer VARCHAR(50), result VARCHAR(20), foreign key (user_id) references users(user_id));

-- Insert sample role data

insert into roles (role_id, role_name, privilege_level)
values
    (1, 'User', 1),
    (2, 'Admin', 5),
    (3, 'Super Admin', 10);

-- Insert sample user data

insert into users (
         user_id, 
         username,
         department,
         role_id,
         enabled,
         mfa_enabled,
         created_date)
values 
         (1, 'alice', 'Finance', 2, true, true, '2026-01-10'),
         (2, 'bob', 'IT', 3, true, false, '2025-11-15'),
         (3, 'chris', 'HR', 1, false, true, '2025-09-20'),
         (4, 'david', 'Finance', 1, true, false, '2026-02-01'),
         (5, 'emma', 'IT', 2, true, true, '2025-12-05');

-- Insert sample login history data

insert into login_history (
    login_id,
    user_id,
    login_date,
    failed_logins,
    source_ip)
values 
    (101, 1, '2026-08-01', 0, '10.0.0.11'),
    (102, 1, '2026-08-10', 2, '10.0.0.11'),
    (103, 1, '2026-08-20', 5, '10.0.0.11'),
    (104, 2, '2026-08-02', 1, '10.0.0.22'),
    (105, 2, '2026-08-12', 4, '10.0.0.22'),
    (106, 2, '2026-08-22', 8, '203.0.113.25'),
    (107, 3, '2026-07-15', 0, '10.0.0.33'),
    (108, 4, '2026-08-05', 1, '10.0.0.44'),
    (109, 4, '2026-08-18', 3, '10.0.0.44'),
    (110, 5, '2026-08-03', 0, '10.0.0.55'),
    (111, 5, '2026-08-15', 1, '10.0.0.55'),
    (112, 5, '2026-08-25', 1, '10.0.0.55');

-- Insert sample access review data

insert into access_reviews (
     review_id,
     user_id,
     review_date,
     reviewer,
     result)
values 
     (201, 1, '2026-03-01', 'Sarah', 'Pass'),
     (202, 1, '2026-08-01', 'Michael', 'Pass'),
     (203, 2, '2026-03-05', 'Sarah', 'Pass'),
     (204, 2, '2026-08-05', 'Michael', 'Fail'),
     (205, 3, '2026-02-15', 'Sarah', 'Pass'),
     (206, 4, '2026-04-10', 'Michael', 'Pass');