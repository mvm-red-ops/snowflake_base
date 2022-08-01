-- standardize function used to populate 'formatted_title' column
create or replace function standardize(a String)
returns string
strict immutable
COMMENT = 'Removes non-alphanumeric characters and casts the result to UPPER case'
as $$ select REGEXP_REPLACE(LOWER(a),'[^A-Z0-9 ]', '') $$;
