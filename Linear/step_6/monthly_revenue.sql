--revenue to monthly revenue 
-- check revenue table sum by deal_parent, month, channel, etc
select sum(revenue), deal_parent, year_month_day, year, quarter, channel, channel_id from revenue where year = 2021 and quarter = 'q4'
group by deal_parent, year_month_day, year, quarter, channel, channel_id

-- insert into monthly revenue
insert into monthly_revenue(revenue, deal_parent, year_month_day, year, quarter, channel_id )
select sum(revenue), deal_parent, year_month_day, year, quarter, channel_id from revenue 
where year = 2021 and quarter = 'q4' 
group by deal_parent, year_month_day, year, quarter, channel_id




-- TRC VOD 
    -- Update year_month_day field and repeat for each month in quarter: '20211201', etc.
    insert into monthly_revenue(revenue,year_month_day, deal_parent, year, quarter, channel_id)
    select revenue /3, '1 month at a time here', deal_parent, year, quarter, channel_id from quarterly_revenue 
    where  quarter = 'q4' and year = 2021 and deal_parent = 25

    -- TRC Linear
    update wurl_viewership wv
    set wv.revenue = q.rev_share
    from(  
        select w.id as id, r.revenue * w.share  as rev_share from wurl_viewership w
        join quarterly_revenue r on (r.quarter = w.quarter and r.year = w.year and r.deal_parent = w.deal_parent and r.channel_id = w.channel_id)
        where w.deal_parent = 16  and w.year = 2021 and w.quarter = 'q4'
    
    ) q
    where wv.id = q.id
