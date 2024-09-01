SELECT * FROM {{ ('fct_reviews') }} F
INNER JOIN {{ ('dim_listings_cleansed') }} D
USING (listing_id)
WHERE D.CREATED_AT >= F.REVIEW_DATE