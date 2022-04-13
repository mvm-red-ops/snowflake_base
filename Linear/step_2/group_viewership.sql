-- //insert records into monthly_viewership
    insert into monthly_viewership (channel, year_month_day, deal_parent, tot_hov, quarter)
    select channel, year_month_day, deal_parent, sum(tot_hov), quarter from wurl_viewership where quarter = 'q4' and year = 2021 
    group by channel, year_month_day, deal_parent, year, quarter
    
    
-- sum quarterly viewership and enter
    insert into quarterly_viewership(deal_parent, tot_hov,year, quarter, channel, channel_id)
    select deal_parent, sum(tot_hov),2021, 'q4', channel, channel_id from wurl_viewership w
    where w.quarter = 'q4'  and w.year = 2021 and deal_parent = 16
    group by channel, channel_id, deal_parent
    