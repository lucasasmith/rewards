
{{ config(materialized='table') }}

with source as (
    select *
    from
        {{ source("rewards_raw", "users") }}
)

select
    "_id"."$oid" as user_id,
    epoch_ms(createdDate."$date") as created_date,
    active as is_active,
    epoch_ms(lastLogin."$date") as last_login_date,
    role,
    signUpSource as signup_source,
    state
from
    source
