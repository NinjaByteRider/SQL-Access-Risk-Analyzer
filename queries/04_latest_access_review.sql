-- Return the most recent access review for each user.

with latestReview as (
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
from latestReview
where row_num = 1;