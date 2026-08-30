-- Identify user whose most recent access review failed.

with latestreview as (
     select users.username,
            access_reviews.review_date,
            access_reviews.reviewer,
            access_reviews.result,
            ROW_NUMBER() over (
                partition by access_reviews.user_id
                order by review_date DESC) as row_num
     from users
     join access_reviews
     on users.user_id = access_reviews.user_id)
select username,
       review_date,
       reviewer,
       result
from latestreview
where row_num = 1
and result = 'Fail';