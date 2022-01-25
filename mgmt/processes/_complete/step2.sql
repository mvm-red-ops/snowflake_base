-- monthly viewership totals

//monthly viewership calculation by channel 
    select channel, month, deal_parent, sum(tot_hov) from wurl_viewership where quarter = 'q3' and year = 2021 
    group by channel, month, deal_parent


//insert records into monthly_viewership
    insert into monthly_viewership (channel, year_month_day, deal_parent,year, tot_hov, quarter)
    select channel, month, deal_parent, year, sum(tot_hov),quarter from wurl_viewership where quarter = 'q3' and year = 2021 
    group by channel, month, deal_parent, year, quarter


