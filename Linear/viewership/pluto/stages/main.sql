create or replace stage pluto_viewership url='s3://nosey-snowflake/viewership/Pluto' 
credentials=(aws_key_id='ENV[key_id]' aws_secret_key='ENV[secret_key')
file_format = nosey_viewership;









