
-- WURL TRC 
--  '21 q3
    copy into WURL_VIEWERSHIP(channel, title, tot_airtime_min, occurances ,  tot_hov, tot_sessions , tot_completions  ,vs, month, deal_parent,territory_id, year, quarter, filename) 
    from (select  t.$2, t.$3, to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ',')),  to_number(REPLACE(t.$6, ','), 20, 5), to_number(REPLACE(t.$7, ','),9,2), to_number(REPLACE(t.$8, ',')),t.$9, t.$10, 16, 1, 2021, 'q3','trc_linear_2021_q3'
    from @wurl_viewership t) pattern='.*trc_linear_2021_q3.*' file_format = nosey_viewership 
    ON_ERROR=CONTINUE FORCE=TRUE;

 --  '21 q2
    copy into WURL_VIEWERSHIP(channel, title, tot_airtime_min, occurances ,  tot_hov, tot_sessions , tot_completions  ,vs, month, ref_id, monthly_share,share,  share_2, revenue, deal_parent,territory_id, year, quarter, filename) 
    from (select  t.$2, t.$3, to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ',')),  to_number(REPLACE(t.$6, ','), 20, 5), to_number(REPLACE(t.$7, ','),9,2), to_number(REPLACE(t.$8, ',')),t.$9, t.$10, t.$11, to_number(REPLACE(t.$14, '%'),6, 3 ), to_number(REPLACE(t.$15, '%'),6, 3 ),to_number(REPLACE(t.$16, '%'),6, 3 ),
    to_decimal(REPLACE(REPLACE(t.$17, '$'), ','),9, 3 ), 16, 1, 2021, 'q2','trc_linear_2021_q2'
    from @wurl_viewership t) pattern='.*trc_linear_2021_q2.*' file_format = nosey_viewership 
    ON_ERROR=CONTINUE FORCE=TRUE;

-- (pre-q2)
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_decimal(t.$3), to_number(REPLACE(t.$4, ',')),to_decimal(REPLACE(t.$5, ',')),  to_decimal(REPLACE(t.$6, ',')), to_decimal(REPLACE(t.$7, ',')), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%')), 16, 1 
from @wurl_viewership t) pattern='.*trc_linear.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;

   


