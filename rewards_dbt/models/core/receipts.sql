{{ config(materialized='table') }}

with source as (
    select *
    from
        {{ source("rewards_raw", "receipts") }}
)

select
    "_id"."$oid" as id,
    bonusPointsEarned as bonus_points_earned,
    bonusPointsEarnedReason as bonus_points_earned_reason,
    epoch_ms(createDate."$date") as create_date,
    epoch_ms(dateScanned."$date") as scanned_date,
    epoch_ms(finishedDate."$date") as finished_date,
    epoch_ms(modifyDate."$date") as modify_date,
    epoch_ms(pointsAwardedDate."$date") as points_awarded_date, -- true if awarded
    try_cast(pointsEarned as numeric(18,2)) as points_earned,
    epoch_ms(purchaseDate."$date") as purchase_date,
    purchasedItemCount as purchase_item_count,
    rewardsReceiptItemList as rewards_receipt_item_list,
    rewardsReceiptStatus as rewards_receipt_status,
    try_cast(totalSpent as numeric(18,2)) as total_spent,
    userId as user_id
from
    source