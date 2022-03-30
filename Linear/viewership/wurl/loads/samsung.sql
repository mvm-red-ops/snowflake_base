-- WURL Samsung
-- HAVE TO UPDATE TERRITORY_ID AND FILENAME
copy into WURL_VIEWERSHIP(date, title, ref_id, occurances,tot_hov, tot_sessions, mov_per_session, tot_completions, vs, deal_parent,territory_id, channel_id, year, quarter, filename) 
from (select 
      t.$1, 
      REPLACE(t.$2, ','),
      t.$3, 
      to_number(REPLACE(t.$4, ','), 5, 2), 
      to_number(REPLACE(t.$5, ','), 20, 5), 
      to_number(REPLACE(t.$6, ','), 9, 2),  
      to_number(REPLACE(t.$7, ','), 20, 8), 
      to_decimal(REPLACE(t.$8, ','), 10, 2),
      'Samsung', 18, TERRITORY_ID_GOES HERE, 13, 2021, 'q4', 'FILENAME HERE.csv'
from @distribution_partners t) pattern='.*FILENAME HERE.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;


-- OLD WURL Samsung
copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances ,tot_completions,tot_hov, tot_sessions,vs,month,ref_id,share,revenue, deal_parent,territory_id, year, quarter, filename) 
from (select t.$1, 
t.$2, 
      to_decimal(REPLACE(t.$2, ','), 15, 10), 
      to_number(REPLACE(t.$3, ','), 10, 1), 
      to_number(REPLACE(t.$4, ','), 15, 6),  
      to_number(REPLACE(t.$5, ','), 15, 6), 
      to_decimal(REPLACE(t.$6, ','), 11, 4),
      t.$7, t.$8,t.$9, 
      to_decimal(REPLACE(t.$12, '%'),  10, 5),
      t.$13, 
      18, 1 , 2021, 'q2', 'samsung_2021_q2.csv'
from @wurl_viewership t) pattern='.*samsung_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;
