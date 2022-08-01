-- viewership upload:


-- wurl_viewership 
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
        copy into wurl_viewership(date, title, ref_id, episode_number, genre, occurances,tot_hov, tot_sessions, mov_per_session, tot_completions, tot_airtime_min, channel_id, deal_parent, year, quarter, filename) 
        from (select 
            t.$1, 
            REPLACE(t.$2, ','),
            t.$3, 
            t.$4, 
            t.$5, 
            to_number(REPLACE(t.$6, ','), 5, 2), 
            to_number(REPLACE(t.$7, ','), 20, 5), 
            to_number(REPLACE(t.$8, ','), 9, 2),  
            to_number(REPLACE(t.$9, ','), 20, 8), 
            to_decimal(REPLACE(t.$10, ','), 10, 2),
            to_number(REPLACE(t.$11, ',')),
            t.$12,
            t.$13,
            2022, 'q1', 'wurl_q1_22.csv'
        from @distribution_partners t) pattern='.*wurl_q1_22.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;


    -- trc
        -- linear
           copy into wurl_viewership(channel, title, series_text,ref_id, tot_airtime_min, occurances,  tot_hov, tot_sessions , avg_session_hov, tot_completions, month,deal_parent,vs, territory_id, year, quarter, filename) 
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
            from @distribution_partners t) pattern='.*trc_linear_2021_q3.*' file_format = nosey_viewership 
            ON_ERROR=SKIP_FILE FORCE=TRUE;




   
        -- TRC VOD (data usually comes from the '20xx 1x TRC Nosey Baxter LLC Payout Report but might now include revenue from Roku dashboard)
        copy into wurl_viewership(title, revenue,deal_parent, territory_id, year, quarter, filename) 
        from (select  
                t.$1, 
                to_number(REPLACE(REPLACE(t.$2, ','), '$'), 9, 3),  
                25, 1, 2021, 'q3','trc_vod_2021_q3'
        from @distribution_partners t) pattern='.*trc_vod_2021_q3.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;

  

    -- vizio
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into wurl_viewership(channel, title, avg_session_hov, occurances ,tot_completions, tot_hov, tot_sessions,vs, month, ref_id, share, revenue, deal_parent,territory_id, year, quarter, filename) 
        from (select t.$1, t.$2, to_number(REPLACE(t.$3, ','), 15, 10), to_number(REPLACE(t.$4, ',')),to_number(REPLACE(t.$5, ','), 15, 6),  to_number(REPLACE(t.$6, ','), 10, 5), to_number(REPLACE(t.$7, ','), 10, 5), t.$8,t.$9, t.$10, to_number(REPLACE(t.$13, '%'), 10, 4), to_number(REPLACE(REPLACE(t.$14, '$'), ','), 9, 3), 20, 1,2021, 'q2', 'vizio_q2_2021_updated'
        from @distribution_partners t) pattern='.*vizio_q2_2021_updated.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUe;


    -- plex
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into wurl_viewership( channel,  title,  series_text,  ref_id,  tot_airtime_min,  occurances, tot_hov,  tot_sessions,  avg_session_hov,  tot_completions,  vs,  month,  deal_parent, territory_id,  channel_id,  year,  quarter,  filename) 
        from (
        select t.$1, t.$2,t.$3,t.$4, to_number(REPLACE(t.$5, ','), 10, 0), to_number(REPLACE(t.$6, ','), 10, 1),to_decimal(REPLACE(t.$7, ','), 15, 6), to_decimal(REPLACE(t.$8, ','), 10, 2), to_decimal(REPLACE(t.$9, ','), 10, 5), to_number(REPLACE(t.$10, ','), 10, 2),  t.$11,  t.$12, 21,  1,  9, 2021, 'q3', 'plex_nosey_july_21.csv'  
        from @distribution_partners t) pattern='.*plex_nosey_july_21.csv.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE; 



    -- WURL XUMO
        -- I THINK THIS IS OLD, JUST UPDATE BASED ON WURL DOWNLOAD
        copy into wurl_viewership(channel, title, play_count, total_time_watched, asset_duration, avg_play_time, avg_playthrough_rate, asset_id, month, share,ref_id,revenue, deal_parent, year, quarter,territory_id,  filename)
        from (select t.$1,t.$2, to_number(t.$3,7,0),t.$4, t.$5, t.$6, to_decimal(t.$7, 11, 10), t.$8, t.$9, to_decimal(REPLACE(t.$10, '%'),6,4), t.$11, to_number(REPLACE(REPLACE(t.$13, '$'), ','), 9, 3),17, 2021, 'q3' , 1,'xumo_2021_q2'
        from @distribution_partners t) pattern='.*xumo_2021_q2.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCe=TRUE;



    -- Tubi VOD
    copy into wurl_viewership(title, vs, quantity, estimated_revenue, deal_parent, year, quarter, filename)
    from ( select t.$1,t.$2, to_number(t.$3, 10, 2), to_number(t.$4, 20, 4), 40, 2022, 'q1', 'tubi_vod_q1_22.csv'
    from @distribution_partners t) pattern='.*tubi_vod_q1_22.csv.*' file_format = nosey_viewership 
    ON_ERROR=SKIP_FILE FORCe=TRUE;


    -- Youtube
    copy into wurl_viewership(content_id, title, publish_date, views, tot_hov, subscribers_gained, estimated_revenue, impressions, click_through_rate, deal_parent, year, quarter, filename)
    from ( select t.$1,t.$2, t.$3, to_number(t.$4, 12, 2), to_number(t.$5, 20,5), to_number(t.$6, 7,0), to_number(t.$7, 20, 4), to_number(t.$8, 12, 2),  to_number(t.$9, 3,0), 42, 2022, 'q1', 'youtube_q1_22.csv'
    from @distribution_partners t) pattern='.*youtube_q1_22.csv.*' file_format = nosey_viewership 
    ON_ERROR=SKIP_FILE FORCe=TRUE;



