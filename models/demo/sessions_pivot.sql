{{ config(materialized='table')}}

{% set device_types = ['Desktop', 'Laptop', 'Mobile', 'Tablet']%}

SELECT
    browser,
    {% for device in device_types %}
    sum(case when device_type = '{{ device }}' then pages_visited else 0 end) as {{ device | lower }}_page
    {% if not loop.last %}, {% endif %}
    {% endfor %}
FROM {{ source('session', 'SESSION_SRC')}}
group by browser