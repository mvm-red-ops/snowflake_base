-- the first part of the o and o process is to upload the three main data sets: 
    -- powr_viewership
    -- gam_data
    -- spotx_data

        -- powr_viewership is the only pure viewership data that is in the o and o database. it is sent directly to our team
        -- gam_data is an ad partner
        -- spotx_data is an adserving partner which helps place ads on different platforms


-- upload procedures

-- powr_viewership
    -- fields to update: 
        --  filename, year, quarter, pattern (replace where there is an 'X')

    copy into powr_viewership(
    uid, 
    title, 
    type, 
    channel, 
    views, 
    watch_time_seconds, 
    average_watch_time_seconds, 
    platform, 
    geo, 
    year_month_day,
    quarter,
    year,
    filename
    )   
    from (select t.$1, t.$2, t.$3, t.$4, to_number(REPLACE(t.$5, ','), 12, 2), to_decimal(REPLACE(t.$6,  ','), 12, 2), to_number(REPLACE(REPLACE(t.$7, '-', ''), ','), 16, 6), t.$8, t.$9, t.$10, 'qX', 202X,  'powr_viewership_qX_202X.csv'
    from @owned_and_operated t) pattern='.*powr_viewership_qX_202X.*' file_format = nosey_viewership 
    ON_ERROR=SKIP_FILE FORCE=TRUE;


-- gam_data
    -- fields to update: 
        --  filename, year, quarter, pattern (replace where there is an 'X')

        copy into gam_data (
        advertiser,
        ad_unit,
        month_year,
        advertiser_id,
        ad_unit_id,
        total_code_served,
        total_impressions,
        ad_exchange_revenue,
        quarter, 
        year, 
        filename
        )
        from (select t.$1, t.$2, t.$3, t.$4, t.$5, to_number(REPLACE(t.$6,  ','), 15, 0), to_number(REPLACE(t.$7,  ','), 15, 0), to_number(REPLACE(t.$8,  ','), 15, 2), 'qX', 202X,  'gam_qX_202X.csv'
        from @oo_ad_data t) pattern='.*gam_qX_20XX.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;




-- spotx
    -- fields to update: 
        --  filename, year, quarter, pattern (replace where there is an 'X')
        
        copy into spotx (
        timestamp,
        channel_name,
        deal_demand_source,
        deal_name,
        placements,
        gross_revenue,
        impressions,
        quarter,
        year,
        filename
        )
        from (select t.$1, t.$2, t.$3, t.$4, to_number(REPLACE(t.$5, ','), 10, 0), to_number(REPLACE(t.$6, ','), 10,5), to_number(REPLACE(t.$7, ','), 12, 0),  'qX', 202X,  'spotx_revenue_qX_202X.csv'
        from @oo_revenue t) pattern='.*spotx_revenue_qX_202X.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE; 
