{{ config(materialized='view') }}

with source as (
    select * from {{ source('sales', 'SALES_SRC') }}
),

renamed as (
    select
        sale_id,
        sale_date,
        customer_id,
        product_id,
        quantity,
        total_amount,
        created_at
    from source
)

select * from renamed