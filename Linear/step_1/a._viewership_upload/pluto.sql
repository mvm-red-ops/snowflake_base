-- PLUTO_VIEWERSHIP 
    -- pluto (download viewership from https://drive.google.com/drive/u/0/folders/1e6LqTWwMYQqZUrNNF5NjzyiM50vht5Uf)

        -- pluto us
        copy into PLUTO_VIEWERSHIP( year_month_day, series, title, clip_name, TOTAL_VIEWERSHIP_MINUTES, sessions, revenue, deal_parent, territory_id, year,quarter,filename)
        from (select t.$1, t.$2, t.$3, t.$4, to_number(REPLACE(REPLACE(t.$5, '-', '0'), ','), 12, 0),  to_number(REPLACE(t.$6, ','), 12, 0), to_decimal(REPLACE(REPLACE(t.$7, '$'), ','), 12, 2), 29, 1, 2021, 'q4', 'pluto_us_q4_21.csv'
        from @distribution_partners t) pattern='.*pluto_us_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;

        -- pluto uk
        copy into PLUTO_VIEWERSHIP( clip_name, revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
        from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3, 29, 5, 2021, 'q4', 'pluto_uk_q4_21' from @distribution_partners t) pattern='.*pluto_uk_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUE;

        
        -- pluto latam
        copy into PLUTO_VIEWERSHIP( clip_name,  revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
        from (select t.$1,  to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2),  t.$3, 29, 3, 2021, 'q4', 'pluto_latam_q4_21' from @distribution_partners t) pattern='.*pluto_latam_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUE;



        -- pluto brazil
        copy into PLUTO_VIEWERSHIP( title, revenue, year_month_day, deal_parent, territory_id, year, quarter, filename) 
        from (select t.$1, to_number(REPLACE(REPLACE(REPLACE(t.$2, '- ', 0), '$'), ','), 12,2), t.$3,  29, 7, 2021, 'q4', 'pluto_brazil_q4_21' from @distribution_partners t) pattern='.*pluto_brazil_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=CONTINUE FORCE=TRUE;

