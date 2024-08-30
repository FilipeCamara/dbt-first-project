{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}
WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)
SELECT * FROM src_reviews
WHERE review_text IS NOT NULL
{% if is_incremental() %} -- starting Jinja if statement
  AND review_date > (SELECT MAX(review_date) FROM {{ this }}) -- "this" refers to current sql
{% endif %}