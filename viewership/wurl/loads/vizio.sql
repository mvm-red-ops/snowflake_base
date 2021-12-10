-- WURL VIZIO


-- q3
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ','), 15, 6),  to_number(REPLACE(t.$6, ','), 10, 5), to_number(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%'), 10, 4), to_number(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 20, 1,2021, 'q2', 'vizio_q2_2021_updated'
from @wurl_viewership t) pattern='.*vizio_q2_2021_updated.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUe;


-- q2 21
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ','), 15, 6),  to_number(REPLACE(t.$6, ','), 10, 5), to_number(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%'), 10, 4), to_number(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 20, 1,2021, 'q2', 'vizio_q2_2021'
from @wurl_viewership t) pattern='.*vizio_q2_2021.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUe;



copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ',')),  to_number(REPLACE(t.$6, ',')), to_number(REPLACE(t.$7, ',')), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%')), 20, 1  
from @wurl_viewership t) pattern='.*vizio.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;

