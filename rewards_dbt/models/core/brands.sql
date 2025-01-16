{{ config(materialized='table') }}

with source as (
    select *
    from
        {{ source("rewards_raw", "brands") }}
)

select
    "_id"."$oid" as id,
    barcode::bigint as barcode,
    brandCode as brand_code,
    lower(category) as category,
    lower(categoryCode) as category_code,
    cpg."$ref" as cpg_ref,
    cpg."$id"."$oid" as cpg_id,
    name,
    topBrand as is_top_brand
from
    source