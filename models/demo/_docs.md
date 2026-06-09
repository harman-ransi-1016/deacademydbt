{% docs insert_dts %}
Audit timestamp set to CURRENT_TIMESTAMP when dbt first wrote the row.
Used as the incremental watermark. Distinct from the source CREATED_AT.
{% enddocs %}