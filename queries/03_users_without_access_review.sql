-- Identify users who have never had an access review.

select username,
       department,
       users.user_id
from users
left join access_reviews
on users.user_id = access_reviews.user_id
where access_reviews.user_id is null;