
-- Amagi
    -- amagi monthly_viewership (rlaxx-22 and freebie-27 don't have viewership data,)
    select channel_id, year_month_day, sum(tot_hov), territory_id, year, quarter, deal_parent from amagi_viewership 
    where year = 2022 and quarter = 'q1'and deal_parent not in (22,27) 
    group by year_month_day, deal_parent, channel_id,territory_id, year,quarter
    
    -- insert
    insert into monthly_viewership (channel_id, year_month_day, tot_hov,territory_id, year, quarter, deal_parent, platform)
    select channel_id, year_month_day, sum(tot_hov), territory_id, year, quarter, deal_parent from amagi_viewership 
    where year = 2022 and quarter = 'q1'and deal_parent not in (22,27) 
    group by year_month_day, deal_parent, channel_id,territory_id, year,quarter
    


-- Wurl (We don't get viewerhip data from Tubi or TRC VOD)
    -- wurl by month, channel
        insert into monthly_viewership (channel, channel_id, year_month_day, deal_parent, tot_hov, year, quarter)
        select channel, channel_id, year_month_day, deal_parent, sum(tot_hov),year, quarter from wurl_viewership 
        where quarter = 'q1' and year = 2022 and tot_hov is not null and deal_parent not in (16, 25, 40)
        group by channel,channel_id, year_month_day, deal_parent, year, quarter
        

    -- wurl by month, channel
        insert into monthly_viewership ( channel_id, year_month_day, tot_hov, year, quarter, deal_parent,territory_id, platform)
        select  channel_id, year_month_day, sum(tot_hov),year, quarter, deal_parent,territory_id, 'wurl' from wurl_viewership 
        where quarter = 'q1' and year = 2022 
        group by channel_id, year_month_day, year, quarter,deal_parent, territory_id


    -- The Roku Channel (done quarterly) 
        insert into quarterly_viewership(deal_parent, tot_hov,year, quarter, channel, channel_id)
        select deal_parent, sum(tot_hov),year, quarter, channel, channel_id from wurl_viewership 
        where quarter = 'q1'  and  year = 2022 and deal_parent = 16
        group by channel, channel_id, deal_parent,year, quarter
        
        

