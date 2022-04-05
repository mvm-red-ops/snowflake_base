

-- distribution_partners
create or replace stage distribution_partners_viewership url='s3://nosey-snowflake/distribution_partners/viewership' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

create or replace stage distribution_partners_revenue url='s3://nosey-snowflake/distribution_partners/revenue' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

create or replace stage distribution_partners_expenses url='s3://nosey-snowflake/distribution_partners/expenses' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;






-- owned_and_operated_
create or replace stage oo_viewership url='s3://nosey-snowflake/owned_and_operated/viewership' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

create or replace stage oo_revenue url='s3://nosey-snowflake/owned_and_operated/revenue' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

create or replace stage oo_expenses url='s3://nosey-snowflake/owned_and_operated/expenses' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

create or replace stage oo_ad_data url='s3://nosey-snowflake/owned_and_operated/ad_data' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;


-- other
create or replace stage nosey_assets url='s3://nosey-snowflake/assets' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;
