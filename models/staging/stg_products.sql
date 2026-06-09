{{ config(materialized='view') }}

with source as (
    select * from {{ source('product', 'PRODUCT_SRC') }}
),

renamed as (
    select
        product_id,
        product_name,
        product_price,
        created_at
    from source
)

select * from renamed