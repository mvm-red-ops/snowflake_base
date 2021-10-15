// Copy command with pattern for file names

COPY INTO NOSEY.PUBLIC.PLUTO_VIEWERSHIP
    FROM @MANAGE_DB.external_stages.nosey_aws;    
    file_format= @NOSEY_ASSETS
    pattern='.*Pluto.*'
    ON_ERROR=CONTINUE;
    

-- PLUTO US
copy into PLUTO_VIEWERSHIP(
    month,
    parnter_name,
    clip_name,
    total_viewing_minutes,
    sessions,
    revenue_by_title,
    ref_id,
    deal_parent,
    territory_id)
from (select t.$1, t.$2, t.$3, to_number(REPLACE(REPLACE(t.$4, '-', '0'), ','), 12, 0),  to_number(REPLACE(t.$5, ','), 12, 0), to_decimal(REPLACE(REPLACE(t.$6, '$'), ','), 12, 2),t.$7, 29, 1  
from @pluto_viewership t) pattern='.*pluto.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;

-- PLUTO UK
copy into PLUTO_VIEWERSHIP( title, total_revenue, month, ref_id, deal_parent) 
from (select t.$1, to_number(REPLACE(t.$2, ' $ - ', null)), t.$3, t.$4, 5 from @pluto_viewership t) pattern='.*uk.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE = TRUE;
   
  
   
LIST @pluto_viewership;    



