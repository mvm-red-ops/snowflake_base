-- WURL PLEX
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