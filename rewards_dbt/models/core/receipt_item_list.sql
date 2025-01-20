-- The purpose of this model is to flatten out the rewards_receipt_item_list JSON
-- column from the receipts model. Many column values are null.
{{ config(materialized='table') }}

with flattened_receipts as (
    select
        receipt_id,
        unnest(rewards_receipt_item_list) as items
    from
        {{ ref('receipts') }}
)

  select
    receipt_id,
    try_cast(items."barcode" as bigint) as barcode, -- This will invalidate barcodes like B076FJ92M4
    items."brandCode" as brand_code,
    items."competitorRewardsGroup" as competitor_rewards_group,
    items."competitiveProduct" as is_competitive_product,
    items."description",
    try_cast(items."discountedItemPrice" as numeric(18,2)) as discounted_item_price,
    try_cast(items."finalPrice" as numeric(18,2)) as final_price,
    items."itemNumber" as item_number,
    try_cast(items."itemPrice" as numeric(18,2)) as item_price,
    items."needsFetchReview" as needs_fetch_review,
    items."needsFetchReviewReason" as needs_fetch_review_reason,
    try_cast(items."originalFinalPrice" as numeric(18,2)) as original_final_price,
    items."originalMetaBriteBarcode" as original_metabrite_barcode,
    items."metabriteCampaignId" as metabrite_campaign_id,
    items."originalMetaBriteDescription" as original_metabrite_description,
    items."originalMetaBriteItemPrice" as original_metabrite_item_price,
    items."originalMetaBriteQuantityPurchased" as original_metabrite_quantity_purchased,
    items."originalReceiptItemText" as original_receipt_item_text,
    items."partnerItemId" as partner_item_id,
    items."pointsEarned" as points_earned,
    items."pointsPayerId" as points_payer_id,
    items."pointsNotAwardedReason" as points_not_awarded_reason,
    items."preventTargetGapPoints"::boolean as prevent_target_gap_points,
    items."priceAfterCoupon" as price_after_coupon,
    items."quantityPurchased" as quantity_purchased,
    items."rewardsGroup" as rewards_group,
    items."rewardsProductPartnerId" as rewards_product_partner_id,
    try_cast(items."targetPrice" as numeric(18,2)) as target_price,
    try_cast(items."userFlaggedBarcode" as bigint) as user_flagged_barcode,
    items."userFlaggedDescription" as user_flagged_description,
    items."userFlaggedNewItem"::boolean as is_user_flagged_new_item,
    try_cast(items."userFlaggedPrice" as numeric(18,2)) as user_flagged_price,
    items."userFlaggedQuantity" as user_flagged_quantity
from
    flattened_receipts
where
    -- Remove any rows where deleted is true
    coalesce(items."deleted"::boolean, False) != True
