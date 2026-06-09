{{ config(materialized='table') }}

with sales as (
    select * from {{ ref('stg_sales') }}
)

select
    customer_id,
    count(sale_id)    as number_of_sales,
    sum(total_amount) as total_spend
from sales
group by customer_id