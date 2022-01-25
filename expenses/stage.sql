create or replace stage expenses url='s3://nosey-snowflake/expenses' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;