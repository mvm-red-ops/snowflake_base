create or replace stage pluto_viewership url='s3://nosey-snowflake/viewership/Pluto' 
credentials=(aws_key_id='AKIAUASF4VJ5VLO3CUBJ' aws_secret_key='f9F1CoeIrX/WPrvZDPqAw2Y+8rlOA128HV/bdeMB')
file_format = nosey_viewership;



