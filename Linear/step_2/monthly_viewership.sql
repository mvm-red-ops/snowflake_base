-- Wurl
    -- insert records into monthly_viewership
        insert into monthly_viewership (channel, channel_id, year_month_day, deal_parent, tot_hov, year, quarter)
        select channel, channel_id, year_month_day, deal_parent, sum(tot_hov),year, quarter from wurl_viewership 
        where quarter = 'q4' and year = 2021 and tot_hov is not null and deal_parent != 16
        group by channel,channel_id, year_month_day, deal_parent, year, quarter
        
    -- sum quarterly viewership and enter
        insert into quarterly_viewership(deal_parent, tot_hov,year, quarter, channel, channel_id, platform)
        select deal_parent, sum(tot_hov),year, quarter, channel, channel_id, 'wurl' from wurl_viewership 
        where quarter = 'q4'  and  year = 2021 and deal_parent = 16
        group by channel, channel_id, deal_parent,year, quarter
        
        
-- Amagi
    -- amagi monthly_viewership
    select sum(TOTAL_VIEWERSHIP_MINUTES), year_month_day, deal_parent, channel from amagi_viewership 
    where year = 2021 and quarter = 'q4' group by year_month_day, deal_parent, channel


    insert into monthly_viewership (channel, channel_id, year_month_day, tot_hov, year, quarter, deal_parent, platform)
    select channel, channel_id, year_month_day, sum(TOTAL_VIEWERSHIP_MINUTES),year, quarter, deal_parent, 'amagi' from amagi_viewership 
    where quarter = 'q4' and year = 2021 
    group by channel,channel_id, year_month_day, year, quarter,deal_parent
