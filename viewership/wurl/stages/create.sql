create or replace stage wurl_viewership url='s3://nosey-snowflake/viewership/wurl' 
credentials=(aws_key_id='ENV[AWS_KEY_ID]' aws_secret_key='ENV[AWS_SECRET_ACCESS_KEY]')
file_format = nosey_viewership;

