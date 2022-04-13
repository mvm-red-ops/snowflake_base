-- viewership upload:


-- WURL_VIEWERSHIP 
    -- All pulled from Wurl Sigma Dashboard

    -- "Populating Viewership Data
    -- 1) Go to WURL Sigma dashboard via Keeper
    -- 2) Click on Data Portal
    -- 2) Go to ""Aggregate Data"" tab
    -- 3) Filter the dates for the quarter
    -- 4) Filter 
            -- a)Streamer  (Vizio, Samsung, etc.)
            -- b)Channel  (Nosey, Real Nosey, etc.)
            -- c)Territory  (US, UK, Brazil)
    -- 5) Download data for that channel, streamer and territory
    -- 7) Repeat until all combinations are downloaded
            -- ex Download 1: Samsung Nosey US
            --  Download 2: Samsung Nosey Escandalos Brazil
            --  Download 2: Samsung Nosey Escandalos Mexico


    -- samsung 
        -- territory (territory_id)
        -- us (1)
        -- brazil (7)
        -- mexico (8)

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






    -- trc
        -- linear
           copy into WURL_VIEWERSHIP(channel, title, series_text,ref_id, tot_airtime_min, occurances,  tot_hov, tot_sessions , avg_session_hov, tot_completions, month,deal_parent,vs, territory_id, year, quarter, filename) 
            from (select  
                t.$1, 
                t.$2, 
                REPLACE(t.$3, '"'), 
                t.$4, 
                to_number(REPLACE(t.$5, ','), 10), 
                to_number(REPLACE(t.$6, ','), 5, 2),  
                to_number(REPLACE(t.$7, ','), 20, 5), 
                to_number(REPLACE(t.$8, ','),9, 2), 
                to_number(REPLACE(t.$9, ','),9,2), 
                to_number(REPLACE(t.$10, ','), 10, 2), 
                t.$11, 
                16, 'Roku', 1, 2021, 'q3','trc_linear_2021_q3'
            from @wurl_viewership t) pattern='.*trc_linear_2021_q3.*' file_format = nosey_viewership 
            ON_ERROR=CONTINUE FORCE=TRUE;

        -- VOD
        copy into WURL_VIEWERSHIP(title, revenue,deal_parent, territory_id, year, quarter, filename) 
        from (select  
                t.$1, 
                to_number(REPLACE(REPLACE(t.$2, ','), '$'), 9, 3),  
                25, 1, 2021, 'q3','trc_vod_2021_q3'
        from @wurl_viewership t) pattern='.*trc_vod_2021_q3.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUE;





    -- vizio
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into WURL_VIEWERSHIP(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
        from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ','), 15, 6),  to_number(REPLACE(t.$6, ','), 10, 5), to_number(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%'), 10, 4), to_number(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 20, 1,2021, 'q2', 'vizio_q2_2021_updated'
        from @wurl_viewership t) pattern='.*vizio_q2_2021_updated.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUe;

    -- plex
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into WURL_VIEWERSHIP( channel,  title,  series_text,  ref_id,  tot_airtime_min,  occurances, tot_hov,  tot_sessions,  avg_session_hov,  tot_completions,  vs,  month,  deal_parent, territory_id,  channel_id,  year,  quarter,  filename) 
        from (
        select t.$1, t.$2,t.$3,t.$4, to_number(REPLACE(t.$5, ','), 10, 0), to_number(REPLACE(t.$6, ','), 10, 1),to_decimal(REPLACE(t.$7, ','), 15, 6), to_decimal(REPLACE(t.$8, ','), 10, 2), to_decimal(REPLACE(t.$9, ','), 10, 5), to_number(REPLACE(t.$10, ','), 10, 2),  t.$11,  t.$12, 21,  1,  9, 2021, 'q3', 'plex_nosey_july_21.csv'  
        from @wurl_viewership t) pattern='.*plex_nosey_july_21.csv.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE; 



    -- WURL XUMO
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into WURL_VIEWERSHIP(channel, title, play_count, total_time_watched, asset_duration, avg_play_time, avg_playthrough_rate, asset_id, month, share,ref_id,revenue, deal_parent, year, quarter,filename)
        from (select t.$1,t.$2, to_number(t.$3,7,0),t.$4, t.$5, t.$6, to_decimal(t.$7, 11, 10), t.$8, t.$9, to_decimal(REPLACE(t.$10, '%'),6,4), t.$11, to_number(REPLACE(REPLACE(t.$13, '$'), ','), 9, 3),17, 2021, 'q2' ,'xumo_2021_q2'
        from @nosey_viewership t) pattern='.*xumo_2021_q2.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCe=TRUE;
