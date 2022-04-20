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



