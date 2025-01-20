## Data Quality Results
Data quality issues can be found by running `dbt test`. This command runs the data tests setup in the `core.yml` file and utilize the data quality testing features of dbt. In a production environment, most if not all these tests would be set to fail a pipeline. In this scenario, they are set to warn. Sometimes the output of these tests inside the dbt CLI aren't the easiest to understand. Possible helpful solutions to this would be calling them with a Python script that would allow for much more custom logging or using a 3rd party tool to help format and track failures.

See the `core.yml` file and the `data_tests` for more information on each data quality test.

An example of issues found are:
```
16:52:46  Warning in test dbt_expectations_expect_column_pair_values_A_to_be_greater_than_B_receipt_finished_date__created_date (models/core/core.yml)
16:52:46  Got 165 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_872d7b85be62e73cbde4966cdeda16a7.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_be_between_receipt_points_earned__5000__0 (models/core/core.yml)
16:52:46  Got 14 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_cf12cebc4ae21c82490f2757ea3efe5b.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_be_between_receipt_purchased_item_count__100__1 (models/core/core.yml)
16:52:46  Got 46 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_1654d2abc583375c019f81417ac53ac4.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_not_be_in_set_receipt_item_list_description__True__ITEM_NOT_FOUND (models/core/core.yml)
16:52:46  Got 173 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_d9fec17ac55cc238867a5487658b39e6.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_not_match_like_pattern_list_brand_name___test____TEST___all (models/core/core.yml)
16:52:46  Got 429 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_62b9f9be1c0c6da1d25ac70a8985c93f.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_not_be_in_set_receipt_item_list_barcode__False__4011 (models/core/core.yml)
16:52:46  Got 177 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_0f0df90e925958c76a83be5554c66cd1.sql
16:52:46  
16:52:46  Warning in test dbt_expectations_expect_column_values_to_not_match_like_pattern_list_brand_brand_code___test____TEST___all (models/core/core.yml)
16:52:46  Got 360 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/dbt_expectations_expect_column_cc10849e2a107b24cd055e491ac23cf1.sql
16:52:46  
16:52:46  Warning in test unique_brand_barcode (models/core/core.yml)
16:52:46  Got 7 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/unique_brand_barcode.sql
16:52:46  
16:52:46  Warning in test relationships_receipt_user_id__user_id__ref_user_ (models/core/core.yml)
16:52:46  Got 148 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/relationships_receipt_user_id__user_id__ref_user_.sql
16:52:46  
16:52:46  Warning in test unique_user_user_id (models/core/core.yml)
16:52:46  Got 70 results, configured to warn if != 0
16:52:46  
16:52:46    compiled code at target/compiled/rewards_dbt/models/core/core.yml/unique_user_user_id.sql
16:52:46  
16:52:46  Done. PASS=9 WARN=10 ERROR=0 SKIP=0 TOTAL=19
```


### Source Data Freshness
With the raw data provided, we don't have a consistent reliable `_loaded_at` or `_modified_at` column for wich to test data freshness with. In a production environment, we'd want the ingestion process to provide a timestamp on data load so we can verify that the raw data we have is within a specific time threshold for the most recent data. For example, we could test if data from the `core.receipt` tables has at least one row within the last 24 hours and warn or error if not.
