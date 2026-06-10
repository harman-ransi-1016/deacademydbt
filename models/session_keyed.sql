{{ config(materialized='view')}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['session_id', 'user_id'])}} as session_key,
    session_id,
    user_id,
    device_type,
    pages_visited
from {{ ref('session') }}