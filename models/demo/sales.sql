{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with sales_src as (
    select
        SALE_ID,
        SALE_DATE,
        CUSTOMER_ID,
        PRODUCT_ID,
        QUANTITY,
        TOTAL_AMOUNT,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    from {{ source('sales', 'SALES_SRC') }}
    -- when this builds, its gonna see if data already exists. If it doesm it will only select data from elsewhere. 
    {% if is_incremental() %}
    where CREATED_AT > (select max(INSERT_DTS) from {{ this }})
    {% endif %}
)

select * from sales_src