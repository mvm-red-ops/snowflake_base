
-- WURL Samsung
copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances ,tot_completions,tot_hov, tot_sessions,vs,month,ref_id,share,revenue, deal_parent,territory_id) 
from (select t.$1, 
      to_decimal(REPLACE(t.$2, ','), 15, 10), 
      to_number(REPLACE(t.$3, ','), 10, 1), 
      to_number(REPLACE(t.$4, ','), 15, 6),  
      to_number(REPLACE(t.$5, ','), 15, 6), 
      to_decimal(REPLACE(t.$6, ','), 11, 4),
      t.$7, t.$8,t.$9, 
      to_decimal(REPLACE(t.$12, '%'),  10, 5),
      t.$13, 
      18, 1  
from @wurl_viewership t) pattern='.*samsung_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;


