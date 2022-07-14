
CREATE OR REPLACE  FILE FORMAT  GENERIC_CSV
                      TYPE =  CSV  
                      skip_header = 1
                      TRIM_SPACE = TRUE
                      NULL_IF = ('NULL')
                      FIELD_DELIMITER = ',' 
                      RECORD_DELIMITER = '\n' 
                      FIELD_OPTIONALLY_ENCLOSED_BY = '\042' 
                      ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 


	
    		

create or replace file format nosey_viewership
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1
  ESCAPE_UNENCLOSED_FIELD = None
  RECORD_DELIMITER = '\n'
  FILE_EXTENSION = '.csv'
  NULL_IF = ('#N/A', ' ', '')
  REPLACE_INVALID_CHARACTERS = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY='"';



create or replace file format nosey_assets
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1
  ESCAPE_UNENCLOSED_FIELD = None
  RECORD_DELIMITER = '\n'
  FILE_EXTENSION = '.csv'
  NULL_IF = ('#N/A', ' ', '')
  REPLACE_INVALID_CHARACTERS = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY='"';



