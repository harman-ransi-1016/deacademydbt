-- make a configuration so it knows that whatever you select from this query, build as table (it is default a window)
-- this is why you need to make a config
{{
    config(
       materialized = 'table'
    )
}}

-- we are taking employee raw and we are making a brand new table!
-- we can use DBT to transform raw data in data warehouse and apply a transformation
with employee as (
    select
        EMPID as emp_id,
        split_part(NAME, ' ', 1)  as emp_firstname,
        split_part(NAME, ' ', 2)  as emp_lastname,
        SALARY as emp_salary,
        HIREDATE as emp_hiredate,
        split_part(ADDRESS, ',', 1) as emp_street,
        split_part(ADDRESS, ',', 2) as emp_city,
        split_part(ADDRESS, ',', 3) as emp_country,
        split_part(ADDRESS, ',', 4) as emp_zipcode
    -- if the raw table is from 10 models
    -- if we want to change to a different schema...
    -- we therefore want to link to the source and will find the path instead of you having to specify it
    from {{ source('employee', 'EMPLOYEE_RAW') }}
)

select * from employee