-- WURL Samsung
copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances ,tot_completions,tot_hov, tot_sessions,vs,month,ref_id,share, deal_parent,territory_id) 
from (select t.$1, to_decimal(t.$2, 15, 10), to_number(REPLACE(t.$3, ','), 10, 1), to_number(REPLACE(t.$4, ','), 15, 6),  to_number(REPLACE(t.$5, ','), 15, 6), to_decimal(REPLACE(t.$6, ','), 11, 4),t.$7, t.$8,t.$9, to_decimal(REPLACE(t.$12, '%'), 10, 5), 18  
, 1  from @wurl_viewership t) pattern='.*samsung.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;


-- WURL VIZIO
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_decimal(t.$3), to_number(REPLACE(t.$4, ',')),to_decimal(REPLACE(t.$5, ',')),  to_decimal(REPLACE(t.$6, ',')), to_decimal(REPLACE(t.$7, ',')), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%')), 20, 1  
from @wurl_viewership t) pattern='.*vizio.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;



-- WURL PLEX
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_decimal(t.$3, 15, 10), to_number(REPLACE(t.$4, ','), 10, 1),to_decimal(REPLACE(t.$5, ','), 15, 6),  to_decimal(REPLACE(t.$6, ','), 10, 5), to_decimal(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%'), 10, 5), 21, 1  
from @wurl_viewership t) pattern='.*plex.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;
    -- q3 only
    copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
    from (select t.$1, to_decimal(t.$2, 15, 10), to_number(REPLACE(t.$3, ','), 10, 1), to_number(REPLACE(t.$4, ','), 15, 6),  to_number(REPLACE(t.$5, ','), 15, 6), to_decimal(REPLACE(t.$6, ','), 10, 5),t.$7, t.$8,t.$9, to_decimal(REPLACE(t.$12, '%'), 10, 5), 21, 1  
    from @wurl_viewership t) pattern='.*plex_2020_q3.*' file_format = nosey_viewership 
    ON_ERROR=CONTINUE FORCE=TRUE;



-- WURL XUMO
copy into WURL_VIEWERSHIP(channel, title, play_count, total_time_watched, asset_duration, avg_play_time, avg_playthrough_rate, asset_id, month, share,ref_id, deal_parent)
from (select t.$1,t.$2, to_number(t.$3,7,0),t.$4, t.$5, t.$6, to_decimal(t.$7, 11, 10), t.$8, t.$9, to_decimal(REPLACE(t.$10, '%'),6,4), t.$11, 17 from @wurl_viewership t) pattern='.*xumo.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;

-- WURL TRC (pre-q2)
copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, deal_parent,territory_id) 
from (select t.$1, t.$2, to_decimal(t.$3), to_number(REPLACE(t.$4, ',')),to_decimal(REPLACE(t.$5, ',')),  to_decimal(REPLACE(t.$6, ',')), to_decimal(REPLACE(t.$7, ',')), t.$8,t.$9, t.$10, to_decimal(REPLACE(t.$13, '%')), 16, 1  
from @wurl_viewership t) pattern='.*trc_linear.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE;

    -- post '21 q2
    copy into WURL_VIEWERSHIP(channel, title, tot_airtime_min, occurances ,  tot_hov, tot_sessions , tot_completions  ,vs, month, ref_id, monthly_share,share,  share_2, revenue, deal_parent,territory_id) 
    from (select  t.$2, t.$3, to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ',')),  to_number(REPLACE(t.$6, ',')), to_number(REPLACE(t.$7, ',')), to_number(REPLACE(t.$8, ',')),t.$9, t.$10, t.$11, to_number(REPLACE(t.$14, '%'),6, 3 ), to_number(REPLACE(t.$15, '%'),6, 3 ),to_number(REPLACE(t.$16, '%'),6, 3 ),
    to_decimal(REPLACE(t.$17, ','),9, 3 ), 16, 1
    from @wurl_viewership t) pattern='.*trc_linear.*' file_format = nosey_viewership 
    ON_ERROR=CONTINUE;




