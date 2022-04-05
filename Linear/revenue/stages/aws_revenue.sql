create or replace stage episode_details url='s3://nosey-snowflake/revenue' 
credentials=(aws_key_id='ENV[AWS_KEY_ID]' aws_secret_key='ENV[AWS_SECRET_ACCESS_KEY]')
file_format = nosey_viewership;



CREATE OR REPLACE FILE FORMAT nosey_csv
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1
  ESCAPE_UNENCLOSED_FIELD = None
  RECORD_DELIMITER = '\n'
  FILE_EXTENSION = '.csv'
  NULL_IF = ('#N/A', ' ', '')
  REPLACE_INVALID_CHARACTERS = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY='"'
  SKIP_BLANK_LINES = TRUE;

create or replace stage distribution_partners_revenue url='s3://nosey-snowflake/distribution_partners/revenue' 
credentials=(aws_key_id='' aws_secret_key='')
file_format = nosey_viewership;

