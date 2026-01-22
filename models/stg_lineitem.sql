{{ config(materialized='table') }}

select
    l_orderkey,
    l_linenumber,
    l_tax,
    l_extendedprice,
    l_shipmode,
    l_returnflag
from {{ source('snowflake_sample', 'lineitem') }}