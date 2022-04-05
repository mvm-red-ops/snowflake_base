create or replace stage episode_details url='s3://nosey-snowflake/revenue' 
credentials=(aws_key_id='ENV[AWS_KEY_ID]' aws_secret_key='ENV[AWS_SECRET_ACCESS_KEY]')
file_format = nosey_viewership;


create or replace stage distribution_partners_revenue url='s3://nosey-snowflake/distribution_partners/revenue' 
credentials=(aws_key_id='AKIAUASF4VJ5U54QA6ML' aws_secret_key='7j8Q8przvk6drvNsgRNE6gnV39LZB31dqFe20fcS')
file_format = nosey_viewership;


create or replace stage pluto_viewership url='s3://nosey-snowflake/viewership/Pluto' 
credentials=(aws_key_id='ENV[key_id]' aws_secret_key='ENV[secret_key')
file_format = nosey_viewership;


create or replace stage wurl_viewership url='s3://nosey-snowflake/viewership/wurl' 
credentials=(aws_key_id='ENV[AWS_KEY_ID]' aws_secret_key='ENV[AWS_SECRET_ACCESS_KEY]')
file_format = nosey_viewership;



create or replace stage pluto_viewership url='s3://nosey-snowflake/viewership/Pluto' 
credentials=(aws_key_id='ENV[key_id]' aws_secret_key='ENV[secret_key')
file_format = nosey_viewership;

nosey_assets

expenses

nosey_revenue

owned_and_operated