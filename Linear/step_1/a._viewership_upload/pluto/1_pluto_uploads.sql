-- PLUTO_VIEWERSHIP 
    -- pluto (download viewership from https://drive.google.com/drive/u/0/folders/1e6LqTWwMYQqZUrNNF5NjzyiM50vht5Uf)

        -- pluto us
        copy into PLUTO_VIEWERSHIP( year_month_day, series, title, clip_name, season_num, episode_num, TOTAL_VIEWERSHIP_MINUTES, sessions, revenue, deal_parent, territory_id, year,quarter,filename)
        from (select t.$1, t.$2, t.$3, t.$4, t.$5, t.$6, to_number(REPLACE(REPLACE(t.$7, '-', '0'), ','), 12, 0),  to_number(REPLACE(t.$8, ','), 12, 0), to_decimal(REPLACE(REPLACE(t.$9, '$'), ','), 12, 2), 29, 1, 2022, 'q1', 'only_US_pluto_q1_22.csv'
        from @distribution_partners t) pattern='.*only_US_pluto_q1_22.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;




        -- non-us grouped
            copy into PLUTO_VIEWERSHIP( clip_name, date_unformatted, revenue, deal_parent, territory_id, year, quarter, filename) 
            from (select t.$1, t.$2, to_number(REPLACE(REPLACE(REPLACE(t.$3, '- ', 0), '$'), ','), 12,2),  t.$4, t.$5, 2022, 'q1', 'non_US_pluto_q1_22' from @distribution_partners t) pattern='.*non_US_pluto_q1_22.*' file_format = nosey_viewership 
            ON_ERROR=CONTINUE FORCE=TRUE;

        -- SEPERATE 
            -- -- pluto uk
            -- copy into PLUTO_VIEWERSHIP( clip_name, revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
            -- from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, 29, 5, 2021, 'q4', 'pluto_uk_q4_21' from @distribution_partners t) pattern='.*pluto_uk_q4_21.*' file_format = nosey_viewership 
            -- ON_ERROR=CONTINUE FORCE=TRUE;

            
            -- -- pluto latam
            -- copy into PLUTO_VIEWERSHIP( clip_name,  revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
            -- from (select t.$1,  to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2),  t.$3, 29, 3, 2021, 'q4', 'pluto_latam_q4_21' from @distribution_partners t) pattern='.*pluto_latam_q4_21.*' file_format = nosey_viewership 
            -- ON_ERROR=CONTINUE FORCE=TRUE;



            -- -- pluto brazil
            -- copy into PLUTO_VIEWERSHIP( title, revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
            -- from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3,  29, 7, 2021, 'q4', 'pluto_brazil_q4_21' from @distribution_partners t) pattern='.*pluto_brazil_q4_21.*' file_format = nosey_viewership 
            -- ON_ERROR=CONTINUE FORCE=TRUE;








    -- HISTORICAL
    copy into PLUTO_VIEWERSHIP( year_month_day, channel, clip_name, title, total_viewership_minutes, sessions, share, revenue, content_provider, ref_id, year, quarter, series, deal_parent, territory_id, filename)
            from (select 
            t.$1, 
            t.$2, 
            t.$3, 
            t.$4, 
            to_number(REPLACE(REPLACE(t.$5, ','), ''), 25, 5),  
            to_number(REPLACE(t.$6, ','), 38, 0),  
            to_number(REPLACE(t.$7, '%'), 10, 7), 
            to_number(REPLACE(REPLACE(t.$8, '$', ''), ',', ''), 10, 3),
            t.$9,
            t.$10,
            REPLACE(t.$11, ','),
            t.$12,
            t.$13,
            t.$14,
            t.$15,
            'pluto_historical.csv'
            from @distribution_partners t) pattern='.*pluto_historical.*' file_format = nosey_viewership 
            ON_ERROR=SKIP_FILE FORCE=TRUE;