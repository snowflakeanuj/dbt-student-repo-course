{{
    config(
        materialized = 'table'
    )
}}

with fct_reviews as (
    select * from {{ ref('fct_reviews') }}
),
full_moon_dates as(
    select * from {{ ref('seed_full_moon_dates')}}
)
select 
    r.*,
    (CASE
        WHEN f.full_moon_date is null then 'NO'
        ELSE 'YES'
    END) AS is_full_moon_review
from fct_reviews r
left join full_moon_dates f
    on (TO_DATE(r.review_date) = DATEADD('day', 1, f.full_moon_date))
    
    