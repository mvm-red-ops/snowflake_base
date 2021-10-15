create or replace stage episode_details url='s3://nosey-snowflake/revenue' 
credentials=(aws_key_id='AKIAUASF4VJ5SJXUSEO2' aws_secret_key='p7YsiyJScXh7wRduTrbfqCyVM/RFZQemDKfyJZuR')
file_format = nosey_viewership;