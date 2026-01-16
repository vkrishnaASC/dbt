{% snapshot student_snapshot %}
{{
    config(target_schema='snapshots', unique_key='student_id', strategy='check', check_cols=['major'])
}}
select student_id, major from {{ ref('stg_enrollments') }}
qualify row_number() over (partition by student_id order by enrollment_date desc) = 1
{% endsnapshot %}