create or replace stage episode_details url='s3://nosey-snowflake/revenue' 
credentials=(aws_key_id='ENV[AWS_KEY_ID]' aws_secret_key='ENV[AWS_SECRET_ACCESS_KEY]')
file_format = nosey_viewership;


