-- monthly viewership totals

-- //update year_month_day column in wurl_viewership using month column (trc linear already uses year_month_day)
-- //update wurl_viewership
-- //set year_month_day = '20211001'
-- //where quarter = 'q4' and year = 2021 and year_month_day is null and month like '%10%'
    select month from wurl_viewership where quarter = 'q4' and year = 2021 and year_month_day is null and month like '%10%'

-- //monthly viewership calculation by channel 
    select channel, year_month_day, deal_parent, sum(tot_hov) from wurl_viewership where quarter = 'q4' and year = 2021 
    group by channel, year_month_day, deal_parent





-- //insert records into monthly_viewership
    insert into monthly_viewership (channel, year_month_day, deal_parent, tot_hov, quarter)
    select channel, year_month_day, deal_parent, sum(tot_hov), quarter from wurl_viewership where quarter = 'q4' and year = 2021 
    group by channel, year_month_day, deal_parent, year, quarter
    
    
-- sum quartler viewership and enter
    insert into quarterly_viewership(deal_parent, tot_hov,year, quarter, channel, channel_id)
    select deal_parent, sum(tot_hov),2021, 'q4', channel, channel_id from wurl_viewership w
    where w.quarter = 'q4'  and w.year = 2021 and deal_parent = 16
    group by channel, channel_id, deal_parent
    