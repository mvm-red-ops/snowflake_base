create or replace stage wurl_viewership url='s3://nosey-snowflake/viewership/wurl' 
credentials=(aws_key_id='AKIAUASF4VJ5SJXUSEO2' aws_secret_key='p7YsiyJScXh7wRduTrbfqCyVM/RFZQemDKfyJZuR')
file_format = nosey_viewership;

