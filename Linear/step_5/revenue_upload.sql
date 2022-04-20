-- copy the revenue_template into an empty excel sheet


    -- 47 samurai 
        -- Pull report from https://drive.google.com/drive/u/0/folders/16G2D-kiP8Eq1VMK1X1CpwrUFV8QxG-r8



    -- Samsung
        -- Rev source 1 Samsung TV+: https://drive.google.com/drive/u/0/folders/1EpyyNnXYXmrPqTsPiT8IkBYjOFBQLE7h
        -- Rev source 2, Samsung Aus: https://drive.google.com/drive/folders/1vf5dDUBHEmF2zVH_dhSeVEE0Agg9zOOs


    -- vizio 
        -- pull from https://drive.google.com/drive/folders/19fwaSnMIlmeqLTKENJjG18t-N_9NUbUS

    -- Xumo 
        -- Pull report from https://drive.google.com/drive/folders/14qLygzta3Ep6Vl-39OvULz1iG5tYauZY
        -- Use revenue next to "Content Partner Rev Share" on invoice

    -- KlowdTV 
        -- Pull report from https://drive.google.com/drive/folders/19ScTNTwpDOq6lMm-uy9-VEGsi-d87foi
        -- Use amount next to Net Revenue

    -- Freebie
        -- https://drive.google.com/drive/folders/1UheC1vcoYP5sIlUzfTbtdAIav_o7cyGY
        -- add the total rev for each month 

    -- Rlaxx
        -- https://drive.google.com/drive/u/0/folders/1yvWV_mWOhNs3B5-dOBSoVkPwz-gGv3wg
        -- sum the Hours watched (hhhh:mm:ss) to get the quarterly total
        -- divide each month by the total to get a share
        -- multiply the share times the revenue for the quarter
        -- convert Euros to Dollars

        copy into revenue (year_month_day, deal_parent, revenue, year, quarter, channel, channel_id, territory_id, impressions, device, costs, gross_revenue, cpms, partner_item_id)
        from (select t.$1, 
            t.$2,
            to_number(REPLACE(REPLACE(t.$3, '$'), ','), 12, 2), 
            t.$4,
            t.$5,
            t.$6,
            t.$7,
            t.$8,
            to_number(REPLACE(t.$9, ','), 16, 2),  
            t.$10,
            to_number(REPLACE(t.$11, ','), 10, 2),
            to_number(REPLACE(REPLACE(t.$12, '$'), ','), 12, 2), 
            to_number(REPLACE(t.$13, ','), 8, 2),
            t.$14
        from @DISTRIBUTION_PARTNERS_REVENUE t) pattern='.*revenue_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE;


-- Excluded from .csv


    -- Plex  (year_month_day, requests, impressions, gross eCPM, gross revenue, costs, share revenue)
        -- Download from https://reporting.plex.tv/ 
        -- 1) Select Ad Revenue
        -- 2) Top right: select date range of report
        -- 3) Run report"

copy into revenue(date_unformatted,	provider, partner, requests, impressions, cpms,gross_revenue, costs, revenue, channel, channel_id, year, quarter, deal_parent, year_month_day)
      from (select t.$1, 
            t.$2,
            t.$3,
            to_number(REPLACE(t.$4, ','), 15, 0), 
            to_number(REPLACE(t.$5, ','), 16, 2), 
            to_number(REPLACE(t.$6, ','), 8, 2), 
            to_number(REPLACE(REPLACE(t.$7, '$'), ','), 12, 2), 
            to_number(REPLACE(REPLACE(t.$8, '$'), ','), 10, 2), 
            to_number(REPLACE(REPLACE(t.$11, '$'), ','), 10, 2), 
            t.$12,
            t.$13,
            t.$14,
            t.$15,
            t.$16,
            t.$17
        from @distribution_partners_revenue t) pattern='.*plex_revenue_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE;

    -- TRC 
        -- https://drive.google.com/drive/u/0/folders/143HGCGPsyWCyUJa4FSjbTrUy4pU58Bwo

        -- Linear
            -- The Channels listed at the top of the file are the total revenue for the quarter for those channels for TRC Linear
            -- Upload those into the quarterly_revenue table 
            -- monthly revenue is determined by monthly viewership share 


        -- VOD (already included in the viewership data)
            -- The sum of the viewership record's revenue is the total quarterly revenue for TRC VOD 
            -- sum revenue from wurl_viewership where deal_parent = 25 to get quarterly revenue
            -- insert quarterly_revenue / 3, insert into monthly_revenue table


