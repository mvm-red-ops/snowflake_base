--SAMSUNG HISTORICAL
copy into WURL_VIEWERSHIP(title, AVG_SESSION_HOV, occurances, tot_completions,tot_hov, tot_sessions, vs, year_month_day, ref_id, content_provide, series,  share, year, quarter,territory_id, channel_id, deal_parent, filename) 
from (select 
    REPLACE(t.$1, ','),
    to_number(t.$2, 15, 10)
    to_number(REPLACE(t.$3, ','), 5, 2), 
    to_number(REPLACE(t.$4, ','), 10, 2), 
    to_number(REPLACE(t.$5, ','), 20, 5), 
    to_number(REPLACE(t.$6, ','), 9, 2),  
    t.$7, 
    t.$8, 
    t.$9, 
    t.$10, 
    t.$11, 
    to_number(REPLACE(t.$12, ','), 11, 8),
    t.$13, 
    t.$14, 
    1,
    8,
    18, 
    'samsung_historical.csv'
from @distribution_partners t) pattern='.*samsung_historical.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;


--TRC LINEAR HISTORICAL
    copy into WURL_VIEWERSHIP(title, avg_session_hov, occurances,  tot_completions, tot_hov, tot_sessions, vs, year_month_day,  ref_id, content_provider, series, share, territory_id, channel_id, year, quarter,deal_parent, filename) 
        from (
            select  
            REPLACE(t.$1, '"'), 
            to_number(t.$2 ,15, 10), 
            to_number( t.$3, 5, 2), 
            to_number( t.$4, 10, 2), 
            to_number( t.$5, 20, 5), 
            to_number( t.$6, 9, 2), 
            t.$7, 
            t.$8, 
            t.$9, 
            t.$10, 
            t.$11, 
            to_number( REPLACE(t.$12, '%'), 11, 8), 
            t.$13, 
            t.$14, 
            t.$15, 
            t.$16, 
            16,'trc_linear_historical'
        from @distribution_partners t) pattern='.*trc_linear_historical.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUE;

-- TRC VOD HISTORICAL 
    copy into WURL_VIEWERSHIP(title, revenue, ref_id, series, content_provider, share, year, quarter, deal_parent, territory_id, filename) 
    from (select  
            t.$1, 
            to_number(REPLACE(REPLACE(t.$2, ','), '$'), 9, 3),  
            t.$3, 
            t.$4, 
            t.$5,  
            to_number(REPLACE(t.$6, '%'),11, 8),  
            t.$7,  
            t.$8,  
            25, 
            1, 
            'trc_vod_historical'
    from @distribution_partners t) pattern='.*trc_vod_historical.*' file_format = nosey_viewership 
    ON_ERROR=CONTINUE FORCE=TRUE;


-- Xumo Historical
copy into WURL_VIEWERSHIP(channel, title, play_count, total_time_watched, asset_duration, avg_play_time, avg_playthrough_rate, asset_id, share,ref_id,revenue, year, quarter, year_month_day, content_provider, deal_parent, territory_id, filename)
from (select t.$1,t.$2, to_number(t.$3,7,0), t.$4, t.$5, t.$6, to_decimal(t.$7, 11, 10), t.$8, to_decimal(REPLACE(t.$9, '%'),6,4), t.$10, to_number(REPLACE(REPLACE(t.$11, '$'), ','), 9, 3), t.$12, t.$13, t.$14, t.$15, 17, 1 ,'xumo_historical'
from @distribution_partners t) pattern='.*xumo_historical.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCe=TRUE;



-- PLEX HISTORICAL
copy into WURL_VIEWERSHIP(title, AVG_SESSION_HOV, occurances, tot_completions,tot_hov, tot_sessions, vs, year_month_day, ref_id, content_provider, series, share, year, quarter, channel,revenue,territory_id, deal_parent, filename) 
from (select 
    REPLACE(t.$1, ','),
    to_number(t.$2, 15, 10),
    to_number(REPLACE(t.$3, ','), 5, 2), 
    to_number(REPLACE(t.$4, ','), 10, 2), 
    to_number(REPLACE(t.$5, ','), 20, 5), 
    to_number(REPLACE(t.$6, ','), 9, 2),  
    t.$7, 
    t.$8, 
    t.$9, 
    t.$10, 
    t.$11, 
    to_number(REPLACE(t.$12, '$'), 11, 8),
    t.$13, 
    t.$14, 
    t.$15, 
    to_number(REPLACE(REPLACE(t.$16, '$'), ','), 15, 7),
    1,
    8,
    21, 
    'plex_historical.csv'
from @distribution_partners t) pattern='.*plex_historical.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;


-- Future Today Historical
copy into WURL_VIEWERSHIP(year_month_day, title,revenue,ref_id, content_provider, year, quarter, deal_parent, territory_id, filename)
from (select t.$1,t.$2, to_number(REPLACE(REPLACE(t.$11, '$'), ','), 15, 6), t.$4, t.$5, t.$6, t.$, 32, 1 ,'future_today_historical'
from @distribution_partners t) pattern='.*future_today_historical.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCe=TRUE;


