-- WURL PLEX

-- q3
copy into WURL_VIEWERSHIP(channel, title, series_text, ref_id, tot_airtime_min, occurances, tot_hov, tot_sessions, avg_session_hov, tot_completions, vs, month, deal_parent,territory_id, channel_id, year, quarter, filename) 
from (select t.$1, t.$2,t.$3,t.$4, to_number(REPLACE(t.$5, ','), 10, 0), to_number(REPLACE(t.$6, ','), 10, 1),to_decimal(REPLACE(t.$7, ','), 15, 6),  to_decimal(REPLACE(t.$8, ','), 10, 2), to_decimal(REPLACE(t.$9, ','), 10, 5), to_number(REPLACE(t.$10, ','), 10, 2), t.$11, t.$12, 21, 1, 8, 2021, 'q3', ''  
from @wurl_viewership t) pattern='.*plex_nosey_july_21.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE; 


-- with revenue (as of q2 21)
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(t.$3, 15, 10), to_number(REPLACE(t.$4, ','), 10, 1),to_decimal(REPLACE(t.$5, ','), 15, 6),  to_decimal(REPLACE(t.$6, ','), 10, 5), to_decimal(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%'), 10, 5), to_decimal(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 21, 1, 2021, 'q2'  
from @wurl_viewership t) pattern='.*plex_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE; 


copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_decimal(t.$3, 15, 10), to_number(REPLACE(t.$4, ','), 10, 1),to_decimal(REPLACE(t.$5, ','), 15, 6),  to_decimal(REPLACE(t.$6, ','), 10, 5), to_decimal(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%'), 10, 5), 21, 1  
from @wurl_viewership t) pattern='.*plex.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;

-- 2020 q3 only
copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, to_decimal(t.$2, 15, 10), to_number(REPLACE(t.$3, ','), 10, 1), to_number(REPLACE(t.$4, ','), 15, 6),  to_number(REPLACE(t.$5, ','), 15, 6), to_decimal(REPLACE(t.$6, ','), 10, 5),t.$7, t.$8,t.$9, to_decimal(REPLACE(t.$12, '%'), 10, 5), 21, 1  
from @wurl_viewership t) pattern='.*plex_2020_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;





