
{% snapshot orders_hist %}

{{
    config(
      target_database='analytics',
      target_schema='scdschema',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='order_date',
    )
}}

select * from {{ ref('stg_orders') }}

{% endsnapshot %}