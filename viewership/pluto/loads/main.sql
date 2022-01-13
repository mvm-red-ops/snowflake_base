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
    territory_id,
    year,quarter,filename)
from (select t.$1, t.$2, t.$3, to_number(REPLACE(REPLACE(t.$4, '-', '0'), ','), 12, 0),  to_number(REPLACE(t.$5, ','), 12, 0), to_decimal(REPLACE(REPLACE(t.$6, '$'), ','), 12, 2),t.$7, 29, 1, 2021, 'q2', 'pluto_2021_q2.csv'
from @pluto_viewership t) pattern='.*pluto_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;

--- PLUTO US 2021 Q3
copy into PLUTO_VIEWERSHIP(
    month,
    series_name,
    clip_name,
    total_viewing_minutes,
    sessions,
    revenue_by_title,
    deal_parent,
    territory_id,
    year, quarter, filename)
from (select t.$1, t.$2, t.$3, to_number(REPLACE(REPLACE(t.$4, '-', '0'), ','), 12, 0),  to_number(REPLACE(t.$5, ','), 12, 0), to_decimal(REPLACE(REPLACE(t.$6, '$'), ','), 12, 2), 29, 1, 2021, 'q3', 'pluto_2021_q3.csv'
from @pluto_viewership t) pattern='.*pluto_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;


-- PLUTO UK
copy into PLUTO_VIEWERSHIP( title, total_revenue, month, ref_id, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, t.$4, 29, 5, 2021, 'q2', 'pluto_uk_2021_q2' from @pluto_viewership t) pattern='.*pluto_uk_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;

--- PLUTO UK 2021 q3
copy into PLUTO_VIEWERSHIP(title, total_revenue, month, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, 29, 5, 2021, 'q3', 'pluto_uk_2021_q3' from @pluto_viewership t) pattern='.*pluto_uk_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;
   
  
-- pluto lam
copy into PLUTO_VIEWERSHIP( title, total_revenue, month, ref_id, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, t.$4, 29, 3, 2021, 'q2', 'pluto_lam_2021_q2' from @pluto_viewership t) pattern='.*pluto_lam_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;

---pluto lam 2021 q3
copy into PLUTO_VIEWERSHIP(title, month, total_revenue, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(REPLACE(REPLACE(REPLACE(t.$3, '- ', 0), '$'), ','), 12,2), 29, 3, 2021, 'q3', 'pluto_lam_2021_q3' from @pluto_viewership t) pattern='.*pluto_lam_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;


-- pluto brazil
copy into PLUTO_VIEWERSHIP( title, total_revenue, month, ref_id, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, t.$4, 29, 7, 2021, 'q2', 'pluto_brazil_2021_q2' from @pluto_viewership t) pattern='.*pluto_brazil_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;

---pluto brazil 2021 q3
copy into PLUTO_VIEWERSHIP( title, month, total_revenue, deal_parent, territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(REPLACE(REPLACE(REPLACE(t.$3, '- ', 0), '$'), ','), 12,2), 29, 7, 2021, 'q3', 'pluto_brazil_2021_q3' from @pluto_viewership t) pattern='.*pluto_brazil_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;
