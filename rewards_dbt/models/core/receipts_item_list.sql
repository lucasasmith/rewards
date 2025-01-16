{{ config(materialized='table') }}

with flattened_receipts as (
    select
        id as receipt_id,
        unnest(rewards_receipt_item_list) as items
    from
        {{ ref('receipts') }}
)

  select
    receipt_id,
    items."barcode", -- varchar
    items."brandCode" as brand_code,
    items."competitorRewardsGroup" as competitor_rewards_group,
    items."competitiveProduct" as is_competitive_product, -- bool
    items."description", -- varchar
    try_cast(items."discountedItemPrice" as numeric(18,2)) as discounted_item_price, -- numeric
    items."finalPrice" as final_price, -- numeric
    items."itemNumber" as item_number, -- varchar
    items."itemPrice" as item_price, -- numeric
    items."needsFetchReview" as needs_fetch_review, -- bool
    items."needsFetchReviewReason" as needs_fetch_review_reason, -- varchar
    items."originalFinalPrice" as original_final_price, -- numeric
    items."originalMetaBriteBarcode" as original_metabrite_barcode,
    items."metabriteCampaignId" as metabrite_campaign_id,
    items."originalMetaBriteDescription" as original_metabrite_description,
    items."originalMetaBriteItemPrice" as original_meta_brite_item_price,
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
    items."targetPrice" as target_price,
    items."userFlaggedBarcode" as user_flagged_barcode, -- varchar
    items."userFlaggedDescription" as user_flagged_description, -- varchar
    items."userFlaggedNewItem"::boolean as is_user_flagged_new_item,
    items."userFlaggedPrice" as user_flagged_price,
    items."userFlaggedQuantity" as user_flagged_quantity,
    items."deleted"::boolean as is_deleted
from
    flattened_receipts
