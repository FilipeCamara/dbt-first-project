{{ config(
    materialized = 'table',
)}}

WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
),
full_moon_dates AS (
    SELECT * FROM {{ ref('seed_full_moon_dates') }}
)
SELECT
    f.*,
    CASE
      WHEN fm.full_moon_date IS NULL THEN 'Not full moon'
      ELSE 'Full moon'
    END AS is_full_moon
FROM fct_reviews f
    LEFT JOIN full_moon_dates fm
    ON (TO_DATE(f.review_date) = DATEADD(DAY, 1, fm.full_moon_date))